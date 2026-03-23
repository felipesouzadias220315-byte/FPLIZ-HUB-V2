--==================================
-- FPLIZ HUB GOD 👑 | KEY VERSION
--==================================

repeat task.wait() until game:IsLoaded()

------------------------------------------------
-- SAFE LOAD ORION
------------------------------------------------
local OrionLib
repeat
	local success
	success, OrionLib = pcall(function()
		return loadstring(game:HttpGet(
			"https://raw.githubusercontent.com/shlexware/Orion/main/source"
		))()
	end
	task.wait(2)
until OrionLib

------------------------------------------------
-- KEY SYSTEM SAVE 🔐
------------------------------------------------

local CorrectKey = "FPLIZ-GOD-2026"
local KeyFile = "FplizKey.txt"
local KeyAccepted = false

-- verifica se já tem key salva
if isfile and isfile(KeyFile) then
	local savedKey = readfile(KeyFile)

	if savedKey == CorrectKey then
		KeyAccepted = true
	end
end

-- se não tiver key válida → pede
if not KeyAccepted then

	local KeyWindow = OrionLib:MakeWindow({
		Name="FPLIZ HUB | KEY SYSTEM 🔐",
		SaveConfig=false
	})

	local KeyTab = KeyWindow:MakeTab({Name="Key"})

	KeyTab:AddTextbox({
		Name="Digite a Key",
		Default="",
		TextDisappear=false,
		Callback=function(value)

			if value == CorrectKey then
				KeyAccepted = true

				-- salva key no PC
				if writefile then
					writefile(KeyFile,value)
				end

				OrionLib:MakeNotification({
					Name="Key System",
					Content="Key salva ✅",
					Time=4
				})

				task.wait(1)
				KeyWindow:Destroy()

			else
				OrionLib:MakeNotification({
					Name="Key System",
					Content="Key inválida ❌",
					Time=4
				})
			end
		end
	})

	repeat task.wait() until KeyAccepted
end
------------------------------------------------
-- CHARACTER FIX
------------------------------------------------
local Character,Humanoid,HRP

local function LoadChar(char)
	Character=char
	Humanoid=char:WaitForChild("Humanoid")
	HRP=char:WaitForChild("HumanoidRootPart")
end

LoadChar(Player.Character or Player.CharacterAdded:Wait())
Player.CharacterAdded:Connect(LoadChar)

------------------------------------------------
-- MAIN WINDOW 👑
------------------------------------------------
local Window=OrionLib:MakeWindow({
	Name="FPLIZ HUB GOD 👑",
	SaveConfig=true,
	ConfigFolder="FplizGod"
})

OrionLib:MakeNotification({
	Name="FPLIZ HUB",
	Content="GOD LOADED 🔥",
	Time=5
})

------------------------------------------------
-- UI TOGGLE
------------------------------------------------
UIS.InputBegan:Connect(function(i,gp)
	if not gp and i.KeyCode==Enum.KeyCode.RightShift then
		OrionLib:ToggleUI()
	end
end)

------------------------------------------------
-- ANTI AFK
------------------------------------------------
Player.Idled:Connect(function()
	VirtualUser:Button2Down(Vector2.new())
	task.wait(1)
	VirtualUser:Button2Up(Vector2.new())
end)

------------------------------------------------
-- PLAYER TAB
------------------------------------------------
local PlayerTab=Window:MakeTab({Name="Player ⚡"})

local speed=16
local jump=50
local noclip=false
local infjump=false

PlayerTab:AddSlider({
	Name="Speed",Min=16,Max=300,Default=16,
	Callback=function(v) speed=v end
})

PlayerTab:AddSlider({
	Name="JumpPower",Min=50,Max=300,Default=50,
	Callback=function(v) jump=v end
})

PlayerTab:AddToggle({
	Name="Infinite Jump",
	Callback=function(v) infjump=v end
})

PlayerTab:AddToggle({
	Name="Noclip",
	Callback=function(v) noclip=v end
})

RunService.RenderStepped:Connect(function()
	if Humanoid then
		Humanoid.WalkSpeed=speed
		Humanoid.JumpPower=jump
	end
end)

UIS.JumpRequest:Connect(function()
	if infjump then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

RunService.Stepped:Connect(function()
	if noclip and Character then
		for _,v in pairs(Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide=false
			end
		end
	end
end)

------------------------------------------------
-- FLY GOD 🕊️
------------------------------------------------
local FlyTab=Window:MakeTab({Name="Fly 🕊️"})

local flying=false
local flyspeed=90
local bv,bg

FlyTab:AddSlider({
	Name="Fly Speed",
	Min=20,Max=250,Default=90,
	Callback=function(v) flyspeed=v end
})

FlyTab:AddToggle({
	Name="Fly",
	Callback=function(state)
		flying=state

		if flying then
			bv=Instance.new("BodyVelocity",HRP)
			bg=Instance.new("BodyGyro",HRP)

			bv.MaxForce=Vector3.new(math.huge,math.huge,math.huge)
			bg.MaxTorque=Vector3.new(math.huge,math.huge,math.huge)

			RunService.RenderStepped:Connect(function()
				if not flying then return end
				local cam=workspace.CurrentCamera
				local dir=Humanoid.MoveDirection

				bv.Velocity=(cam.CFrame.LookVector*dir.Z+
					cam.CFrame.RightVector*dir.X)*flyspeed

				bg.CFrame=cam.CFrame
			end
		else
			if bv then bv:Destroy() end
			if bg then bg:Destroy() end
		end
	end
})

------------------------------------------------
-- TELEPORT 📍
------------------------------------------------
local TpTab=Window:MakeTab({Name="Teleport 📍"})
local mouse=Player:GetMouse()
local clicktp=false

TpTab:AddToggle({
	Name="Click TP",
	Callback=function(v) clicktp=v end
})

mouse.Button1Down:Connect(function()
	if clicktp then
		HRP.CFrame=CFrame.new(mouse.Hit.Position+Vector3.new(0,3,0))
	end
end)

TpTab:AddButton({
	Name="Rejoin Server",
	Callback=function()
		TPService:Teleport(game.PlaceId,Player)
	end
})

------------------------------------------------
OrionLib:Init()
