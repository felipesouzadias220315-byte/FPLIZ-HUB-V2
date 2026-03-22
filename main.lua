local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com')))()

local Window = OrionLib:MakeWindow({
    Name = "FPLIZ HUB | BROOKHAVEN V2 ⛩️", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "FplizHubConfig",
    IntroText = "O MELHOR HUB DO MUNDO: FPLIZ HUB",
    Icon = "rbxassetid://15600646198" -- Foto do Gojo
})

-- ABA 1: PERSONAGEM (MOVIMENTAÇÃO)
local Tab1 = Window:MakeTab({Name = "Movimentação ⚡", Icon = "rbxassetid://4483345998"})

Tab1:AddSlider({
	Name = "Velocidade",
	Min = 16, Max = 500, Default = 16, Increment = 1,
	Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value end    
})

Tab1:AddButton({
	Name = "Pulo Infinito",
	Callback = function()
		game:GetService("UserInputService").JumpRequest:Connect(function()
			game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
		end)
	end    
})

Tab1:AddButton({
	Name = "Atravessar Paredes (Noclip)",
	Callback = function()
		game:GetService("RunService").Stepped:Connect(function()
			for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA("BasePart") then v.CanCollide = false end
			end
		end)
	end    
})

-- ABA 2: TROLL & KILL
local Tab2 = Window:MakeTab({Name = "Troll & Kill 💀", Icon = "rbxassetid://4483345998"})

Tab2:AddButton({
	Name = "Invisible Fling (Matar Geral)",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com"))()
	end    
})

Tab2:AddButton({
	Name = "Virar o Gojo Gigante",
	Callback = function()
		local hum = game.Players.LocalPlayer.Character.Humanoid
		hum.BodyHeightScale.Value = 3
		hum.BodyWidthScale.Value = 3
		hum.BodyDepthScale.Value = 3
	end    
})

-- ABA 3: TELEPORTES
local Tab3 = Window:MakeTab({Name = "Teleportes 📍", Icon = "rbxassetid://4483345998"})

Tab3:AddButton({Name = "Cofre do Banco", Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-33, 23, -164) end})
Tab3:AddButton({Name = "Lago", Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-330, 25, -450) end})

OrionLib:Init()
