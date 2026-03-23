--==================================
-- FPLIZ HUB SUPREMO VIP 👑 | ALL-IN-ONE
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

-- KEY ONLINE
local KEY_URL = "COLE_AQUI_SEU_LINK_RAW" -- seu link RAW de keys
local KEY_FILE = "FplizKey.txt"
local KeyAccepted = false

local function CheckKeyOnline(key)
	local success, result = pcall(function()
		return game:HttpGet(KEY_URL)
	end)
	if not success then warn("Erro ao conectar servidor de keys") return false end
	for line in string.gmatch(result,"[^\r\n]+") do
		if line == key then return true end
	end
	return false
end

-- verifica key salva
if isfile and isfile(KEY_FILE) then
	local saved = readfile(KEY_FILE)
	if CheckKeyOnline(saved) then KeyAccepted = true end
end

-- pede key se necessário
if not KeyAccepted then
	local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
	local Frame = Instance.new("Frame", ScreenGui)
	Frame.Size = UDim2.new(0,300,0,150)
	Frame.Position = UDim2.new(0.5,-150,0.5,-75)
	Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)

	local Box = Instance.new("TextBox", Frame)
	Box.Size = UDim2.new(0.8,0,0,40)
	Box.Position = UDim2.new(0.1,0,0.3,0)
	Box.PlaceholderText = "Digite sua Key..."
	Box.Text = ""

	local Button = Instance.new("TextButton", Frame)
	Button.Size = UDim2.new(0.6,0,0,35)
	Button.Position = UDim2.new(0.2,0,0.7,0)
	Button.Text = "Confirmar"

	Button.MouseButton1Click:Connect(function()
		local key = Box.Text
		if CheckKeyOnline(key) then
			KeyAccepted = true
			if writefile then writefile(KEY_FILE,key) end
			ScreenGui:Destroy()
		else
			Button.Text = "Key inválida ❌"
			task.wait(2)
			Button.Text = "Confirmar"
		end
	end)

	repeat task.wait() until KeyAccepted
end

-- ABERTURA PREMIUM
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(1,0,1,0)
Frame.BackgroundColor3 = Color3.fromRGB(0,0,0)

local TextLabel = Instance.new("TextLabel", Frame)
TextLabel.Size = UDim2.new(0.6,0,0.2,0)
TextLabel.Position = UDim2.new(0.2,0,0.4,0)
TextLabel.Text = "FPLIZ HUB SUPREMO VIP"
TextLabel.TextColor3 = Color3.fromRGB(255,215,0)
TextLabel.TextScaled = true
TextLabel.Font = Enum.Font.GothamBold
TextLabel.BackgroundTransparency = 1
TextLabel.TextStrokeTransparency = 0
TextLabel.TextTransparency = 1

local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenIn = TweenService:Create(TextLabel, tweenInfo, {TextTransparency=0})
local tweenOut = TweenService:Create(TextLabel, tweenInfo, {TextTransparency=1})

tweenIn:Play()
tweenIn.Completed:Wait()
task.wait(1)
tweenOut:Play()
tweenOut.Completed:Wait()
ScreenGui:Destroy()

-- ORION UI LOAD
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name="FPLIZ HUB SUPREMO VIP 👑", SaveConfig=true, ConfigFolder="FplizSupremo"})
OrionLib:MakeNotification({Name="FPLIZ HUB", Content="Sistema carregado com estilo PREMIUM ✅", Time=5})

-- UI TOGGLE
UIS.InputBegan:Connect(function(input,gp)
	if not gp and input.KeyCode == Enum.KeyCode.RightShift then
		OrionLib:ToggleUI()
	end
end)

-- PLAYER TAB
local PlayerTab = Window:MakeTab({Name="Player ⚡"})
local WalkSpeed, JumpPower, InfiniteJump = 16,50,false
PlayerTab:AddSlider({Name="WalkSpeed",Min=8,Max=100,Default=16,Callback=function(v) WalkSpeed=v end})
PlayerTab:AddSlider({Name="JumpPower",Min=30,Max=120,Default=50,Callback=function(v) JumpPower=v end})
PlayerTab:AddToggle({Name="Infinite Jump",Callback=function(v) InfiniteJump=v end})

RunService.RenderStepped:Connect(function()
	if Humanoid then
		Humanoid.WalkSpeed = WalkSpeed
		Humanoid.JumpPower = JumpPower
	end
end)
UIS.JumpRequest:Connect(function()
	if InfiniteJump and Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- TELEPORT TAB
local TpTab = Window:MakeTab({Name="Teleport 📍"})
TpTab:AddButton({Name="Teleport Spawn",Callback=function() if HRP then HRP.CFrame=CFrame.new(0,10,0) end end})
TpTab:AddButton({Name="Rejoin Server",Callback=function() TeleportService:Teleport(game.PlaceId,Player) end})

-- FLY TAB
local FlyTab = Window:MakeTab({Name="Fly 🕊️"})
local flying=false
local flyspeed=90
local bv,bg
local FlyConnection
FlyTab:AddSlider({Name="Fly Speed",Min=20,Max=250,Default=90,Callback=function(v) flyspeed=v end})
FlyTab:AddToggle({Name="Fly",Callback=function(state)
	flying=state
	if flying then
		bv=Instance.new("BodyVelocity",HRP)
		bg=Instance.new("BodyGyro",HRP)
		bv.MaxForce=Vector3.new(math.huge,math.huge,math.huge)
		bg.MaxTorque=Vector3.new(math.huge,math.huge,math.huge)
		FlyConnection = RunService.RenderStepped:Connect(function()
			local cam=workspace.CurrentCamera
			local dir=Humanoid.MoveDirection
			bv.Velocity=(cam.CFrame.LookVector*dir.Z + cam.CFrame.RightVector*dir.X)*flyspeed
			bg.CFrame=cam.CFrame
		end)
	else
		if bv then bv:Destroy() end
		if bg then bg:Destroy() end
		if FlyConnection then FlyConnection:Disconnect() end
	end
end})

-- DEV TAB
local DevTab = Window:MakeTab({Name="Dev Tools 🛠️"})
local FPSBoost=false
DevTab:AddToggle({Name="FPS Boost",Callback=function(v)
	FPSBoost=v
	if v then
		for _,obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") then
				obj.Material=Enum.Material.SmoothPlastic
				obj.Reflectance=0
			end
		end
	end
end})
DevTab:AddButton({Name="Reset Character",Callback=function() Player.Character:BreakJoints() end})

-- CAMERA TAB
local CamTab = Window:MakeTab({Name="Camera 🎥"})
local FOV=70
CamTab:AddSlider({Name="Field Of View",Min=40,Max=120,Default=70,Callback=function(v) FOV=v workspace.CurrentCamera.FieldOfView=FOV end})

OrionLib:Init()
