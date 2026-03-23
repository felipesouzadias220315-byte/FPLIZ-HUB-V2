--==================================
-- FPLIZ HUB SUPREMO VIP 👑 | WORKING
--==================================

print("✅ FPLIZ HUB INICIOU")

repeat task.wait() until game:IsLoaded()

-- SERVICES
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

-- CHARACTER
local Character, Humanoid, HRP

local function LoadCharacter(char)
	Character = char
	Humanoid = char:WaitForChild("Humanoid")
	HRP = char:WaitForChild("HumanoidRootPart")
end

LoadCharacter(Player.Character or Player.CharacterAdded:Wait())
Player.CharacterAdded:Connect(LoadCharacter)

-- NOTIFICAÇÃO TESTE
pcall(function()
	game.StarterGui:SetCore("SendNotification",{
		Title="FPLIZ HUB 👑",
		Text="Script carregado!",
		Duration=5
	})
end)

-- ORION LIB (CORRETO)
local OrionLib = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
	Name="FPLIZ HUB SUPREMO VIP 👑",
	HidePremium=false,
	SaveConfig=true,
	ConfigFolder="FplizV2"
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
	Callback=function(v)
		WalkSpeed = v
	end
})

PlayerTab:AddSlider({
	Name="Pulo",
	Min=50,
	Max=250,
	Default=50,
	Callback=function(v)
		JumpPower = v
	end
})

PlayerTab:AddToggle({
	Name="Pulo Infinito",
	Default=false,
	Callback=function(v)
		InfiniteJump = v
	end
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
		if HRP then
			HRP.CFrame = CFrame.new(-33,25,-170)
		end
	end
})

local Noclip = false

BrookTab:AddToggle({
	Name="Noclip",
	Default=false,
	Callback=function(v)
		Noclip = v
	end
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

-- CONFIG TAB
local ConfigTab = Window:MakeTab({Name="Config ⚙️"})

ConfigTab:AddButton({
	Name="Rejoin Server",
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

print("✅ FPLIZ HUB CARREGADO COMPLETO")
