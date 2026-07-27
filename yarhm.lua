local src = ""
local CoreGui = game:GetService("StarterGui")

pcall(function()
	src = game:HttpGet(
		"https://raw.githubusercontent.com/aleexx9123/psychic-octo-invention/main/source/yarhm/1.21/yarhm.lua",
		false
	)
end)
if src == "" then
	CoreGui:SetCore("SendNotification", {
		Title = "Tiesas Scripts",
		Text = "No se ha podido descargar el script. Comprueba tu conexión e inténtalo de nuevo.",
		Duration = 5,
	})
	return
end

loadstring(src)()
