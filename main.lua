print("1️⃣ Script começou")

repeat task.wait() until game:IsLoaded()
print("2️⃣ Game carregado")

local success, OrionLib = pcall(function()
	print("3️⃣ Tentando carregar Orion...")
	return loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
end)

if success then
	print("4️⃣ Orion carregou ✅")
else
	warn("❌ Orion NÃO carregou")
	return
end

local Window = OrionLib:MakeWindow({
	Name="DEBUG HUB",
	SaveConfig=false
})

print("5️⃣ Window criada")

local Tab = Window:MakeTab({
	Name="Teste"
})

print("6️⃣ Aba criada")

Tab:AddButton({
	Name="Botão Teste",
	Callback=function()
		print("BOTÃO FUNCIONOU ✅")
	end
})

print("7️⃣ Botão criado")

OrionLib:Init()

print("8️⃣ HUB FINALIZADO ✅")
