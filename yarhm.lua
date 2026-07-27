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
		Title = "YARHM Outage",
		Text = "The latest YARHM build is currently unavailable. Using the mirror.",
		Duration = 5,
	})
	src = game:HttpGet("https://rawscripts.net/raw/Universal-Script-YARHM-12403", false)
end

loadstring(src)()
