local src = ""
local CoreGui = game:GetService("StarterGui")

pcall(function()
	local cacheBuster = tostring(os.time()) .. "-" .. tostring(math.random(100000, 999999))
	src = game:HttpGet(
		"https://raw.githubusercontent.com/aleexx9123/psychic-octo-invention/refs/heads/main/source/yarhm/1.21/yarhm.lua?v=" .. cacheBuster,
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
