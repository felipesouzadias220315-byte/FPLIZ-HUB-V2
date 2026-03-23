--==================================
-- FPLIZ HUB SUPREMO VIP 👑 | FIX
--==================================

repeat task.wait() until game:IsLoaded()

-- SERVICES
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

-- CHARACTER LOAD
local Character, Humanoid, HRP
local function LoadCharacter(char)
	Character = char
	Humanoid = char:WaitForChild("Humanoid")
	HRP = char:WaitForChild("HumanoidRootPart")
end
LoadCharacter(Player.Character or Player.CharacterAdded:Wait())
Player.CharacterAdded:Connect(LoadCharacter)

-- ORION LIB (CORRETO)
local OrionLib = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
	Name = "FPLIZ HUB SUPREMO VIP 👑",
	HidePremium = false,
	SaveConfig = true,
	ConfigFolder = "FplizV2"
})

-- PLAYER TAB
local PlayerTab = Window:MakeTab({Name="Player ⚡"})

local WalkSpeed = 16
local JumpPower = 50
local InfiniteJump = false

PlayerTab:AddSlider({
	Name="Velocidade",
	Min=16,
	Max=200,
	Default=16,
	Callback=function(v) WalkSpeed=v end
})

PlayerTab:AddSlider({
	Name="Pulo",
	Min=50,
	Max=250,
	Default=50,
	Callback=function(v) JumpPower=v end
})

PlayerTab:AddToggle({
	Name="Pulo Infinito",
	Default=false,
	Callback=function(v) InfiniteJump=v end
})

RunService.RenderStepped:Connect(function()
	if Humanoid then
		Humanoid.WalkSpeed = WalkSpeed
		Humanoid.JumpPower = JumpPower
	end
end)

UIS.JumpRequest:Connect(function()
	if InfiniteJump and Humanoid then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

-- BROOKHAVEN TAB
local BrookTab = Window:MakeTab({Name="Brookhaven 🏠"})

BrookTab:AddButton({
	Name="Teleport Banco",
	Callback=function()
		HRP.CFrame = CFrame.new(-33,25,-170)
	end
})

local Noclip = false
BrookTab:AddToggle({
	Name="Noclip",
	Default=false,
	Callback=function(v) Noclip=v end
})

RunService.Stepped:Connect(function()
	if Noclip and Character then
		for _,v in pairs(Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

-- FLY TAB
local FlyTab = Window:MakeTab({Name="Fly 🕊️"})

local flying = false
local flyspeed = 50
local bv, bg, FlyConn

FlyTab:AddSlider({
	Name="Velocidade Voo",
	Min=10,
	Max=300,
	Default=50,
	Callback=function(v) flyspeed=v end
})

FlyTab:AddToggle({
	Name="Ativar Voo",
	Default=false,
	Callback=function(state)
		flying = state

		if flying then
			bv = Instance.new("BodyVelocity", HRP)
			bg = Instance.new("BodyGyro", HRP)

			bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			bg.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)

			FlyConn = RunService.RenderStepped:Connect(function()
				bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * flyspeed
				bg.CFrame = workspace.CurrentCamera.CFrame
			end)
		else
			if FlyConn then FlyConn:Disconnect() end
			if bv then bv:Destroy() end
			if bg then bg:Destroy() end
		end
	end
})

-- CONFIG TAB
local ConfigTab = Window:MakeTab({Name="Config ⚙️"})

ConfigTab:AddButton({
	Name="Rejoin",
	Callback=function()
		TeleportService:Teleport(game.PlaceId, Player)
	end
})

ConfigTab:AddButton({
	Name="Fechar Hub",
	Callback=function()
		OrionLib:Destroy()
	end
})

OrionLib:Init()
