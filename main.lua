--==================================
-- FPLIZ HUB SUPREMO VIP 👑 | V2
--==================================

repeat task.wait() until game:IsLoaded()

-- SERVICES
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")

-- CHARACTER LOAD
local Character, Humanoid, HRP
local function LoadCharacter(char)
	Character = char
	Humanoid = char:WaitForChild("Humanoid")
	HRP = char:WaitForChild("HumanoidRootPart")
end
LoadCharacter(Player.Character or Player.CharacterAdded:Wait())
Player.CharacterAdded:Connect(LoadCharacter)

-- CONFIGURAÇÃO DA SUA KEY (GITHUB RAW)
local KEY_URL = "https://raw.githubusercontent.com"
local KEY_FILE = "FplizKeyV2.txt"
local KeyAccepted = false

local function CheckKeyOnline(key)
	local success, result = pcall(function()
		return game:HttpGet(KEY_URL)
	end)
	if not success then return false end
	for line in string.gmatch(result,"[^\r\n]+") do
		if line == key then return true end
	end
	return false
end

-- Verifica se já tem key salva no PC/Celular
if isfile and isfile(KEY_FILE) then
	local saved = readfile(KEY_FILE)
	if CheckKeyOnline(saved) then KeyAccepted = true end
end

-- Interface de Login (Só aparece se não tiver key válida)
if not KeyAccepted then
	local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
	local Frame = Instance.new("Frame", ScreenGui)
	Frame.Size = UDim2.new(0,300,0,180)
	Frame.Position = UDim2.new(0.5,-150,0.5,-90)
	Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
	Frame.BorderSizePixel = 0

	local Title = Instance.new("TextLabel", Frame)
	Title.Size = UDim2.new(1,0,0,40)
	Title.Text = "FPLIZ HUB - LOGIN"
	Title.TextColor3 = Color3.fromRGB(255,215,0)
	Title.BackgroundTransparency = 1

	local Box = Instance.new("TextBox", Frame)
	Box.Size = UDim2.new(0.8,0,0,40)
	Box.Position = UDim2.new(0.1,0,0.35,0)
	Box.PlaceholderText = "Cole sua Key aqui..."
	Box.Text = ""

	local Button = Instance.new("TextButton", Frame)
	Button.Size = UDim2.new(0.6,0,0,35)
	Button.Position = UDim2.new(0.2,0,0.7,0)
	Button.BackgroundColor3 = Color3.fromRGB(50,50,50)
	Button.TextColor3 = Color3.fromRGB(255,255,255)
	Button.Text = "Verificar Chave"

	Button.MouseButton1Click:Connect(function()
		local key = Box.Text
		if CheckKeyOnline(key) then
			KeyAccepted = true
			if writefile then writefile(KEY_FILE, key) end
			ScreenGui:Destroy()
		else
			Button.Text = "Chave Inválida! ❌"
			task.wait(2)
			Button.Text = "Verificar Chave"
		end
	end)
	repeat task.wait() until KeyAccepted
end

-- CARREGAR INTERFACE PRINCIPAL
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com"))()
local Window = OrionLib:MakeWindow({Name="FPLIZ HUB SUPREMO VIP 👑", SaveConfig=true, ConfigFolder="FplizV2"})

-- ABA PLAYER
local PlayerTab = Window:MakeTab({Name="Player ⚡"})
local WalkSpeed, JumpPower, InfiniteJump = 16, 50, false

PlayerTab:AddSlider({Name="Velocidade", Min=16, Max=200, Default=16, Callback=function(v) WalkSpeed=v end})
PlayerTab:AddSlider({Name="Pulo", Min=50, Max=250, Default=50, Callback=function(v) JumpPower=v end})
PlayerTab:AddToggle({Name="Pulo Infinito", Default=false, Callback=function(v) InfiniteJump=v end})

RunService.RenderStepped:Connect(function()
	if Humanoid then 
		Humanoid.WalkSpeed = WalkSpeed 
		Humanoid.JumpPower = JumpPower
	end
end)
UIS.JumpRequest:Connect(function()
	if InfiniteJump and Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- ABA BROOKHAVEN
local BrookTab = Window:MakeTab({Name="Brookhaven 🏠"})

BrookTab:AddButton({
	Name="Teleport: Cofre do Banco",
	Callback = function()
		HRP.CFrame = CFrame.new(-33, 25, -170)
	end
})

BrookTab:AddToggle({
	Name="Atravessar Paredes (Noclip)",
	Default = false,
	Callback = function(v)
		_G.Noclip = v
		RunService.Stepped:Connect(function()
			if _G.Noclip then
				for _, part in pairs(Character:GetDescendants()) do
					if part:IsA("BasePart") then part.CanCollide = false end
				end
			end
		end)
	end
})

-- ABA FLY
local FlyTab = Window:MakeTab({Name="Fly 🕊️"})
local flying, flyspeed = false, 50
local bv, bg, FlyConn

FlyTab:AddSlider({Name="Velocidade Voo", Min=10, Max=300, Default=50, Callback=function(v) flyspeed=v end})
FlyTab:AddToggle({Name="Ativar Voo", Default=false, Callback=function(state)
	flying = state
	if flying then
		bv = Instance.new("BodyVelocity", HRP)
		bg = Instance.new("BodyGyro", HRP)
		bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		FlyConn = RunService.RenderStepped:Connect(function()
			bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * flyspeed
			bg.CFrame = workspace.CurrentCamera.CFrame
		end)
	else
		if FlyConn then FlyConn:Disconnect() end
		if bv then bv:Destroy() end
		if bg then bg:Destroy() end
	end
end})

-- ABA CONFIG
local ConfigTab = Window:MakeTab({Name="Config ⚙️"})
ConfigTab:AddButton({Name="Rejoin Server", Callback=function() TeleportService:Teleport(game.PlaceId, Player) end})
ConfigTab:AddButton({Name="Destruir Hub", Callback=function() OrionLib:Destroy() end})

OrionLib:Init()
