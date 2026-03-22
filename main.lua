--==================================
-- FPLIZ HUB PRO | XENO VERSION
--==================================

repeat task.wait() until game:IsLoaded()
task.wait(5)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- LOAD UI (FIX XENO)
local OrionLib = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/shlexware/Orion/main/source"
,true))()

------------------------------------------------
-- WINDOW
------------------------------------------------
local Window = OrionLib:MakeWindow({
	Name = "FPLIZ HUB PRO ⛩️",
	SaveConfig = true,
	ConfigFolder = "FplizHub",
	IntroText = "FPLIZ HUB CARREGADO 🔥"
})

OrionLib:MakeNotification({
	Name = "FPLIZ HUB",
	Content = "Executado com sucesso!",
	Time = 5
})

------------------------------------------------
-- KEYBIND (RightShift)
------------------------------------------------
UIS.InputBegan:Connect(function(input,gp)
	if input.KeyCode == Enum.KeyCode.RightShift then
		OrionLib:ToggleUI()
	end
end)

------------------------------------------------
-- MOVIMENTAÇÃO
------------------------------------------------
local Move = Window:MakeTab({Name="Movimentação ⚡"})

Move:AddSlider({
	Name="Speed",
	Min=16,Max=200,Default=16,
	Callback=function(v)
		Humanoid.WalkSpeed=v
	end
})

Move:AddSlider({
	Name="JumpPower",
	Min=50,Max=200,Default=50,
	Callback=function(v)
		Humanoid.JumpPower=v
	end
})

-- Infinite Jump
local infjump=false
Move:AddToggle({
	Name="Infinite Jump",
	Default=false,
	Callback=function(v)
		infjump=v
	end
})

UIS.JumpRequest:Connect(function()
	if infjump then
		Humanoid:ChangeState("Jumping")
	end
end)

-- Noclip
local noclip=false
Move:AddToggle({
	Name="Noclip",
	Default=false,
	Callback=function(v)
		noclip=v
	end
})

RunService.Stepped:Connect(function()
	if noclip then
		for _,v in pairs(Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide=false
			end
		end
	end
end)

------------------------------------------------
-- FLY
------------------------------------------------
local FlyTab = Window:MakeTab({Name="Fly 🕊️"})

local flying=false
local bv,bg

FlyTab:AddToggle({
	Name="Fly",
	Default=false,
	Callback=function(state)
		flying=state

		if flying then
			bv=Instance.new("BodyVelocity",HRP)
			bg=Instance.new("BodyGyro",HRP)
			bg.MaxTorque=Vector3.new(math.huge,math.huge,math.huge)

			RunService.RenderStepped:Connect(function()
				if flying then
					bv.Velocity=workspace.CurrentCamera.CFrame.LookVector*80
					bg.CFrame=workspace.CurrentCamera.CFrame
				end
			end)
		else
			if bv then bv:Destroy() end
			if bg then bg:Destroy() end
		end
	end
})

------------------------------------------------
-- TROLL (FLING)
------------------------------------------------
local Troll = Window:MakeTab({Name="Troll 😈"})

Troll:AddButton({
	Name="Fling (encoste no player)",
	Callback=function()
		local spin=Instance.new("BodyAngularVelocity",HRP)
		spin.AngularVelocity=Vector3.new(99999,99999,99999)
		spin.MaxTorque=Vector3.new(math.huge,math.huge,math.huge)
		task.wait(2)
		spin:Destroy()
	end
})

------------------------------------------------
-- CLICK TELEPORT
------------------------------------------------
local Tp = Window:MakeTab({Name="Teleport 📍"})

local clicktp=false

Tp:AddToggle({
	Name="Click TP",
	Default=false,
	Callback=function(v)
		clicktp=v
	end
})

local mouse=Player:GetMouse()
mouse.Button1Down:Connect(function()
	if clicktp then
		HRP.CFrame=CFrame.new(mouse.Hit.Position+Vector3.new(0,3,0))
	end
end)

Tp:AddButton({
	Name="Banco",
	Callback=function()
		HRP.CFrame=CFrame.new(-33,23,-164)
	end
})

Tp:AddButton({
	Name="Hospital",
	Callback=function()
		HRP.CFrame=CFrame.new(120,25,-300)
	end
})

Tp:AddButton({
	Name="Lago",
	Callback=function()
		HRP.CFrame=CFrame.new(-330,25,-450)
	end
})

------------------------------------------------
OrionLib:Init()
