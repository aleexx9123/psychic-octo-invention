-- Tiesas Scripts · Edición exclusiva para Murder Mystery 2 y MMV
-- Creado por Tiesas Development

local StarterGui = game:GetService("StarterGui")
local supportedGames = {
	[66654135] = "Murder Mystery 2",
	[10413186812] = "MMV",
}
local currentGameName = supportedGames[game.GameId]

-- Un solo runtime gobierna interfaz, ESP y lógica de juego. Esto permite
-- reejecutar en Delta sin conservar conexiones a RunService/UserInputService
-- ni menús cuyo nombre fue aleatorizado al moverlos al hidden UI.
local runtimeEnvironment = getgenv()
local previousAppRuntime = runtimeEnvironment.TIESAS_APP_V6_RUNTIME
if type(previousAppRuntime) == "table" and type(previousAppRuntime.stop) == "function" then
	pcall(previousAppRuntime.stop)
end
for _, legacyRuntimeName in ipairs({"TIESAS_MM2_V5_RUNTIME", "TIESAS_MM2_V6_RUNTIME"}) do
	local legacyRuntime = runtimeEnvironment[legacyRuntimeName]
	if type(legacyRuntime) == "table" and type(legacyRuntime.stop) == "function" then
		pcall(legacyRuntime.stop)
	end
	runtimeEnvironment[legacyRuntimeName] = nil
end

local appRuntime = {
	alive = true,
	connections = {},
	cleanups = {},
}

function appRuntime.track(connection)
	if connection then
		table.insert(appRuntime.connections, connection)
	end
	return connection
end

function appRuntime.release(connection)
	if not connection then return end
	pcall(function() connection:Disconnect() end)
	local index = table.find(appRuntime.connections, connection)
	if index then table.remove(appRuntime.connections, index) end
end

function appRuntime.cleanup(callback)
	if type(callback) == "function" then
		table.insert(appRuntime.cleanups, callback)
	end
	return callback
end

function appRuntime.stop()
	if not appRuntime.alive then return end
	appRuntime.alive = false
	for index = #appRuntime.connections, 1, -1 do
		pcall(function() appRuntime.connections[index]:Disconnect() end)
	end
	for index = #appRuntime.cleanups, 1, -1 do
		pcall(appRuntime.cleanups[index])
	end
	table.clear(appRuntime.connections)
	table.clear(appRuntime.cleanups)
end

runtimeEnvironment.TIESAS_APP_V6_RUNTIME = appRuntime

local function notifyBeforeLoad(text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "Tiesas Scripts",
			Text = text,
			Duration = 7
		})
	end)
end

if not currentGameName then
	notifyBeforeLoad("Tiesas Scripts solo funciona en Murder Mystery 2 y MMV.")
	return
end

if not game:IsLoaded() then
	notifyBeforeLoad("Esperando a que termine de cargar " .. currentGameName .. "...")
	game.Loaded:Wait()
end

local function roundMapExists()
	for _, object in ipairs(workspace:GetChildren()) do
		if object:FindFirstChild("CoinContainer") and object:FindFirstChild("Spawns") then
			return true
		end
	end
	return false
end

if not roundMapExists() then
	notifyBeforeLoad("Cargando el menú. Las funciones de la ronda se activarán al empezar.")
else
	notifyBeforeLoad("Partida de " .. currentGameName .. " detectada. Cargando Tiesas Scripts...")
end

-- Limpiar por referencia además de por nombre: gethui puede haber cambiado el
-- nombre del menú y haberlo movido fuera de los hijos directos de CoreGui.
pcall(function()
	local previousGui = runtimeEnvironment.TIESAS
	if typeof(previousGui) == "Instance" and previousGui.Parent then
		previousGui:Destroy()
	end
	local coreGui = game:GetService("CoreGui")
	local roots = {coreGui}
	if type(gethui) == "function" then
		local hidden = gethui()
		if hidden and hidden ~= coreGui then table.insert(roots, hidden) end
	end
	for _, root in ipairs(roots) do
		for _, child in ipairs(root:GetChildren()) do
			if child.Name == "TiesasScripts"
				or child.Name == "TiesasMM2ESP"
				or child.Name == "ESPIndicators"
				or child:GetAttribute("TiesasAppRoot") then
				child:Destroy()
			end
		end
	end
end)

-- Instances:

local Converted = {
	["_TIESAS"] = Instance.new("ScreenGui");
	["_FUNCTIONS"] = Instance.new("ModuleScript");
	["_Init"] = Instance.new("LocalScript");
	["_Murder Mystery 2"] = Instance.new("LocalScript");
	["_Bezier"] = Instance.new("ModuleScript");
	["_PointSave"] = Instance.new("ModuleScript");
	["_Theme"] = Instance.new("ModuleScript");
	["_Open"] = Instance.new("TextButton");
	["_UICorner"] = Instance.new("UICorner");
	["_UIPadding"] = Instance.new("UIPadding");
	["_DropdownFrameSample"] = Instance.new("Frame");
	["_UICorner1"] = Instance.new("UICorner");
	["_UIGradient"] = Instance.new("UIGradient");
	["_UIStroke"] = Instance.new("UIStroke");
	["_UIGradient1"] = Instance.new("UIGradient");
	["_ScrollingFrame"] = Instance.new("ScrollingFrame");
	["_UIListLayout"] = Instance.new("UIListLayout");
	["_Sample"] = Instance.new("TextButton");
	["_UIPadding1"] = Instance.new("UIPadding");
	["_UICorner2"] = Instance.new("UICorner");
	["_UIPadding2"] = Instance.new("UIPadding");
	["_themedColor"] = Instance.new("StringValue");
	["_ListButton"] = Instance.new("TextButton");
	["_UICorner3"] = Instance.new("UICorner");
	["_Notifications"] = Instance.new("Frame");
	["_UIListLayout1"] = Instance.new("UIListLayout");
	["_UIPadding3"] = Instance.new("UIPadding");
	["_Placeholder"] = Instance.new("Frame");
	["_UICorner4"] = Instance.new("UICorner");
	["_TextLabel"] = Instance.new("TextLabel");
	["_TextBoxPlaceholder"] = Instance.new("Frame");
	["_UIListLayout2"] = Instance.new("UIListLayout");
	["_TextButton"] = Instance.new("TextButton");
	["_UICorner5"] = Instance.new("UICorner");
	["_UIPadding4"] = Instance.new("UIPadding");
	["_TextBox"] = Instance.new("TextBox");
	["_UICorner6"] = Instance.new("UICorner");
	["_FloatingButton"] = Instance.new("TextButton");
	["_Keybinding"] = Instance.new("LocalScript");
	["_Invisible"] = Instance.new("LocalScript");
	["_UIPadding5"] = Instance.new("UIPadding");
	["_UICorner7"] = Instance.new("UICorner");
	["_UIStroke1"] = Instance.new("UIStroke");
	["_Lock"] = Instance.new("TextLabel");
	["_UIScale"] = Instance.new("UIScale");
	["_Ripple"] = Instance.new("Frame");
	["_UICorner8"] = Instance.new("UICorner");
	["_UIScale1"] = Instance.new("UIScale");
	["_Dropdown"] = Instance.new("Frame");
	["_TextLabel1"] = Instance.new("TextLabel");
	["_UIListLayout3"] = Instance.new("UIListLayout");
	["_UIPadding6"] = Instance.new("UIPadding");
	["_Frame"] = Instance.new("TextButton");
	["_UIPadding7"] = Instance.new("UIPadding");
	["_UICorner9"] = Instance.new("UICorner");
	["_AddCustomModule"] = Instance.new("Frame");
	["_UICorner10"] = Instance.new("UICorner");
	["_UIStroke2"] = Instance.new("UIStroke");
	["_UIGradient2"] = Instance.new("UIGradient");
	["_UIGradient3"] = Instance.new("UIGradient");
	["_UIScale2"] = Instance.new("UIScale");
	["_TextLabel2"] = Instance.new("TextLabel");
	["_TextBox1"] = Instance.new("TextBox");
	["_UICorner11"] = Instance.new("UICorner");
	["_UIPadding8"] = Instance.new("UIPadding");
	["_TextLabel3"] = Instance.new("TextLabel");
	["_Add"] = Instance.new("TextButton");
	["_LocalScript"] = Instance.new("LocalScript");
	["_UICorner12"] = Instance.new("UICorner");
	["_UIPadding9"] = Instance.new("UIPadding");
	["_UIStroke3"] = Instance.new("UIStroke");
	["_Cancel"] = Instance.new("TextButton");
	["_LocalScript1"] = Instance.new("LocalScript");
	["_UICorner13"] = Instance.new("UICorner");
	["_UIPadding10"] = Instance.new("UIPadding");
	["_UIStroke4"] = Instance.new("UIStroke");
	["_themedColor1"] = Instance.new("StringValue");
	["_Menu"] = Instance.new("Frame");
	["_UICorner14"] = Instance.new("UICorner");
	["_UIStroke5"] = Instance.new("UIStroke");
	["_UIGradient4"] = Instance.new("UIGradient");
	["_Animator"] = Instance.new("LocalScript");
	["_HubCredits"] = Instance.new("TextLabel");
	["_HubDesc"] = Instance.new("TextLabel");
	["_HubName"] = Instance.new("TextLabel");
	["_CanvasGroup"] = Instance.new("CanvasGroup");
	["_UICorner15"] = Instance.new("UICorner");
	["_ImageLabel"] = Instance.new("ImageLabel");
	["_Opener"] = Instance.new("TextButton");
	["_TextLabel4"] = Instance.new("TextLabel");
	["_CloseArea"] = Instance.new("TextButton");
	["_CloseOpen"] = Instance.new("LocalScript");
	["_Frame1"] = Instance.new("Frame");
	["_UICorner16"] = Instance.new("UICorner");
	["_themedColor2"] = Instance.new("StringValue");
	["_TextLabel5"] = Instance.new("TextLabel");
	["_UICorner17"] = Instance.new("UICorner");
	["_AllowForSpring"] = Instance.new("BindableEvent");
	["_themedColor3"] = Instance.new("StringValue");
	["_UIGradient5"] = Instance.new("UIGradient");
	["_Area"] = Instance.new("CanvasGroup");
	["_Area1"] = Instance.new("ScrollingFrame");
	["_TextLabel6"] = Instance.new("TextLabel");
	["_TextLabel7"] = Instance.new("TextLabel");
	["_UICorner18"] = Instance.new("UICorner");
	["_List"] = Instance.new("CanvasGroup");
	["_AutoSetup"] = Instance.new("LocalScript");
	["_UICorner19"] = Instance.new("UICorner");
	["_ScrollingFrame1"] = Instance.new("ScrollingFrame");
	["_UIListLayout4"] = Instance.new("UIListLayout");
	["_UIPadding11"] = Instance.new("UIPadding");
	["_UIPadding12"] = Instance.new("UIPadding");
	["_UIStroke6"] = Instance.new("UIStroke");
	["_UIGradient6"] = Instance.new("UIGradient");
	["_AddCustomModule1"] = Instance.new("TextButton");
	["_LocalScript2"] = Instance.new("LocalScript");
	["_UICorner20"] = Instance.new("UICorner");
	["_UIPadding13"] = Instance.new("UIPadding");
	["_UIStroke7"] = Instance.new("UIStroke");
	["_themedColor4"] = Instance.new("StringValue");
	["_themedColor5"] = Instance.new("StringValue");
	["_themedColor6"] = Instance.new("StringValue");
	["_UIScale3"] = Instance.new("UIScale");
	["_Stub"] = Instance.new("Frame");
	["_themedColor7"] = Instance.new("StringValue");
	["_Stub1"] = Instance.new("Frame");
	["_themedColor8"] = Instance.new("StringValue");
	["_Toggle"] = Instance.new("Frame");
	["_TextLabel8"] = Instance.new("TextLabel");
	["_UIListLayout5"] = Instance.new("UIListLayout");
	["_Frame2"] = Instance.new("Frame");
	["_Frame3"] = Instance.new("Frame");
	["_UICorner21"] = Instance.new("UICorner");
	["_Toggler"] = Instance.new("TextButton");
	["_UICorner22"] = Instance.new("UICorner");
	["_ImageLabel1"] = Instance.new("ImageLabel");
	["_UIPadding14"] = Instance.new("UIPadding");
	["_Modules"] = Instance.new("Folder");
	["_NotificationSample"] = Instance.new("Frame");
	["_UICorner23"] = Instance.new("UICorner");
	["_UIStroke8"] = Instance.new("UIStroke");
	["_UIGradient7"] = Instance.new("UIGradient");
	["_ImageLabel2"] = Instance.new("ImageLabel");
	["_TextLabel9"] = Instance.new("TextLabel");
	["_UITextSizeConstraint"] = Instance.new("UITextSizeConstraint");
	["_Close"] = Instance.new("ImageButton");
	["_UICorner24"] = Instance.new("UICorner");
	["_UIStroke9"] = Instance.new("UIStroke");
	["_UIScale4"] = Instance.new("UIScale");
	["_themedColor9"] = Instance.new("StringValue");
	["_Dialog"] = Instance.new("Frame");
	["_UICorner25"] = Instance.new("UICorner");
	["_UIGradient8"] = Instance.new("UIGradient");
	["_UIPadding15"] = Instance.new("UIPadding");
	["_UIStroke10"] = Instance.new("UIStroke");
	["_UIGradient9"] = Instance.new("UIGradient");
	["_DialogTitle"] = Instance.new("TextLabel");
	["_UIListLayout6"] = Instance.new("UIListLayout");
	["_DialogDesc"] = Instance.new("TextLabel");
	["_UITextSizeConstraint1"] = Instance.new("UITextSizeConstraint");
	["_Options"] = Instance.new("Frame");
	["_UIListLayout7"] = Instance.new("UIListLayout");
	["_OptionPlaceholder"] = Instance.new("TextButton");
	["_UIPadding16"] = Instance.new("UIPadding");
	["_UICorner26"] = Instance.new("UICorner");
	["_UIStroke11"] = Instance.new("UIStroke");
	["_UIGradient10"] = Instance.new("UIGradient");
	["_themedColor10"] = Instance.new("StringValue");
	["_OnSelect"] = Instance.new("BindableEvent");
	["_UIScale5"] = Instance.new("UIScale");
	["_themedColor11"] = Instance.new("StringValue");
	["_Range"] = Instance.new("Frame");
	["_TextLabel10"] = Instance.new("TextLabel");
	["_UIListLayout8"] = Instance.new("UIListLayout");
	["_UIPadding17"] = Instance.new("UIPadding");
	["_Frame4"] = Instance.new("Frame");
	["_UIPadding18"] = Instance.new("UIPadding");
	["_UICorner27"] = Instance.new("UICorner");
	["_Track"] = Instance.new("Frame");
	["_UICorner28"] = Instance.new("UICorner");
	["_Ball"] = Instance.new("TextButton");
	["_BallProgress"] = Instance.new("TextLabel");
	["_UIPadding19"] = Instance.new("UIPadding");
	["_themedColor12"] = Instance.new("StringValue");
	["_UICorner29"] = Instance.new("UICorner");
	["_UIPadding20"] = Instance.new("UIPadding");
	["_TrackProgress"] = Instance.new("TextLabel");
	["_themedColor13"] = Instance.new("StringValue");
	["_UISizeConstraint"] = Instance.new("UISizeConstraint");
	["_FloatingButtonSetting"] = Instance.new("Frame");
	["_ControlBarContainer"] = Instance.new("Frame");
	["_ControlBar"] = Instance.new("Frame");
	["_UIListLayout9"] = Instance.new("UIListLayout");
	["_Visibility"] = Instance.new("TextButton");
	["_LocalScript3"] = Instance.new("LocalScript");
	["_UICorner30"] = Instance.new("UICorner");
	["_UIPadding21"] = Instance.new("UIPadding");
	["_Event"] = Instance.new("BindableEvent");
	["_themedColor14"] = Instance.new("StringValue");
	["_Lock1"] = Instance.new("TextButton");
	["_LocalScript4"] = Instance.new("LocalScript");
	["_UICorner31"] = Instance.new("UICorner");
	["_UIPadding22"] = Instance.new("UIPadding");
	["_Event1"] = Instance.new("BindableEvent");
	["_themedColor15"] = Instance.new("StringValue");
	["_Exit"] = Instance.new("TextButton");
	["_LocalScript5"] = Instance.new("LocalScript");
	["_UICorner32"] = Instance.new("UICorner");
	["_UIPadding23"] = Instance.new("UIPadding");
	["_UIAspectRatioConstraint"] = Instance.new("UIAspectRatioConstraint");
	["_themedColor16"] = Instance.new("StringValue");
	["_UIListLayout10"] = Instance.new("UIListLayout");
	["_Tip"] = Instance.new("TextLabel");
	["_UIStroke12"] = Instance.new("UIStroke");
	["_UIScale6"] = Instance.new("UIScale");
	["_FloatingButtons"] = Instance.new("Frame");
	["_FloatingButtons1"] = Instance.new("Frame");
}

-- Properties:

Converted["_TIESAS"].DisplayOrder = 3
Converted["_TIESAS"].IgnoreGuiInset = true
Converted["_TIESAS"].ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
Converted["_TIESAS"].ResetOnSpawn = false
Converted["_TIESAS"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Converted["_TIESAS"].Name = "TiesasScripts"
Converted["_TIESAS"]:SetAttribute("TiesasAppRoot", true)
appRuntime.track(Converted["_TIESAS"].Destroying:Connect(function()
	appRuntime.stop()
end))
Converted["_TIESAS"].Parent = game:GetService("CoreGui")

Converted["_Open"].Font = Enum.Font.Gotham
Converted["_Open"].Text = "Pulsa tres veces para abrir Tiesas Scripts."
Converted["_Open"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Open"].TextScaled = true
Converted["_Open"].TextSize = 14
Converted["_Open"].TextTransparency = 1
Converted["_Open"].TextWrapped = true
Converted["_Open"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Open"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Open"].BackgroundTransparency = 1
Converted["_Open"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Open"].BorderSizePixel = 0
Converted["_Open"].Position = UDim2.new(0.499372631, 0, 0.06341701, 0)
Converted["_Open"].Selectable = false
Converted["_Open"].Size = UDim2.new(0, 493, 0, 50)
Converted["_Open"].Visible = false
Converted["_Open"].Name = "Open"
Converted["_Open"].Parent = Converted["_TIESAS"]

Converted["_UICorner"].Parent = Converted["_Open"]

Converted["_UIPadding"].PaddingBottom = UDim.new(0, 10)
Converted["_UIPadding"].PaddingLeft = UDim.new(0, 20)
Converted["_UIPadding"].PaddingRight = UDim.new(0, 20)
Converted["_UIPadding"].PaddingTop = UDim.new(0, 10)
Converted["_UIPadding"].Parent = Converted["_Open"]

Converted["_DropdownFrameSample"].AnchorPoint = Vector2.new(0.5, 0)
Converted["_DropdownFrameSample"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_DropdownFrameSample"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_DropdownFrameSample"].BorderSizePixel = 0
Converted["_DropdownFrameSample"].Size = UDim2.new(0, 108, 0, 239)
Converted["_DropdownFrameSample"].Visible = false
Converted["_DropdownFrameSample"].Name = "DropdownFrameSample"
Converted["_DropdownFrameSample"].Parent = Converted["_TIESAS"]

Converted["_UICorner1"].Parent = Converted["_DropdownFrameSample"]

Converted["_UIGradient"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(36.00000165402889, 36.00000165402889, 36.00000165402889)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(68.00000354647636, 68.00000354647636, 68.00000354647636))
}
Converted["_UIGradient"].Rotation = 68
Converted["_UIGradient"].Parent = Converted["_DropdownFrameSample"]

Converted["_UIStroke"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke"].Thickness = 2
Converted["_UIStroke"].Parent = Converted["_DropdownFrameSample"]

Converted["_UIGradient1"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(111.00000098347664, 111.00000098347664, 111.00000098347664)),
	ColorSequenceKeypoint.new(0.6401384472846985, Color3.fromRGB(114.23875719308853, 114.23875719308853, 114.23875719308853)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
}
Converted["_UIGradient1"].Rotation = -107
Converted["_UIGradient1"].Parent = Converted["_UIStroke"]

Converted["_ScrollingFrame"].AutomaticCanvasSize = Enum.AutomaticSize.XY
Converted["_ScrollingFrame"].CanvasSize = UDim2.new(0, 0, 0, 0)
Converted["_ScrollingFrame"].ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
Converted["_ScrollingFrame"].ScrollBarThickness = 0
Converted["_ScrollingFrame"].Active = true
Converted["_ScrollingFrame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_ScrollingFrame"].BackgroundTransparency = 1
Converted["_ScrollingFrame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_ScrollingFrame"].BorderSizePixel = 0
Converted["_ScrollingFrame"].Size = UDim2.new(1, 0, 1, 0)
Converted["_ScrollingFrame"].Parent = Converted["_DropdownFrameSample"]

Converted["_UIListLayout"].Padding = UDim.new(0, 5)
Converted["_UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout"].Parent = Converted["_ScrollingFrame"]

Converted["_Sample"].Font = Enum.Font.Unknown
Converted["_Sample"].Text = "Texto informativo"
Converted["_Sample"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Sample"].TextScaled = true
Converted["_Sample"].TextSize = 14
Converted["_Sample"].TextWrapped = true
Converted["_Sample"].BackgroundColor3 = Color3.fromRGB(22.000000588595867, 22.000000588595867, 22.000000588595867)
Converted["_Sample"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Sample"].BorderSizePixel = 0
Converted["_Sample"].Size = UDim2.new(1, 0, 0, 35)
Converted["_Sample"].Visible = false
Converted["_Sample"].Name = "Sample"
Converted["_Sample"].Parent = Converted["_ScrollingFrame"]

Converted["_UIPadding1"].PaddingBottom = UDim.new(0, 7)
Converted["_UIPadding1"].PaddingLeft = UDim.new(0, 7)
Converted["_UIPadding1"].PaddingRight = UDim.new(0, 7)
Converted["_UIPadding1"].PaddingTop = UDim.new(0, 7)
Converted["_UIPadding1"].Parent = Converted["_Sample"]

Converted["_UICorner2"].Parent = Converted["_Sample"]

Converted["_UIPadding2"].PaddingBottom = UDim.new(0, 7)
Converted["_UIPadding2"].PaddingLeft = UDim.new(0, 7)
Converted["_UIPadding2"].PaddingRight = UDim.new(0, 7)
Converted["_UIPadding2"].PaddingTop = UDim.new(0, 7)
Converted["_UIPadding2"].Parent = Converted["_DropdownFrameSample"]

Converted["_themedColor"].Value = "backgroundColorCSQ"
Converted["_themedColor"].Name = "themedColor"
Converted["_themedColor"].Parent = Converted["_DropdownFrameSample"]

Converted["_ListButton"].Font = Enum.Font.Gotham
Converted["_ListButton"].Text = "Módulo"
Converted["_ListButton"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_ListButton"].TextSize = 14
Converted["_ListButton"].TextWrapped = true
Converted["_ListButton"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_ListButton"].BackgroundColor3 = Color3.fromRGB(49.00000087916851, 49.00000087916851, 49.00000087916851)
Converted["_ListButton"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_ListButton"].BorderSizePixel = 0
Converted["_ListButton"].Position = UDim2.new(0.0450000018, 0, 0.112000003, 0)
Converted["_ListButton"].Size = UDim2.new(1, 0, 0, 50)
Converted["_ListButton"].Visible = false
Converted["_ListButton"].Name = "ListButton"
Converted["_ListButton"].Parent = Converted["_TIESAS"]

Converted["_UICorner3"].Parent = Converted["_ListButton"]

Converted["_Notifications"].AnchorPoint = Vector2.new(1, 0.5)
Converted["_Notifications"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Notifications"].BackgroundTransparency = 1
Converted["_Notifications"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Notifications"].BorderSizePixel = 0
Converted["_Notifications"].Position = UDim2.new(0.99000001, 0, 0.5, 0)
Converted["_Notifications"].Size = UDim2.new(0, 242, 1, 0)
Converted["_Notifications"].Name = "Notifications"
Converted["_Notifications"].Parent = Converted["_TIESAS"]

Converted["_UIListLayout1"].Padding = UDim.new(0, 10)
Converted["_UIListLayout1"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout1"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout1"].VerticalAlignment = Enum.VerticalAlignment.Bottom
Converted["_UIListLayout1"].Parent = Converted["_Notifications"]

Converted["_UIPadding3"].PaddingBottom = UDim.new(0, 10)
Converted["_UIPadding3"].PaddingLeft = UDim.new(0, 10)
Converted["_UIPadding3"].Parent = Converted["_Notifications"]

Converted["_Placeholder"].AnchorPoint = Vector2.new(0.5, 0)
Converted["_Placeholder"].BackgroundColor3 = Color3.fromRGB(31.000001952052116, 31.000001952052116, 31.000001952052116)
Converted["_Placeholder"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Placeholder"].BorderSizePixel = 0
Converted["_Placeholder"].Position = UDim2.new(0.0450000018, 0, 0.112000003, 0)
Converted["_Placeholder"].Visible = false
Converted["_Placeholder"].Name = "Placeholder"
Converted["_Placeholder"].Parent = Converted["_Notifications"]

Converted["_UICorner4"].Parent = Converted["_Placeholder"]

Converted["_TextLabel"].Font = Enum.Font.Gotham
Converted["_TextLabel"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel"].TextScaled = true
Converted["_TextLabel"].TextSize = 14
Converted["_TextLabel"].TextWrapped = true
Converted["_TextLabel"].TextXAlignment = Enum.TextXAlignment.Left
Converted["_TextLabel"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_TextLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel"].BackgroundTransparency = 1
Converted["_TextLabel"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel"].BorderSizePixel = 0
Converted["_TextLabel"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_TextLabel"].Size = UDim2.new(0.899999976, 0, 0.800000012, 0)
Converted["_TextLabel"].Parent = Converted["_Placeholder"]

Converted["_TextBoxPlaceholder"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextBoxPlaceholder"].BackgroundTransparency = 1
Converted["_TextBoxPlaceholder"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextBoxPlaceholder"].BorderSizePixel = 0
Converted["_TextBoxPlaceholder"].Size = UDim2.new(1, 0, 0, 50)
Converted["_TextBoxPlaceholder"].Visible = false
Converted["_TextBoxPlaceholder"].Name = "TextBoxPlaceholder"
Converted["_TextBoxPlaceholder"].Parent = Converted["_TIESAS"]

Converted["_UIListLayout2"].Padding = UDim.new(0, 5)
Converted["_UIListLayout2"].FillDirection = Enum.FillDirection.Horizontal
Converted["_UIListLayout2"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout2"].Parent = Converted["_TextBoxPlaceholder"]

Converted["_TextButton"].Font = Enum.Font.Gotham
Converted["_TextButton"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextButton"].TextScaled = true
Converted["_TextButton"].TextSize = 14
Converted["_TextButton"].TextWrapped = true
Converted["_TextButton"].BackgroundColor3 = Color3.fromRGB(22.000000588595867, 22.000000588595867, 22.000000588595867)
Converted["_TextButton"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextButton"].BorderSizePixel = 0
Converted["_TextButton"].Position = UDim2.new(0.292333364, 0, 1.67999995, 0)
Converted["_TextButton"].Size = UDim2.new(0, 50, 0, 50)
Converted["_TextButton"].Parent = Converted["_TextBoxPlaceholder"]

Converted["_UICorner5"].Parent = Converted["_TextButton"]

Converted["_UIPadding4"].PaddingBottom = UDim.new(0, 5)
Converted["_UIPadding4"].PaddingLeft = UDim.new(0, 5)
Converted["_UIPadding4"].PaddingRight = UDim.new(0, 5)
Converted["_UIPadding4"].PaddingTop = UDim.new(0, 5)
Converted["_UIPadding4"].Parent = Converted["_TextButton"]

Converted["_TextBox"].Font = Enum.Font.Gotham
Converted["_TextBox"].PlaceholderText = "Escribe aquí"
Converted["_TextBox"].Text = ""
Converted["_TextBox"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextBox"].TextSize = 14
Converted["_TextBox"].TextWrapped = true
Converted["_TextBox"].BackgroundColor3 = Color3.fromRGB(22.000000588595867, 22.000000588595867, 22.000000588595867)
Converted["_TextBox"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextBox"].BorderSizePixel = 0
Converted["_TextBox"].Size = UDim2.new(0.800000012, 0, 0, 50)
Converted["_TextBox"].Parent = Converted["_TextBoxPlaceholder"]

Converted["_UICorner6"].Parent = Converted["_TextBox"]

Converted["_FloatingButton"].Font = Enum.Font.Unknown
Converted["_FloatingButton"].Text = "SHOOT"
Converted["_FloatingButton"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_FloatingButton"].TextScaled = true
Converted["_FloatingButton"].TextSize = 14
Converted["_FloatingButton"].TextWrapped = true
Converted["_FloatingButton"].AutoButtonColor = false
Converted["_FloatingButton"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_FloatingButton"].BackgroundColor3 = Color3.fromRGB(31.000000052154064, 31.000000052154064, 31.000000052154064)
Converted["_FloatingButton"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_FloatingButton"].BorderSizePixel = 0
Converted["_FloatingButton"].ClipsDescendants = true
Converted["_FloatingButton"].Position = UDim2.new(0, 125, 0, 40)
Converted["_FloatingButton"].Size = UDim2.new(0, 50, 0, 100)
Converted["_FloatingButton"].Visible = false
Converted["_FloatingButton"].Name = "FloatingButton"
Converted["_FloatingButton"].Parent = Converted["_TIESAS"]

Converted["_UIPadding5"].PaddingBottom = UDim.new(0, 5)
Converted["_UIPadding5"].PaddingLeft = UDim.new(0, 5)
Converted["_UIPadding5"].PaddingRight = UDim.new(0, 5)
Converted["_UIPadding5"].PaddingTop = UDim.new(0, 5)
Converted["_UIPadding5"].Parent = Converted["_FloatingButton"]

Converted["_UICorner7"].Parent = Converted["_FloatingButton"]

Converted["_UIStroke1"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Converted["_UIStroke1"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke1"].Parent = Converted["_FloatingButton"]

Converted["_Lock"].Font = Enum.Font.Gotham
Converted["_Lock"].Text = "ðŸ”’"
Converted["_Lock"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Lock"].TextScaled = true
Converted["_Lock"].TextSize = 14
Converted["_Lock"].TextWrapped = true
Converted["_Lock"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Lock"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Lock"].BackgroundTransparency = 1
Converted["_Lock"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Lock"].BorderSizePixel = 0
Converted["_Lock"].Position = UDim2.new(1, -10, 1, -10)
Converted["_Lock"].Size = UDim2.new(0, 20, 0, 20)
Converted["_Lock"].ZIndex = 999999999
Converted["_Lock"].Name = "Lock"
Converted["_Lock"].Parent = Converted["_FloatingButton"]

Converted["_UIScale"].Scale = 1.0000000116860974e-07
Converted["_UIScale"].Parent = Converted["_Lock"]

Converted["_Ripple"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Ripple"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Ripple"].BackgroundTransparency = 1
Converted["_Ripple"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Ripple"].BorderSizePixel = 0
Converted["_Ripple"].Size = UDim2.new(0, 100, 0, 100)
Converted["_Ripple"].Name = "Ripple"
Converted["_Ripple"].Parent = Converted["_FloatingButton"]

Converted["_UICorner8"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner8"].Parent = Converted["_Ripple"]

Converted["_UIScale1"].Parent = Converted["_FloatingButton"]

Converted["_Dropdown"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Dropdown"].BackgroundTransparency = 1
Converted["_Dropdown"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Dropdown"].BorderSizePixel = 0
Converted["_Dropdown"].Size = UDim2.new(1, 0, 0, 35)
Converted["_Dropdown"].Visible = false
Converted["_Dropdown"].Name = "Dropdown"
Converted["_Dropdown"].Parent = Converted["_TIESAS"]

Converted["_TextLabel1"].Font = Enum.Font.Unknown
Converted["_TextLabel1"].Text = "Mantener velocidad y campo de visión"
Converted["_TextLabel1"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel1"].TextScaled = true
Converted["_TextLabel1"].TextSize = 14
Converted["_TextLabel1"].TextWrapped = true
Converted["_TextLabel1"].TextXAlignment = Enum.TextXAlignment.Left
Converted["_TextLabel1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel1"].BackgroundTransparency = 1
Converted["_TextLabel1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel1"].BorderSizePixel = 0
Converted["_TextLabel1"].Size = UDim2.new(0.699999988, 0, 1, 0)
Converted["_TextLabel1"].Parent = Converted["_Dropdown"]

Converted["_UIListLayout3"].Padding = UDim.new(0, 15)
Converted["_UIListLayout3"].FillDirection = Enum.FillDirection.Horizontal
Converted["_UIListLayout3"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout3"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout3"].Parent = Converted["_Dropdown"]

Converted["_UIPadding6"].PaddingLeft = UDim.new(0.0700000003, 0)
Converted["_UIPadding6"].PaddingRight = UDim.new(0.0700000003, 0)
Converted["_UIPadding6"].Parent = Converted["_Dropdown"]

Converted["_Frame"].Font = Enum.Font.Gotham
Converted["_Frame"].Text = "Seleccionar..."
Converted["_Frame"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame"].TextScaled = true
Converted["_Frame"].TextWrapped = true
Converted["_Frame"].Active = false
Converted["_Frame"].BackgroundColor3 = Color3.fromRGB(31.000001952052116, 31.000001952052116, 31.000001952052116)
Converted["_Frame"].BackgroundTransparency = -0.03999999910593033
Converted["_Frame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame"].BorderSizePixel = 0
Converted["_Frame"].Selectable = false
Converted["_Frame"].Size = UDim2.new(0.400000006, 0, 1, 0)
Converted["_Frame"].Name = "Frame"
Converted["_Frame"].Parent = Converted["_Dropdown"]

Converted["_UIPadding7"].PaddingBottom = UDim.new(0, 7)
Converted["_UIPadding7"].PaddingLeft = UDim.new(0, 7)
Converted["_UIPadding7"].PaddingRight = UDim.new(0, 7)
Converted["_UIPadding7"].PaddingTop = UDim.new(0, 7)
Converted["_UIPadding7"].Parent = Converted["_Frame"]

Converted["_UICorner9"].Parent = Converted["_Frame"]

Converted["_AddCustomModule"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_AddCustomModule"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_AddCustomModule"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_AddCustomModule"].BorderSizePixel = 0
Converted["_AddCustomModule"].ClipsDescendants = true
Converted["_AddCustomModule"].Position = UDim2.new(0.5, 0, -0.5, 0)
Converted["_AddCustomModule"].Size = UDim2.new(0, 440, 0, 268)
Converted["_AddCustomModule"].ZIndex = 3
Converted["_AddCustomModule"].Name = "AddCustomModule"
Converted["_AddCustomModule"].Parent = Converted["_TIESAS"]

Converted["_UICorner10"].Parent = Converted["_AddCustomModule"]

Converted["_UIStroke2"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke2"].Thickness = 2
Converted["_UIStroke2"].Parent = Converted["_AddCustomModule"]

Converted["_UIGradient2"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(53.00000064074993, 53.00000064074993, 53.00000064074993)),
	ColorSequenceKeypoint.new(0.15224914252758026, Color3.fromRGB(50.69031357765198, 50.69031357765198, 50.69031357765198)),
	ColorSequenceKeypoint.new(0.4723183512687683, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(0.7577854990959167, Color3.fromRGB(50.13314567506313, 50.13314567506313, 50.13314567506313)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(48.000000938773155, 48.000000938773155, 48.000000938773155))
}
Converted["_UIGradient2"].Rotation = 62
Converted["_UIGradient2"].Parent = Converted["_UIStroke2"]

Converted["_UIGradient3"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(36.00000165402889, 36.00000165402889, 36.00000165402889)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(68.00000354647636, 68.00000354647636, 68.00000354647636))
}
Converted["_UIGradient3"].Rotation = 68
Converted["_UIGradient3"].Parent = Converted["_AddCustomModule"]

Converted["_UIScale2"].Parent = Converted["_AddCustomModule"]

Converted["_TextLabel2"].Font = Enum.Font.Gotham
Converted["_TextLabel2"].Text = "Añadir un módulo"
Converted["_TextLabel2"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel2"].TextScaled = true
Converted["_TextLabel2"].TextSize = 14
Converted["_TextLabel2"].TextWrapped = true
Converted["_TextLabel2"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_TextLabel2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel2"].BackgroundTransparency = 1
Converted["_TextLabel2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel2"].BorderSizePixel = 0
Converted["_TextLabel2"].Position = UDim2.new(0.352256238, 0, 0.133915231, 0)
Converted["_TextLabel2"].Size = UDim2.new(0.619047642, 0, 0.125920027, 0)
Converted["_TextLabel2"].Parent = Converted["_AddCustomModule"]

Converted["_TextBox1"].ClearTextOnFocus = false
Converted["_TextBox1"].Font = Enum.Font.Gotham
Converted["_TextBox1"].PlaceholderText = "Enlace del módulo"
Converted["_TextBox1"].Text = ""
Converted["_TextBox1"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextBox1"].TextScaled = true
Converted["_TextBox1"].TextSize = 14
Converted["_TextBox1"].TextWrapped = true
Converted["_TextBox1"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_TextBox1"].BackgroundColor3 = Color3.fromRGB(22.000000588595867, 22.000000588595867, 22.000000588595867)
Converted["_TextBox1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextBox1"].BorderSizePixel = 0
Converted["_TextBox1"].Position = UDim2.new(0.499648541, 0, 0.500059664, 0)
Converted["_TextBox1"].Size = UDim2.new(0.804988742, 0, 0.544776142, 0)
Converted["_TextBox1"].Parent = Converted["_AddCustomModule"]

Converted["_UICorner11"].Parent = Converted["_TextBox1"]

Converted["_UIPadding8"].PaddingBottom = UDim.new(0, 10)
Converted["_UIPadding8"].PaddingLeft = UDim.new(0, 10)
Converted["_UIPadding8"].PaddingRight = UDim.new(0, 10)
Converted["_UIPadding8"].PaddingTop = UDim.new(0, 10)
Converted["_UIPadding8"].Parent = Converted["_TextBox1"]

Converted["_TextLabel3"].Font = Enum.Font.GothamBold
Converted["_TextLabel3"].Text = "AÑADE SOLO MÓDULOS DE CONFIANZA"
Converted["_TextLabel3"].TextColor3 = Color3.fromRGB(255, 0, 0)
Converted["_TextLabel3"].TextScaled = true
Converted["_TextLabel3"].TextSize = 14
Converted["_TextLabel3"].TextWrapped = true
Converted["_TextLabel3"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_TextLabel3"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel3"].BackgroundTransparency = 1
Converted["_TextLabel3"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel3"].BorderSizePixel = 0
Converted["_TextLabel3"].Position = UDim2.new(0.499648541, 0, 0.833542168, 0)
Converted["_TextLabel3"].Size = UDim2.new(0.619047642, 0, 0.0550245307, 0)
Converted["_TextLabel3"].Parent = Converted["_AddCustomModule"]

Converted["_Add"].Font = Enum.Font.Gotham
Converted["_Add"].Text = "Añadir"
Converted["_Add"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Add"].TextScaled = true
Converted["_Add"].TextSize = 14
Converted["_Add"].TextWrapped = true
Converted["_Add"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Add"].BackgroundColor3 = Color3.fromRGB(50.00000461935997, 50.00000461935997, 50.00000461935997)
Converted["_Add"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Add"].BorderSizePixel = 0
Converted["_Add"].Position = UDim2.new(0.108492024, 0, 0.927298486, 0)
Converted["_Add"].Size = UDim2.new(0.163265288, 0, 0.0858208984, 0)
Converted["_Add"].Name = "Add"
Converted["_Add"].Parent = Converted["_AddCustomModule"]

Converted["_UICorner12"].Parent = Converted["_Add"]

Converted["_UIPadding9"].PaddingBottom = UDim.new(0, 5)
Converted["_UIPadding9"].PaddingLeft = UDim.new(0, 5)
Converted["_UIPadding9"].PaddingRight = UDim.new(0, 5)
Converted["_UIPadding9"].PaddingTop = UDim.new(0, 5)
Converted["_UIPadding9"].Parent = Converted["_Add"]

Converted["_UIStroke3"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Converted["_UIStroke3"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke3"].Parent = Converted["_Add"]

Converted["_Cancel"].Font = Enum.Font.Gotham
Converted["_Cancel"].Text = "Cancelar"
Converted["_Cancel"].TextColor3 = Color3.fromRGB(255, 0, 0)
Converted["_Cancel"].TextScaled = true
Converted["_Cancel"].TextSize = 14
Converted["_Cancel"].TextWrapped = true
Converted["_Cancel"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Cancel"].BackgroundColor3 = Color3.fromRGB(50.00000461935997, 50.00000461935997, 50.00000461935997)
Converted["_Cancel"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Cancel"].BorderSizePixel = 0
Converted["_Cancel"].Position = UDim2.new(0.899875283, 0, 0.931029797, 0)
Converted["_Cancel"].Size = UDim2.new(0.163265288, 0, 0.0858208984, 0)
Converted["_Cancel"].Name = "Cancel"
Converted["_Cancel"].Parent = Converted["_AddCustomModule"]

Converted["_UICorner13"].Parent = Converted["_Cancel"]

Converted["_UIPadding10"].PaddingBottom = UDim.new(0, 5)
Converted["_UIPadding10"].PaddingLeft = UDim.new(0, 5)
Converted["_UIPadding10"].PaddingRight = UDim.new(0, 5)
Converted["_UIPadding10"].PaddingTop = UDim.new(0, 5)
Converted["_UIPadding10"].Parent = Converted["_Cancel"]

Converted["_UIStroke4"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Converted["_UIStroke4"].Color = Color3.fromRGB(255, 0, 0)
Converted["_UIStroke4"].Parent = Converted["_Cancel"]

Converted["_themedColor1"].Value = "backgroundColorCSQ"
Converted["_themedColor1"].Name = "themedColor"
Converted["_themedColor1"].Parent = Converted["_AddCustomModule"]

Converted["_Menu"].AnchorPoint = Vector2.new(0.5, 0)
Converted["_Menu"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Menu"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Menu"].BorderSizePixel = 0
Converted["_Menu"].Position = UDim2.new(0.5, 0, 0.0500000007, 0)
Converted["_Menu"].Size = UDim2.new(0, 441, 0, 268)
Converted["_Menu"].Name = "Menu"
Converted["_Menu"].Parent = Converted["_TIESAS"]

Converted["_UICorner14"].CornerRadius = UDim.new(0, 16)
Converted["_UICorner14"].Parent = Converted["_Menu"]

Converted["_UIStroke5"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke5"].Thickness = 2
Converted["_UIStroke5"].Parent = Converted["_Menu"]

Converted["_UIGradient4"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(53.00000064074993, 53.00000064074993, 53.00000064074993)),
	ColorSequenceKeypoint.new(0.15224914252758026, Color3.fromRGB(50.69031357765198, 50.69031357765198, 50.69031357765198)),
	ColorSequenceKeypoint.new(0.4723183512687683, Color3.fromRGB(255, 0, 4.000000236555934)),
	ColorSequenceKeypoint.new(0.7577854990959167, Color3.fromRGB(50.13314567506313, 50.13314567506313, 50.13314567506313)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(48.000000938773155, 48.000000938773155, 48.000000938773155))
}
Converted["_UIGradient4"].Rotation = 180
Converted["_UIGradient4"].Parent = Converted["_UIStroke5"]

Converted["_HubCredits"].Font = Enum.Font.GothamBold
Converted["_HubCredits"].Text = "Tiesas Development"
Converted["_HubCredits"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_HubCredits"].TextScaled = true
Converted["_HubCredits"].TextSize = 14
Converted["_HubCredits"].TextTransparency = 0.699999988079071
Converted["_HubCredits"].TextWrapped = true
Converted["_HubCredits"].TextXAlignment = Enum.TextXAlignment.Right
Converted["_HubCredits"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_HubCredits"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_HubCredits"].BackgroundTransparency = 1
Converted["_HubCredits"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_HubCredits"].BorderSizePixel = 0
Converted["_HubCredits"].Position = UDim2.new(0.785926819, 0, 0.160157606, 0)
Converted["_HubCredits"].Size = UDim2.new(0.316320807, 0, 0.0585099049, 0)
Converted["_HubCredits"].Visible = true
Converted["_HubCredits"].Name = "HubCredits"
Converted["_HubCredits"].Parent = Converted["_Menu"]

Converted["_HubDesc"].Font = Enum.Font.GothamBold
Converted["_HubDesc"].Text = "MM2 + MMV · automático y configurable"
Converted["_HubDesc"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_HubDesc"].TextSize = 14
Converted["_HubDesc"].TextWrapped = true
Converted["_HubDesc"].TextXAlignment = Enum.TextXAlignment.Right
Converted["_HubDesc"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_HubDesc"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_HubDesc"].BackgroundTransparency = 1
Converted["_HubDesc"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_HubDesc"].BorderSizePixel = 0
Converted["_HubDesc"].Position = UDim2.new(0.708829343, 0, 0.116141364, 0)
Converted["_HubDesc"].Size = UDim2.new(0.470515788, 0, 0.082417585, 0)
Converted["_HubDesc"].Name = "HubDesc"
Converted["_HubDesc"].Parent = Converted["_Menu"]

Converted["_HubName"].Font = Enum.Font.GothamBold
Converted["_HubName"].RichText = true
Converted["_HubName"].Text = "Tiesas Scripts "
Converted["_HubName"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_HubName"].TextScaled = true
Converted["_HubName"].TextSize = 14
Converted["_HubName"].TextWrapped = true
Converted["_HubName"].TextXAlignment = Enum.TextXAlignment.Left
Converted["_HubName"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_HubName"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_HubName"].BackgroundTransparency = 1
Converted["_HubName"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_HubName"].BorderSizePixel = 0
Converted["_HubName"].Position = UDim2.new(0.186153606, 0, 0.112410031, 0)
Converted["_HubName"].Size = UDim2.new(0.259631485, 0, 0.0824175924, 0)
Converted["_HubName"].Name = "HubName"
Converted["_HubName"].Parent = Converted["_Menu"]

Converted["_CanvasGroup"].GroupTransparency = 1
Converted["_CanvasGroup"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_CanvasGroup"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_CanvasGroup"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_CanvasGroup"].BorderSizePixel = 0
Converted["_CanvasGroup"].Interactable = false
Converted["_CanvasGroup"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_CanvasGroup"].Size = UDim2.new(1, 0, 1, 0)
Converted["_CanvasGroup"].Visible = false
Converted["_CanvasGroup"].ZIndex = 999999998
Converted["_CanvasGroup"].Parent = Converted["_Menu"]

Converted["_UICorner15"].CornerRadius = UDim.new(0, 16)
Converted["_UICorner15"].Parent = Converted["_CanvasGroup"]

Converted["_ImageLabel"].Image = ""
-- Converted["_ImageLabel"].ImageContent = Content{SourceType=Uri, Uri=rbxassetid://17864987433}
Converted["_ImageLabel"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_ImageLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_ImageLabel"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_ImageLabel"].BorderSizePixel = 0
Converted["_ImageLabel"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_ImageLabel"].Size = UDim2.new(0, 50, 0, 50)
Converted["_ImageLabel"].Visible = false
Converted["_ImageLabel"].ZIndex = 3
Converted["_ImageLabel"].Parent = Converted["_CanvasGroup"]

Converted["_Opener"].Font = Enum.Font.SourceSans
Converted["_Opener"].Text = ""
Converted["_Opener"].TextColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Opener"].TextSize = 14
Converted["_Opener"].AutoButtonColor = false
Converted["_Opener"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Opener"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Opener"].BorderSizePixel = 0
Converted["_Opener"].Size = UDim2.new(1, 0, 1, 0)
Converted["_Opener"].Name = "Opener"
Converted["_Opener"].Parent = Converted["_CanvasGroup"]

Converted["_TextLabel4"].Font = Enum.Font.GothamBold
Converted["_TextLabel4"].Text = "TS"
Converted["_TextLabel4"].TextColor3 = Color3.fromRGB(109, 91, 144)
Converted["_TextLabel4"].TextScaled = true
Converted["_TextLabel4"].TextSize = 14
Converted["_TextLabel4"].TextWrapped = true
Converted["_TextLabel4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel4"].BackgroundTransparency = 1
Converted["_TextLabel4"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel4"].BorderSizePixel = 0
Converted["_TextLabel4"].Position = UDim2.new(0.204081595, 0, 0.447761208, 0)
Converted["_TextLabel4"].Size = UDim2.new(0, 260, 0, 27)
Converted["_TextLabel4"].ZIndex = 3
Converted["_TextLabel4"].Parent = Converted["_CanvasGroup"]

Converted["_CloseArea"].Text = ""
Converted["_CloseArea"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_CloseArea"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_CloseArea"].BackgroundTransparency = 1
Converted["_CloseArea"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_CloseArea"].BorderSizePixel = 0
Converted["_CloseArea"].Position = UDim2.new(0.5, 0, 0.00295135868, 0)
Converted["_CloseArea"].Size = UDim2.new(0.326999992, 0, 0.184, 0)
Converted["_CloseArea"].Name = "CloseArea"
Converted["_CloseArea"].Parent = Converted["_Menu"]

Converted["_Frame1"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Frame1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame1"].BackgroundTransparency = 0.6499999761581421
Converted["_Frame1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame1"].BorderSizePixel = 0
Converted["_Frame1"].Position = UDim2.new(0.5, 0, 0.699999988, 0)
Converted["_Frame1"].Size = UDim2.new(0.699999988, 0, 0.100000001, 0)
Converted["_Frame1"].Parent = Converted["_CloseArea"]

Converted["_UICorner16"].CornerRadius = UDim.new(0, 9999)
Converted["_UICorner16"].Parent = Converted["_Frame1"]

Converted["_themedColor2"].Value = "accentColor"
Converted["_themedColor2"].Name = "themedColor"
Converted["_themedColor2"].Parent = Converted["_Frame1"]

Converted["_TextLabel5"].Font = Enum.Font.Gotham
Converted["_TextLabel5"].Text = "Pulsa aquí para minimizar."
Converted["_TextLabel5"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel5"].TextSize = 15
Converted["_TextLabel5"].TextWrapped = true
Converted["_TextLabel5"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_TextLabel5"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel5"].BackgroundTransparency = 0.4000000059604645
Converted["_TextLabel5"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel5"].BorderSizePixel = 0
Converted["_TextLabel5"].Position = UDim2.new(0.5, 0, 0.680000007, 0)
Converted["_TextLabel5"].Size = UDim2.new(1.39999998, 0, 0.740999997, 0)
Converted["_TextLabel5"].Parent = Converted["_CloseArea"]

Converted["_UICorner17"].Parent = Converted["_TextLabel5"]

Converted["_AllowForSpring"].Name = "AllowForSpring"
Converted["_AllowForSpring"].Parent = Converted["_CloseArea"]

Converted["_themedColor3"].Value = "backgroundColorCSQ"
Converted["_themedColor3"].Name = "themedColor"
Converted["_themedColor3"].Parent = Converted["_Menu"]

Converted["_UIGradient5"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(36.00000165402889, 36.00000165402889, 36.00000165402889)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(68.00000354647636, 68.00000354647636, 68.00000354647636))
}
Converted["_UIGradient5"].Offset = Vector2.new(0, 0.5)
Converted["_UIGradient5"].Rotation = 68
Converted["_UIGradient5"].Parent = Converted["_Menu"]

Converted["_Area"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Area"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Area"].BackgroundTransparency = 1
Converted["_Area"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Area"].BorderSizePixel = 0
Converted["_Area"].Position = UDim2.new(0.659600496, 0, 0.60637325, 0)
Converted["_Area"].Size = UDim2.new(0.643815279, 0, 0.783582091, 0)
Converted["_Area"].Name = "Area"
Converted["_Area"].Parent = Converted["_Menu"]

Converted["_Area1"].AutomaticCanvasSize = Enum.AutomaticSize.Y
Converted["_Area1"].CanvasSize = UDim2.new(0, 0, 0, 0)
Converted["_Area1"].ScrollBarThickness = 0
Converted["_Area1"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Area1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Area1"].BackgroundTransparency = 1
Converted["_Area1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Area1"].BorderSizePixel = 0
Converted["_Area1"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Area1"].Selectable = false
Converted["_Area1"].Size = UDim2.new(1, 0, 1, 0)
Converted["_Area1"].Name = "Area"
Converted["_Area1"].Parent = Converted["_Area"]

Converted["_TextLabel6"].Font = Enum.Font.GothamBold
Converted["_TextLabel6"].Text = "MM2 + MMV"
Converted["_TextLabel6"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel6"].TextSize = 14
Converted["_TextLabel6"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_TextLabel6"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel6"].BackgroundTransparency = 1
Converted["_TextLabel6"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel6"].BorderSizePixel = 0
Converted["_TextLabel6"].Position = UDim2.new(0.4923051, 0, 0.46438089, 0)
Converted["_TextLabel6"].Size = UDim2.new(0, 200, 0, 50)
Converted["_TextLabel6"].Parent = Converted["_Area1"]

Converted["_TextLabel7"].Font = Enum.Font.GothamBold
Converted["_TextLabel7"].Text = "Tiesas Scripts"
Converted["_TextLabel7"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel7"].TextScaled = true
Converted["_TextLabel7"].TextSize = 14
Converted["_TextLabel7"].TextWrapped = true
Converted["_TextLabel7"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_TextLabel7"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel7"].BackgroundTransparency = 1
Converted["_TextLabel7"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel7"].BorderSizePixel = 0
Converted["_TextLabel7"].Position = UDim2.new(0.491272807, 0, 0.363785654, 0)
Converted["_TextLabel7"].Size = UDim2.new(0, 135, 0, 33)
Converted["_TextLabel7"].Parent = Converted["_Area1"]

Converted["_UICorner18"].Parent = Converted["_Area"]

Converted["_List"].AnchorPoint = Vector2.new(0, 0.5)
Converted["_List"].BackgroundColor3 = Color3.fromRGB(22.000000588595867, 22.000000588595867, 22.000000588595867)
Converted["_List"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_List"].BorderSizePixel = 0
Converted["_List"].Position = UDim2.new(0, 0, 0.606999993, 0)
Converted["_List"].Size = UDim2.new(0.315405339, 0, 0.785387993, 0)
Converted["_List"].Name = "List"
Converted["_List"].Parent = Converted["_Menu"]

Converted["_UICorner19"].CornerRadius = UDim.new(0, 16)
Converted["_UICorner19"].Parent = Converted["_List"]

Converted["_ScrollingFrame1"].AutomaticCanvasSize = Enum.AutomaticSize.Y
Converted["_ScrollingFrame1"].CanvasSize = UDim2.new(0, 0, 0, 0)
Converted["_ScrollingFrame1"].ScrollBarThickness = 2
Converted["_ScrollingFrame1"].VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
Converted["_ScrollingFrame1"].Active = true
Converted["_ScrollingFrame1"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_ScrollingFrame1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_ScrollingFrame1"].BackgroundTransparency = 1
Converted["_ScrollingFrame1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_ScrollingFrame1"].BorderSizePixel = 0
Converted["_ScrollingFrame1"].Position = UDim2.new(0.478333294, 0, 0.408619136, 0)
Converted["_ScrollingFrame1"].Size = UDim2.new(1, 0, 0.795258284, 0)
Converted["_ScrollingFrame1"].Parent = Converted["_List"]

Converted["_UIListLayout4"].Padding = UDim.new(0, 3)
Converted["_UIListLayout4"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout4"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout4"].Parent = Converted["_ScrollingFrame1"]

Converted["_UIPadding11"].PaddingLeft = UDim.new(0, 4)
Converted["_UIPadding11"].Parent = Converted["_ScrollingFrame1"]

Converted["_UIPadding12"].PaddingBottom = UDim.new(0, 10)
Converted["_UIPadding12"].PaddingLeft = UDim.new(0, 10)
Converted["_UIPadding12"].PaddingRight = UDim.new(0, 10)
Converted["_UIPadding12"].PaddingTop = UDim.new(0, 10)
Converted["_UIPadding12"].Parent = Converted["_List"]

Converted["_UIStroke6"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke6"].Thickness = 0
Converted["_UIStroke6"].Parent = Converted["_List"]

Converted["_UIGradient6"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(111.00000098347664, 111.00000098347664, 111.00000098347664)),
	ColorSequenceKeypoint.new(0.6401384472846985, Color3.fromRGB(114.23875719308853, 114.23875719308853, 114.23875719308853)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
}
Converted["_UIGradient6"].Rotation = -44
Converted["_UIGradient6"].Parent = Converted["_UIStroke6"]

Converted["_AddCustomModule1"].Font = Enum.Font.Gotham
Converted["_AddCustomModule1"].Text = "+"
Converted["_AddCustomModule1"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_AddCustomModule1"].TextScaled = true
Converted["_AddCustomModule1"].TextSize = 14
Converted["_AddCustomModule1"].TextWrapped = true
Converted["_AddCustomModule1"].AnchorPoint = Vector2.new(1, 1)
Converted["_AddCustomModule1"].BackgroundColor3 = Color3.fromRGB(50.00000461935997, 50.00000461935997, 50.00000461935997)
Converted["_AddCustomModule1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_AddCustomModule1"].BorderSizePixel = 0
Converted["_AddCustomModule1"].Position = UDim2.new(1, 0, 1, 0)
Converted["_AddCustomModule1"].Size = UDim2.new(0.215681866, 0, 0.142528668, 0)
Converted["_AddCustomModule1"].Visible = false
Converted["_AddCustomModule1"].Name = "AddCustomModule"
Converted["_AddCustomModule1"].Parent = Converted["_List"]

Converted["_UICorner20"].Parent = Converted["_AddCustomModule1"]

Converted["_UIPadding13"].PaddingLeft = UDim.new(0, 1)
Converted["_UIPadding13"].Parent = Converted["_AddCustomModule1"]

Converted["_UIStroke7"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Converted["_UIStroke7"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke7"].Parent = Converted["_AddCustomModule1"]

Converted["_themedColor4"].Value = "secondaryColor"
Converted["_themedColor4"].Name = "themedColor"
Converted["_themedColor4"].Parent = Converted["_UIStroke7"]

Converted["_themedColor5"].Value = "primaryColor"
Converted["_themedColor5"].Name = "themedColor"
Converted["_themedColor5"].Parent = Converted["_AddCustomModule1"]

Converted["_themedColor6"].Value = "primaryColor"
Converted["_themedColor6"].Name = "themedColor"
Converted["_themedColor6"].Parent = Converted["_List"]

Converted["_UIScale3"].Parent = Converted["_Menu"]

Converted["_Stub"].BackgroundColor3 = Color3.fromRGB(22.000000588595867, 22.000000588595867, 22.000000588595867)
Converted["_Stub"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Stub"].BorderSizePixel = 0
Converted["_Stub"].Position = UDim2.new(0, 0, 0.214000002, 0)
Converted["_Stub"].Size = UDim2.new(0.0340136066, 0, 0.055970151, 0)
Converted["_Stub"].ZIndex = -9999
Converted["_Stub"].Name = "Stub"
Converted["_Stub"].Parent = Converted["_Menu"]

Converted["_themedColor7"].Value = "primaryColor"
Converted["_themedColor7"].Name = "themedColor"
Converted["_themedColor7"].Parent = Converted["_Stub"]

Converted["_Stub1"].AnchorPoint = Vector2.new(1, 1)
Converted["_Stub1"].BackgroundColor3 = Color3.fromRGB(22.000000588595867, 22.000000588595867, 22.000000588595867)
Converted["_Stub1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Stub1"].BorderSizePixel = 0
Converted["_Stub1"].Position = UDim2.new(0.315192729, 0, 1, 0)
Converted["_Stub1"].Size = UDim2.new(0.0453514755, 0, 0.074626863, 0)
Converted["_Stub1"].ZIndex = -9999
Converted["_Stub1"].Name = "Stub"
Converted["_Stub1"].Parent = Converted["_Menu"]

Converted["_themedColor8"].Value = "primaryColor"
Converted["_themedColor8"].Name = "themedColor"
Converted["_themedColor8"].Parent = Converted["_Stub1"]

Converted["_Toggle"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Toggle"].BackgroundTransparency = 1
Converted["_Toggle"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Toggle"].BorderSizePixel = 0
Converted["_Toggle"].Size = UDim2.new(1, 0, 0, 35)
Converted["_Toggle"].Visible = false
Converted["_Toggle"].Name = "Toggle"
Converted["_Toggle"].Parent = Converted["_TIESAS"]

Converted["_TextLabel8"].Font = Enum.Font.Unknown
Converted["_TextLabel8"].Text = "Mantener velocidad y campo de visión"
Converted["_TextLabel8"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel8"].TextScaled = true
Converted["_TextLabel8"].TextSize = 14
Converted["_TextLabel8"].TextWrapped = true
Converted["_TextLabel8"].TextXAlignment = Enum.TextXAlignment.Left
Converted["_TextLabel8"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel8"].BackgroundTransparency = 1
Converted["_TextLabel8"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel8"].BorderSizePixel = 0
Converted["_TextLabel8"].Size = UDim2.new(0.699999988, 0, 0, 25)
Converted["_TextLabel8"].Parent = Converted["_Toggle"]

Converted["_UIListLayout5"].Padding = UDim.new(0, 25)
Converted["_UIListLayout5"].FillDirection = Enum.FillDirection.Horizontal
Converted["_UIListLayout5"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout5"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout5"].VerticalAlignment = Enum.VerticalAlignment.Center
Converted["_UIListLayout5"].Parent = Converted["_Toggle"]

Converted["_Frame2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame2"].BackgroundTransparency = 1
Converted["_Frame2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame2"].BorderSizePixel = 0
Converted["_Frame2"].Size = UDim2.new(0.200000003, 0, 1, 0)
Converted["_Frame2"].Parent = Converted["_Toggle"]

Converted["_Frame3"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Frame3"].BackgroundColor3 = Color3.fromRGB(46.000001057982445, 46.000001057982445, 46.000001057982445)
Converted["_Frame3"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame3"].BorderSizePixel = 0
Converted["_Frame3"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Frame3"].Size = UDim2.new(0, 89, 1, 0)
Converted["_Frame3"].Parent = Converted["_Frame2"]

Converted["_UICorner21"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner21"].Parent = Converted["_Frame3"]

Converted["_Toggler"].Font = Enum.Font.SourceSans
Converted["_Toggler"].Text = ""
Converted["_Toggler"].TextColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Toggler"].TextSize = 14
Converted["_Toggler"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Toggler"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Toggler"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Toggler"].BorderSizePixel = 0
Converted["_Toggler"].Position = UDim2.new(0.300000012, 0, 0.5, 0)
Converted["_Toggler"].Size = UDim2.new(0.449438214, 0, 0.800000012, 0)
Converted["_Toggler"].Name = "Toggler"
Converted["_Toggler"].Parent = Converted["_Frame3"]

Converted["_UICorner22"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner22"].Parent = Converted["_Toggler"]

Converted["_ImageLabel1"].Image = "rbxassetid://10002373478"
Converted["_ImageLabel1"].ImageColor3 = Color3.fromRGB(255, 0, 4.000000236555934)
-- Converted["_ImageLabel1"].ImageContent = Content{SourceType=Uri, Uri=rbxassetid://10002373478}
Converted["_ImageLabel1"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_ImageLabel1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_ImageLabel1"].BackgroundTransparency = 1
Converted["_ImageLabel1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_ImageLabel1"].BorderSizePixel = 0
Converted["_ImageLabel1"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_ImageLabel1"].Size = UDim2.new(0, 20, 0, 20)
Converted["_ImageLabel1"].Parent = Converted["_Toggler"]

Converted["_UIPadding14"].PaddingRight = UDim.new(0.0700000003, 0)
Converted["_UIPadding14"].Parent = Converted["_Toggle"]

Converted["_Modules"].Name = "Modules"
Converted["_Modules"].Parent = Converted["_TIESAS"]

Converted["_NotificationSample"].AnchorPoint = Vector2.new(0.5, 0)
Converted["_NotificationSample"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_NotificationSample"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_NotificationSample"].BorderSizePixel = 0
Converted["_NotificationSample"].ClipsDescendants = true
Converted["_NotificationSample"].Position = UDim2.new(0.5, 0, 0, 10)
Converted["_NotificationSample"].Size = UDim2.new(0, 400, 0, 50)
Converted["_NotificationSample"].Visible = false
Converted["_NotificationSample"].ZIndex = 5
Converted["_NotificationSample"].Name = "NotificationSample"
Converted["_NotificationSample"].Parent = Converted["_TIESAS"]

Converted["_UICorner23"].CornerRadius = UDim.new(0, 10)
Converted["_UICorner23"].Parent = Converted["_NotificationSample"]

Converted["_UIStroke8"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke8"].Thickness = 1.600000023841858
Converted["_UIStroke8"].Parent = Converted["_NotificationSample"]

Converted["_UIGradient7"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(46.000001057982445, 46.000001057982445, 46.000001057982445)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(12.000000234693289, 12.000000234693289, 12.000000234693289))
}
Converted["_UIGradient7"].Parent = Converted["_NotificationSample"]

Converted["_ImageLabel2"].Image = "rbxassetid://11780939099"
-- Converted["_ImageLabel2"].ImageContent = Content{SourceType=Uri, Uri=rbxassetid://11780939099}
Converted["_ImageLabel2"].ScaleType = Enum.ScaleType.Fit
Converted["_ImageLabel2"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_ImageLabel2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_ImageLabel2"].BackgroundTransparency = 1
Converted["_ImageLabel2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_ImageLabel2"].BorderSizePixel = 0
Converted["_ImageLabel2"].Position = UDim2.new(0.100000001, 0, 0.5, 0)
Converted["_ImageLabel2"].Size = UDim2.new(0.0799999982, 0, 0.639999986, 0)
Converted["_ImageLabel2"].Parent = Converted["_NotificationSample"]

Converted["_TextLabel9"].Font = Enum.Font.Gotham
Converted["_TextLabel9"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel9"].TextScaled = true
Converted["_TextLabel9"].TextSize = 14
Converted["_TextLabel9"].TextWrapped = true
Converted["_TextLabel9"].TextXAlignment = Enum.TextXAlignment.Left
Converted["_TextLabel9"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_TextLabel9"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel9"].BackgroundTransparency = 1
Converted["_TextLabel9"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel9"].BorderSizePixel = 0
Converted["_TextLabel9"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_TextLabel9"].Size = UDim2.new(0.600000024, 0, 0.600000024, 0)
Converted["_TextLabel9"].Parent = Converted["_NotificationSample"]

Converted["_UITextSizeConstraint"].MaxTextSize = 30
Converted["_UITextSizeConstraint"].Parent = Converted["_TextLabel9"]

Converted["_Close"].Image = "rbxassetid://10002373478"
-- Converted["_Close"].ImageContent = Content{SourceType=Uri, Uri=rbxassetid://10002373478}
Converted["_Close"].ScaleType = Enum.ScaleType.Fit
Converted["_Close"].Active = false
Converted["_Close"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Close"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Close"].BackgroundTransparency = 1
Converted["_Close"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Close"].BorderSizePixel = 0
Converted["_Close"].Position = UDim2.new(0.899999976, 0, 0.5, 0)
Converted["_Close"].Selectable = false
Converted["_Close"].Size = UDim2.new(0.0799999982, 0, 0.639999986, 0)
Converted["_Close"].Name = "Close"
Converted["_Close"].Parent = Converted["_NotificationSample"]

Converted["_UICorner24"].Parent = Converted["_Close"]

Converted["_UIStroke9"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke9"].Parent = Converted["_Close"]

Converted["_UIScale4"].Scale = 0.800000011920929
Converted["_UIScale4"].Parent = Converted["_NotificationSample"]

Converted["_themedColor9"].Value = "backgroundColorCSQ"
Converted["_themedColor9"].Name = "themedColor"
Converted["_themedColor9"].Parent = Converted["_NotificationSample"]

Converted["_Dialog"].AnchorPoint = Vector2.new(0.5, 1)
Converted["_Dialog"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Dialog"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Dialog"].BorderSizePixel = 0
Converted["_Dialog"].Position = UDim2.new(0.499000013, 0, 0.984000027, 0)
Converted["_Dialog"].Size = UDim2.new(0, 313, 0, 147)
Converted["_Dialog"].Visible = false
Converted["_Dialog"].ZIndex = 5
Converted["_Dialog"].Name = "Dialog"
Converted["_Dialog"].Parent = Converted["_TIESAS"]

Converted["_UICorner25"].Parent = Converted["_Dialog"]

Converted["_UIGradient8"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(36.00000165402889, 36.00000165402889, 36.00000165402889)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(68.00000354647636, 68.00000354647636, 68.00000354647636))
}
Converted["_UIGradient8"].Rotation = -133
Converted["_UIGradient8"].Parent = Converted["_Dialog"]

Converted["_UIPadding15"].PaddingBottom = UDim.new(0, 15)
Converted["_UIPadding15"].PaddingLeft = UDim.new(0, 15)
Converted["_UIPadding15"].PaddingRight = UDim.new(0, 15)
Converted["_UIPadding15"].PaddingTop = UDim.new(0, 15)
Converted["_UIPadding15"].Parent = Converted["_Dialog"]

Converted["_UIStroke10"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke10"].Thickness = 2
Converted["_UIStroke10"].Parent = Converted["_Dialog"]

Converted["_UIGradient9"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(111.00000098347664, 111.00000098347664, 111.00000098347664)),
	ColorSequenceKeypoint.new(0.6401384472846985, Color3.fromRGB(114.23875719308853, 114.23875719308853, 114.23875719308853)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
}
Converted["_UIGradient9"].Rotation = -107
Converted["_UIGradient9"].Parent = Converted["_UIStroke10"]

Converted["_DialogTitle"].Font = Enum.Font.Unknown
Converted["_DialogTitle"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_DialogTitle"].TextScaled = true
Converted["_DialogTitle"].TextSize = 14
Converted["_DialogTitle"].TextWrapped = true
Converted["_DialogTitle"].TextXAlignment = Enum.TextXAlignment.Right
Converted["_DialogTitle"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_DialogTitle"].BackgroundTransparency = 1
Converted["_DialogTitle"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_DialogTitle"].BorderSizePixel = 0
Converted["_DialogTitle"].Size = UDim2.new(0.997416437, 0, 0.16459392, 0)
Converted["_DialogTitle"].Name = "DialogTitle"
Converted["_DialogTitle"].Parent = Converted["_Dialog"]

Converted["_UIListLayout6"].Padding = UDim.new(0, 3)
Converted["_UIListLayout6"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout6"].Parent = Converted["_Dialog"]

Converted["_DialogDesc"].Font = Enum.Font.Unknown
Converted["_DialogDesc"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_DialogDesc"].TextScaled = true
Converted["_DialogDesc"].TextSize = 14
Converted["_DialogDesc"].TextWrapped = true
Converted["_DialogDesc"].TextXAlignment = Enum.TextXAlignment.Left
Converted["_DialogDesc"].TextYAlignment = Enum.TextYAlignment.Top
Converted["_DialogDesc"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_DialogDesc"].BackgroundTransparency = 1
Converted["_DialogDesc"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_DialogDesc"].BorderSizePixel = 0
Converted["_DialogDesc"].Position = UDim2.new(0, 0, 0.187079012, 0)
Converted["_DialogDesc"].Size = UDim2.new(0.997416437, 0, 0.604575336, 0)
Converted["_DialogDesc"].Name = "DialogDesc"
Converted["_DialogDesc"].Parent = Converted["_Dialog"]

Converted["_UITextSizeConstraint1"].MaxTextSize = 20
Converted["_UITextSizeConstraint1"].MinTextSize = 5
Converted["_UITextSizeConstraint1"].Parent = Converted["_DialogDesc"]

Converted["_Options"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Options"].BackgroundTransparency = 1
Converted["_Options"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Options"].BorderSizePixel = 0
Converted["_Options"].Position = UDim2.new(0, 0, 0.82045126, 0)
Converted["_Options"].Size = UDim2.new(0.997436285, 0, 0.241758227, 0)
Converted["_Options"].Name = "Options"
Converted["_Options"].Parent = Converted["_Dialog"]

Converted["_UIListLayout7"].Padding = UDim.new(0, 10)
Converted["_UIListLayout7"].FillDirection = Enum.FillDirection.Horizontal
Converted["_UIListLayout7"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout7"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout7"].Parent = Converted["_Options"]

Converted["_OptionPlaceholder"].Font = Enum.Font.GothamBold
Converted["_OptionPlaceholder"].RichText = true
Converted["_OptionPlaceholder"].Text = "Opción"
Converted["_OptionPlaceholder"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_OptionPlaceholder"].TextScaled = true
Converted["_OptionPlaceholder"].TextSize = 100
Converted["_OptionPlaceholder"].TextWrapped = true
Converted["_OptionPlaceholder"].BackgroundColor3 = Color3.fromRGB(36.00000165402889, 36.00000165402889, 36.00000165402889)
Converted["_OptionPlaceholder"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_OptionPlaceholder"].BorderSizePixel = 0
Converted["_OptionPlaceholder"].Size = UDim2.new(0.532000005, -5, 1.00899994, 0)
Converted["_OptionPlaceholder"].Visible = false
Converted["_OptionPlaceholder"].Name = "OptionPlaceholder"
Converted["_OptionPlaceholder"].Parent = Converted["_Options"]

Converted["_UIPadding16"].PaddingBottom = UDim.new(0, 1)
Converted["_UIPadding16"].PaddingLeft = UDim.new(0, 15)
Converted["_UIPadding16"].PaddingRight = UDim.new(0, 15)
Converted["_UIPadding16"].PaddingTop = UDim.new(0, 1)
Converted["_UIPadding16"].Parent = Converted["_OptionPlaceholder"]

Converted["_UICorner26"].Parent = Converted["_OptionPlaceholder"]

Converted["_UIStroke11"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Converted["_UIStroke11"].Color = Color3.fromRGB(255, 255, 255)
Converted["_UIStroke11"].Thickness = 2
Converted["_UIStroke11"].Parent = Converted["_OptionPlaceholder"]

Converted["_UIGradient10"].Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(111.00000098347664, 111.00000098347664, 111.00000098347664)),
	ColorSequenceKeypoint.new(0.6401384472846985, Color3.fromRGB(114.23875719308853, 114.23875719308853, 114.23875719308853)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
}
Converted["_UIGradient10"].Rotation = -107
Converted["_UIGradient10"].Parent = Converted["_UIStroke11"]

Converted["_themedColor10"].Value = "primaryColor"
Converted["_themedColor10"].Name = "themedColor"
Converted["_themedColor10"].Parent = Converted["_OptionPlaceholder"]

Converted["_OnSelect"].Name = "OnSelect"
Converted["_OnSelect"].Parent = Converted["_Dialog"]

Converted["_UIScale5"].Parent = Converted["_Dialog"]

Converted["_themedColor11"].Value = "backgroundColorCSQ"
Converted["_themedColor11"].Name = "themedColor"
Converted["_themedColor11"].Parent = Converted["_Dialog"]

Converted["_Range"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Range"].BackgroundTransparency = 1
Converted["_Range"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Range"].BorderSizePixel = 0
Converted["_Range"].Size = UDim2.new(1, 0, 0, 35)
Converted["_Range"].Visible = false
Converted["_Range"].Name = "Range"
Converted["_Range"].Parent = Converted["_TIESAS"]

Converted["_TextLabel10"].Font = Enum.Font.Unknown
Converted["_TextLabel10"].Text = "Ajuste configurable"
Converted["_TextLabel10"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel10"].TextScaled = true
Converted["_TextLabel10"].TextSize = 58
Converted["_TextLabel10"].TextWrapped = true
Converted["_TextLabel10"].TextXAlignment = Enum.TextXAlignment.Left
Converted["_TextLabel10"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TextLabel10"].BackgroundTransparency = 1
Converted["_TextLabel10"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TextLabel10"].BorderSizePixel = 0
Converted["_TextLabel10"].Position = UDim2.new(-0.0633024424, 0, 0.685714304, 0)
Converted["_TextLabel10"].Size = UDim2.new(0, 125, 0, 25)
Converted["_TextLabel10"].Parent = Converted["_Range"]

Converted["_UIListLayout8"].HorizontalFlex = Enum.UIFlexAlignment.Fill
Converted["_UIListLayout8"].Padding = UDim.new(0, 15)
Converted["_UIListLayout8"].VerticalFlex = Enum.UIFlexAlignment.SpaceAround
Converted["_UIListLayout8"].FillDirection = Enum.FillDirection.Horizontal
Converted["_UIListLayout8"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout8"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout8"].VerticalAlignment = Enum.VerticalAlignment.Center
Converted["_UIListLayout8"].Parent = Converted["_Range"]

Converted["_UIPadding17"].Parent = Converted["_Range"]

Converted["_Frame4"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Frame4"].BackgroundTransparency = 1
Converted["_Frame4"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Frame4"].BorderSizePixel = 0
Converted["_Frame4"].Size = UDim2.new(0.400000006, 0, 1, 0)
Converted["_Frame4"].Parent = Converted["_Range"]

Converted["_UIPadding18"].PaddingBottom = UDim.new(0, 7)
Converted["_UIPadding18"].PaddingLeft = UDim.new(0, 7)
Converted["_UIPadding18"].PaddingRight = UDim.new(0, 7)
Converted["_UIPadding18"].PaddingTop = UDim.new(0, 7)
Converted["_UIPadding18"].Parent = Converted["_Frame4"]

Converted["_UICorner27"].Parent = Converted["_Frame4"]

Converted["_Track"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_Track"].BackgroundColor3 = Color3.fromRGB(22.000000588595867, 22.000000588595867, 22.000000588595867)
Converted["_Track"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Track"].BorderSizePixel = 0
Converted["_Track"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_Track"].Size = UDim2.new(1, 0, 1.20000005, 0)
Converted["_Track"].Name = "Track"
Converted["_Track"].Parent = Converted["_Frame4"]

Converted["_UICorner28"].CornerRadius = UDim.new(0, 6)
Converted["_UICorner28"].Parent = Converted["_Track"]

Converted["_Ball"].Font = Enum.Font.SourceSans
Converted["_Ball"].Text = ""
Converted["_Ball"].TextColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Ball"].TextSize = 14
Converted["_Ball"].AnchorPoint = Vector2.new(0, 0.5)
Converted["_Ball"].BackgroundColor3 = Color3.fromRGB(197.0000034570694, 0, 0)
Converted["_Ball"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Ball"].BorderSizePixel = 0
Converted["_Ball"].Interactable = false
Converted["_Ball"].Position = UDim2.new(1.32920917e-07, 0, 0.5, 0)
Converted["_Ball"].Size = UDim2.new(0.0599999987, 0, 1, 0)
Converted["_Ball"].Name = "Ball"
Converted["_Ball"].Parent = Converted["_Track"]

Converted["_BallProgress"].Font = Enum.Font.GothamBold
Converted["_BallProgress"].Text = "0"
Converted["_BallProgress"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_BallProgress"].TextScaled = true
Converted["_BallProgress"].TextSize = 14
Converted["_BallProgress"].TextTransparency = 1
Converted["_BallProgress"].TextWrapped = true
Converted["_BallProgress"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_BallProgress"].BackgroundTransparency = 1
Converted["_BallProgress"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_BallProgress"].BorderSizePixel = 0
Converted["_BallProgress"].Size = UDim2.new(1, 0, 1, 0)
Converted["_BallProgress"].Name = "BallProgress"
Converted["_BallProgress"].Parent = Converted["_Ball"]

Converted["_UIPadding19"].PaddingBottom = UDim.new(0, 2)
Converted["_UIPadding19"].PaddingTop = UDim.new(0, 1)
Converted["_UIPadding19"].Parent = Converted["_Ball"]

Converted["_themedColor12"].Value = "accentColor"
Converted["_themedColor12"].Name = "themedColor"
Converted["_themedColor12"].Parent = Converted["_Ball"]

Converted["_UICorner29"].CornerRadius = UDim.new(1, 0)
Converted["_UICorner29"].Parent = Converted["_Ball"]

Converted["_UIPadding20"].PaddingBottom = UDim.new(0, 6)
Converted["_UIPadding20"].PaddingLeft = UDim.new(0, 6)
Converted["_UIPadding20"].PaddingRight = UDim.new(0, 6)
Converted["_UIPadding20"].PaddingTop = UDim.new(0, 6)
Converted["_UIPadding20"].Parent = Converted["_Track"]

Converted["_TrackProgress"].Font = Enum.Font.GothamBold
Converted["_TrackProgress"].Text = "0"
Converted["_TrackProgress"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TrackProgress"].TextScaled = true
Converted["_TrackProgress"].TextSize = 14
Converted["_TrackProgress"].TextTransparency = 1
Converted["_TrackProgress"].TextWrapped = true
Converted["_TrackProgress"].TextXAlignment = Enum.TextXAlignment.Right
Converted["_TrackProgress"].AnchorPoint = Vector2.new(1, 0.5)
Converted["_TrackProgress"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_TrackProgress"].BackgroundTransparency = 1
Converted["_TrackProgress"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_TrackProgress"].BorderSizePixel = 0
Converted["_TrackProgress"].Position = UDim2.new(1, 0, 0.5, 0)
Converted["_TrackProgress"].Size = UDim2.new(0, 35, 1, 0)
Converted["_TrackProgress"].Name = "TrackProgress"
Converted["_TrackProgress"].Parent = Converted["_Track"]

Converted["_themedColor13"].Value = "primaryColor"
Converted["_themedColor13"].Name = "themedColor"
Converted["_themedColor13"].Parent = Converted["_Track"]

Converted["_UISizeConstraint"].Parent = Converted["_Frame4"]

Converted["_FloatingButtonSetting"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_FloatingButtonSetting"].BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Converted["_FloatingButtonSetting"].BackgroundTransparency = 0.5
Converted["_FloatingButtonSetting"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_FloatingButtonSetting"].BorderSizePixel = 0
Converted["_FloatingButtonSetting"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_FloatingButtonSetting"].Size = UDim2.new(1, 0, 1, 0)
Converted["_FloatingButtonSetting"].Visible = false
Converted["_FloatingButtonSetting"].ZIndex = 10
Converted["_FloatingButtonSetting"].Name = "FloatingButtonSetting"
Converted["_FloatingButtonSetting"].Parent = Converted["_TIESAS"]

Converted["_ControlBarContainer"].AnchorPoint = Vector2.new(0.5, 1)
Converted["_ControlBarContainer"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_ControlBarContainer"].BackgroundTransparency = 1
Converted["_ControlBarContainer"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_ControlBarContainer"].BorderSizePixel = 0
Converted["_ControlBarContainer"].Position = UDim2.new(0.5, 0, 1, -50)
Converted["_ControlBarContainer"].Size = UDim2.new(1, 0, 0, 40)
Converted["_ControlBarContainer"].Name = "ControlBarContainer"
Converted["_ControlBarContainer"].Parent = Converted["_FloatingButtonSetting"]

Converted["_ControlBar"].AnchorPoint = Vector2.new(0.5, 1)
Converted["_ControlBar"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_ControlBar"].BackgroundTransparency = 1
Converted["_ControlBar"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_ControlBar"].BorderSizePixel = 0
Converted["_ControlBar"].Position = UDim2.new(0.5, 0, 1, -30)
Converted["_ControlBar"].Size = UDim2.new(1, 0, 0, 40)
Converted["_ControlBar"].Name = "ControlBar"
Converted["_ControlBar"].Parent = Converted["_ControlBarContainer"]

Converted["_UIListLayout9"].Padding = UDim.new(0, 5)
Converted["_UIListLayout9"].FillDirection = Enum.FillDirection.Horizontal
Converted["_UIListLayout9"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout9"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout9"].Parent = Converted["_ControlBar"]

Converted["_Visibility"].Font = Enum.Font.Gotham
Converted["_Visibility"].Text = "Mostrar u ocultar"
Converted["_Visibility"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Visibility"].TextScaled = true
Converted["_Visibility"].TextSize = 14
Converted["_Visibility"].TextWrapped = true
Converted["_Visibility"].BackgroundColor3 = Color3.fromRGB(46.000001057982445, 46.000001057982445, 46.000001057982445)
Converted["_Visibility"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Visibility"].BorderSizePixel = 0
Converted["_Visibility"].Size = UDim2.new(0, 200, 1, 0)
Converted["_Visibility"].Name = "Visibility"
Converted["_Visibility"].Parent = Converted["_ControlBar"]

Converted["_UICorner30"].CornerRadius = UDim.new(0, 16)
Converted["_UICorner30"].Parent = Converted["_Visibility"]

Converted["_UIPadding21"].PaddingBottom = UDim.new(0, 7)
Converted["_UIPadding21"].PaddingLeft = UDim.new(0, 7)
Converted["_UIPadding21"].PaddingRight = UDim.new(0, 7)
Converted["_UIPadding21"].PaddingTop = UDim.new(0, 7)
Converted["_UIPadding21"].Parent = Converted["_Visibility"]

Converted["_Event"].Parent = Converted["_Visibility"]

Converted["_themedColor14"].Value = "primaryColor"
Converted["_themedColor14"].Name = "themedColor"
Converted["_themedColor14"].Parent = Converted["_Visibility"]

Converted["_Lock1"].Font = Enum.Font.Gotham
Converted["_Lock1"].Text = "Bloquear tamaño"
Converted["_Lock1"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Lock1"].TextScaled = true
Converted["_Lock1"].TextSize = 14
Converted["_Lock1"].TextWrapped = true
Converted["_Lock1"].BackgroundColor3 = Color3.fromRGB(46.000001057982445, 46.000001057982445, 46.000001057982445)
Converted["_Lock1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Lock1"].BorderSizePixel = 0
Converted["_Lock1"].Size = UDim2.new(0, 200, 1, 0)
Converted["_Lock1"].Name = "Lock"
Converted["_Lock1"].Parent = Converted["_ControlBar"]

Converted["_UICorner31"].CornerRadius = UDim.new(0, 16)
Converted["_UICorner31"].Parent = Converted["_Lock1"]

Converted["_UIPadding22"].PaddingBottom = UDim.new(0, 7)
Converted["_UIPadding22"].PaddingLeft = UDim.new(0, 7)
Converted["_UIPadding22"].PaddingRight = UDim.new(0, 7)
Converted["_UIPadding22"].PaddingTop = UDim.new(0, 7)
Converted["_UIPadding22"].Parent = Converted["_Lock1"]

Converted["_Event1"].Parent = Converted["_Lock1"]

Converted["_themedColor15"].Value = "primaryColor"
Converted["_themedColor15"].Name = "themedColor"
Converted["_themedColor15"].Parent = Converted["_Lock1"]

Converted["_Exit"].Font = Enum.Font.GothamBold
Converted["_Exit"].Text = "X"
Converted["_Exit"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Exit"].TextScaled = true
Converted["_Exit"].TextSize = 14
Converted["_Exit"].TextWrapped = true
Converted["_Exit"].BackgroundColor3 = Color3.fromRGB(46.000001057982445, 0, 0)
Converted["_Exit"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Exit"].BorderSizePixel = 0
Converted["_Exit"].Size = UDim2.new(1, 0, 1, 0)
Converted["_Exit"].Name = "Exit"
Converted["_Exit"].Parent = Converted["_ControlBar"]

Converted["_UICorner32"].CornerRadius = UDim.new(0, 16)
Converted["_UICorner32"].Parent = Converted["_Exit"]

Converted["_UIPadding23"].PaddingBottom = UDim.new(0, 7)
Converted["_UIPadding23"].PaddingLeft = UDim.new(0, 7)
Converted["_UIPadding23"].PaddingRight = UDim.new(0, 7)
Converted["_UIPadding23"].PaddingTop = UDim.new(0, 7)
Converted["_UIPadding23"].Parent = Converted["_Exit"]

Converted["_UIAspectRatioConstraint"].Parent = Converted["_Exit"]

Converted["_themedColor16"].Value = "secondaryColor"
Converted["_themedColor16"].Name = "themedColor"
Converted["_themedColor16"].Parent = Converted["_Exit"]

Converted["_UIListLayout10"].Padding = UDim.new(0, 5)
Converted["_UIListLayout10"].HorizontalAlignment = Enum.HorizontalAlignment.Center
Converted["_UIListLayout10"].SortOrder = Enum.SortOrder.LayoutOrder
Converted["_UIListLayout10"].Parent = Converted["_ControlBarContainer"]

Converted["_Tip"].Font = Enum.Font.GothamBold
Converted["_Tip"].Text = "Arrastra el botón para cambiar el tamaño."
Converted["_Tip"].TextColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Tip"].TextScaled = true
Converted["_Tip"].TextSize = 14
Converted["_Tip"].TextWrapped = true
Converted["_Tip"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_Tip"].BackgroundTransparency = 1
Converted["_Tip"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_Tip"].BorderSizePixel = 0
Converted["_Tip"].Size = UDim2.new(1, 0, 0, 10)
Converted["_Tip"].Name = "Tip"
Converted["_Tip"].Parent = Converted["_ControlBarContainer"]

Converted["_UIStroke12"].Parent = Converted["_Tip"]

Converted["_UIScale6"].Parent = Converted["_ControlBarContainer"]

Converted["_FloatingButtons"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_FloatingButtons"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_FloatingButtons"].BackgroundTransparency = 1
Converted["_FloatingButtons"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_FloatingButtons"].BorderSizePixel = 0
Converted["_FloatingButtons"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_FloatingButtons"].Size = UDim2.new(1, 0, 1, 0)
Converted["_FloatingButtons"].ZIndex = 3
Converted["_FloatingButtons"].Name = "FloatingButtons"
Converted["_FloatingButtons"].Parent = Converted["_FloatingButtonSetting"]

Converted["_FloatingButtons1"].AnchorPoint = Vector2.new(0.5, 0.5)
Converted["_FloatingButtons1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Converted["_FloatingButtons1"].BackgroundTransparency = 1
Converted["_FloatingButtons1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
Converted["_FloatingButtons1"].BorderSizePixel = 0
Converted["_FloatingButtons1"].Position = UDim2.new(0.5, 0, 0.5, 0)
Converted["_FloatingButtons1"].Size = UDim2.new(1, 0, 1, 0)
Converted["_FloatingButtons1"].ZIndex = 3
Converted["_FloatingButtons1"].Name = "FloatingButtons"
Converted["_FloatingButtons1"].Parent = Converted["_TIESAS"]

-- Routine Module Scripts:

local routine_module_scripts = {}

do -- Routine Module: StarterGui.TIESAS.FUNCTIONS
    local script = Instance.new("ModuleScript")
    script.Name = "FUNCTIONS"
    script.Parent = Converted["_TIESAS"]
    local function module_script()

		local FUNCTIONSmodule = {}
		FUNCTIONSmodule.__v = "1.21"
		
		local ts = game:GetService("TweenService")
		local https = game:GetService("HttpService")
		
		
			
			
		function DraggableObjectf()
			local function a(b,c)local d=c.AbsoluteSize;local e=c.AbsolutePosition;local f=b.X.Scale*d.X+b.X.Offset;local g=b.Y.Scale*d.Y+b.Y.Offset;local h=math.clamp(f,0,d.X)local i=math.clamp(g,0,d.Y)local j=UDim2.new(b.X.Scale,h-b.X.Scale*d.X,b.Y.Scale,i-b.Y.Scale*d.Y)return j end;local k=UDim2.new;local l=game:GetService("UserInputService")local m=game:GetService("TweenService")local n={}n.__index=n;function n.new(o,p,q,r)local self={}self.Object=o;self.ToMove=p;self.Smooth=q;self.CallbackOnly=r;self.CanBeDragged=false;self.DragStarted=nil;self.DragEnded=nil;self.Dragged=nil;self.Dragging=false;self.LastPosition=nil;self.Velocity=Vector2.new(0,0)setmetatable(self,n)return self end;function n:Enable()self.CanBeDragged=true;local s=self.Object;local t=self.ToMove;local u=nil;local v=nil;local w=nil;local x=false;local function y(z)local A=z.Position-v;local B=UDim2.new(w.X.Scale,w.X.Offset+A.X,w.Y.Scale,w.Y.Offset+A.Y)if self.CallbackOnly then else B=a(B,self.Object:FindFirstAncestorWhichIsA("ScreenGui"))if(self.Smooth==nil or self.Smooth==true)and self.Smooth~=false then m:Create(t and t or s,TweenInfo.new(0.5,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out),{Position=B}):Play()else local C=t and t or s;C.Position=B end end;return B end;self.InputBegan=s.InputBegan:Connect(function(z)if z.UserInputType==Enum.UserInputType.MouseButton1 or z.UserInputType==Enum.UserInputType.Touch then x=true;local D;D=z.Changed:Connect(function()if z.UserInputState==Enum.UserInputState.End and(self.Dragging or x)then self.Dragging=false;D:Disconnect()if self.DragEnded and not x then self.DragEnded(self.Velocity)end;x=false end end)end end)self.InputChanged=s.InputChanged:Connect(function(z)if z.UserInputType==Enum.UserInputType.MouseMovement or z.UserInputType==Enum.UserInputType.Touch then u=z end end)self.InputChanged2=l.InputChanged:Connect(function(z)if s.Parent==nil then self:Disable()return end;if x then x=false;if self.DragStarted then self.DragStarted()end;self.Dragging=true;v=z.Position;if t then w=t.Position else w=s.Position end;self.LastPosition=z.Position end;if z==u and self.Dragging then local B=y(z)self.Velocity=z.Position-self.LastPosition;self.LastPosition=z.Position;if self.Dragged then self.Dragged(B)end end end)end;function n:Disable()self.CanBeDragged=false;self.InputBegan:Disconnect()self.InputChanged:Disconnect()self.InputChanged2:Disconnect()if self.Dragging then self.Dragging=false;if self.DragEnded then self.DragEnded(self.Velocity)end end end;return n	
		end
		local ManagedDraggableObject = {}
		ManagedDraggableObject.__index = ManagedDraggableObject

		local function clampGuiPosition(position, guiObject)
			local screenGui = guiObject and guiObject:FindFirstAncestorWhichIsA("ScreenGui")
			if not screenGui then return position end
			local bounds = screenGui.AbsoluteSize
			local x = math.clamp(
				position.X.Scale * bounds.X + position.X.Offset,
				0,
				bounds.X
			)
			local y = math.clamp(
				position.Y.Scale * bounds.Y + position.Y.Offset,
				0,
				bounds.Y
			)
			return UDim2.new(
				position.X.Scale,
				x - position.X.Scale * bounds.X,
				position.Y.Scale,
				y - position.Y.Scale * bounds.Y
			)
		end

		function ManagedDraggableObject.new(object, toMove, smooth, callbackOnly)
			return setmetatable({
				Object = object,
				ToMove = toMove,
				Smooth = smooth,
				CallbackOnly = callbackOnly,
				CanBeDragged = false,
				Dragging = false,
				Velocity = Vector2.zero,
				_connections = {},
			}, ManagedDraggableObject)
		end

		function ManagedDraggableObject:_disconnect()
			for index = #self._connections, 1, -1 do
				local connection = self._connections[index]
				appRuntime.release(connection)
				table.remove(self._connections, index)
			end
		end

		function ManagedDraggableObject:Enable()
			if self.CanBeDragged or not self.Object or not self.Object.Parent then return end
			self.CanBeDragged = true
			local userInputService = game:GetService("UserInputService")
			local tweenService = game:GetService("TweenService")
			local activeInput
			local pressed = false
			local startPosition
			local initialPosition

			local function remember(connection)
				table.insert(self._connections, appRuntime.track(connection))
			end

			remember(self.Object.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch then
					pressed = true
					local endedConnection
					endedConnection = appRuntime.track(input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							if self.Dragging and self.DragEnded then
								self.DragEnded(self.Velocity)
							end
							self.Dragging = false
							pressed = false
							appRuntime.release(endedConnection)
						end
					end))
				end
			end))

			remember(self.Object.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement
					or input.UserInputType == Enum.UserInputType.Touch then
					activeInput = input
				end
			end))

			remember(userInputService.InputChanged:Connect(function(input)
				if not self.Object.Parent then
					self:Disable()
					return
				end
				if pressed then
					pressed = false
					self.Dragging = true
					startPosition = input.Position
					initialPosition = (self.ToMove or self.Object).Position
					self.LastPosition = input.Position
					if self.DragStarted then self.DragStarted() end
				end
				if input ~= activeInput or not self.Dragging then return end

				local delta = input.Position - startPosition
				local nextPosition = UDim2.new(
					initialPosition.X.Scale,
					initialPosition.X.Offset + delta.X,
					initialPosition.Y.Scale,
					initialPosition.Y.Offset + delta.Y
				)
				if not self.CallbackOnly then
					nextPosition = clampGuiPosition(nextPosition, self.Object)
					local moving = self.ToMove or self.Object
					if self.Smooth == nil or self.Smooth then
						tweenService:Create(
							moving,
							TweenInfo.new(0.18, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
							{Position = nextPosition}
						):Play()
					else
						moving.Position = nextPosition
					end
				end
				self.Velocity = input.Position - self.LastPosition
				self.LastPosition = input.Position
				if self.Dragged then self.Dragged(nextPosition) end
			end))

			remember(self.Object.Destroying:Connect(function() self:Disable() end))
		end

		function ManagedDraggableObject:Disable()
			if not self.CanBeDragged and #self._connections == 0 then return end
			self.CanBeDragged = false
			if self.Dragging and self.DragEnded then
				self.DragEnded(self.Velocity)
			end
			self.Dragging = false
			self:_disconnect()
		end

		local DraggableObject = DraggableObjectf()
		FUNCTIONSmodule.DraggableObject = DraggableObject
		
		function ClickAndHoldf()
			local a={}a.__index=a;local b=game:GetService("UserInputService")function a.new(c,d)local self=setmetatable({},a)self.textButton=c;self.holdTime=d or 0.5;self.holdTask=nil;self.initialPosition=nil;self.Holded=Instance.new("BindableEvent")local function e(f,g)return math.sqrt((g.X-f.X)^2+(g.Y-f.Y)^2)end;self.textButton.MouseButton1Down:Connect(function(h,i)self.initialPosition=Vector2.new(h,i)self.holdTask=task.spawn(function()task.wait(self.holdTime)if self.holdTask then self.Holded:Fire()end end)end)b.InputChanged:Connect(function(j)if j.UserInputType==Enum.UserInputType.MouseMovement or j.UserInputType==Enum.UserInputType.Touch then if self.holdTask and self.initialPosition then local k=j.Position;local l=e(self.initialPosition,k)if l>10 then coroutine.close(self.holdTask)self.holdTask=nil end end end end)b.InputEnded:Connect(function(j)if j.UserInputType==Enum.UserInputType.MouseButton1 or j.UserInputType==Enum.UserInputType.Touch then if self.holdTask then coroutine.close(self.holdTask)self.holdTask=nil end;self.initialPosition=nil end end)return self end;return a
		end
		local ManagedClickAndHold = {}
		ManagedClickAndHold.__index = ManagedClickAndHold

		function ManagedClickAndHold.new(textButton, holdTime)
			local self = setmetatable({
				textButton = textButton,
				holdTime = holdTime or 0.5,
				holdTask = nil,
				initialPosition = nil,
				Holded = Instance.new("BindableEvent"),
				_connections = {},
			}, ManagedClickAndHold)
			local userInputService = game:GetService("UserInputService")

			local function remember(connection)
				table.insert(self._connections, appRuntime.track(connection))
			end
			local function cancelHold()
				if self.holdTask then
					pcall(task.cancel, self.holdTask)
					self.holdTask = nil
				end
				self.initialPosition = nil
			end

			remember(textButton.MouseButton1Down:Connect(function(x, y)
				cancelHold()
				self.initialPosition = Vector2.new(x, y)
				self.holdTask = task.delay(self.holdTime, function()
					if self.holdTask and textButton.Parent then
						self.holdTask = nil
						self.Holded:Fire()
					end
				end)
			end))
			remember(userInputService.InputChanged:Connect(function(input)
				if self.holdTask and self.initialPosition
					and (input.UserInputType == Enum.UserInputType.MouseMovement
						or input.UserInputType == Enum.UserInputType.Touch)
					and (input.Position - self.initialPosition).Magnitude > 10 then
					cancelHold()
				end
			end))
			remember(userInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch then
					cancelHold()
				end
			end))
			remember(textButton.Destroying:Connect(function() self:Destroy() end))
			return self
		end

		function ManagedClickAndHold:Destroy()
			if self.holdTask then pcall(task.cancel, self.holdTask) end
			self.holdTask = nil
			for index = #self._connections, 1, -1 do
				appRuntime.release(self._connections[index])
				table.remove(self._connections, index)
			end
			if self.Holded then
				self.Holded:Destroy()
				self.Holded = nil
			end
		end

		local ClickAndHold = ClickAndHoldf()
		function PointSavef()
			local _=false local function d(...)if _ then print("[PointSave DEBUG]:",...)end end getgenv()._FOLDERS=getgenv()._FOLDERS or{} getgenv()._FILES=getgenv()._FILES or{} isfolder=isfolder or function(_)d("Checking if folder exists:",_) return getgenv()._FOLDERS[_]~=nil end makefolder=makefolder or function(_)d("Creating folder:",_) getgenv()._FOLDERS[_]={} return getgenv()._FOLDERS[_]end isfile=isfile or function(_)d("Checking if file exists:",_) return getgenv()._FILES[_]~=nil end writefile=writefile or function(a,_)d("Writing file:",a,"with content:",_) getgenv()._FILES[a]=_ return getgenv()._FILES[a]end readfile=readfile or function(_)d("Reading file:",_) return getgenv()._FILES[_]end delfile=delfile or function(_)d("Deleting file:",_) getgenv()._FILES[_]=nil end listfiles=listfiles or function(c)d("Listing files in folder:",c) local _=getgenv()._FOLDERS[c] if _ then local a={} for b,_ in pairs(getgenv()._FILES)do if b:sub(1,#c+1)==c.."/"then local _=b:sub(#c+2) d("Found file in folder:",_) table.insert(a,_)end end return a end d("Folder does not exist:",c) return{}end local b={} b.__index=b local c="PointSaveData" local function _()if not isfolder(c)then d("Base folder not found, creating:",c) makefolder(c)else d("Base folder already exists:",c)end end function b.new(a)d("Initializing new PointSave instance for namespace:",a) _() local _=setmetatable({},b) _.namespace=a _.folderPath=c.."/"..a if not isfolder(_.folderPath)then d("Namespace folder does not exist, creating:",_.folderPath) makefolder(_.folderPath)else d("Namespace folder already exists:",_.folderPath)end return _ end function b:set(b,a)local _=self.folderPath.."/"..b..".txt" d("Setting value for key:",b,"->",a) writefile(_,tostring(a))end function b:get(a)local _=self.folderPath.."/"..a..".txt" d("Getting value for key:",a) if isfile(_)then local _=readfile(_) d("Found value for key:",a,"->",_) return _ end d("Key not found:",a) return nil end function b:remove(a)local _=self.folderPath.."/"..a..".txt" d("Removing key:",a) if isfile(_)then delfile(_) d("Removed file for key:",a)else d("File for key does not exist:",a)end end function b:clear()d("Clearing all keys in namespace:",self.namespace) local _=listfiles(self.folderPath) for _,_ in ipairs(_)do local _=self.folderPath.."/".._ if isfile(_)then d("Deleting file:",_) delfile(_)end end end function b.deleteNamespace(a)local b=c.."/"..a d("Deleting namespace:",a) local _=listfiles(b) for _,_ in ipairs(_)do local _=b.."/".._ if isfile(_)then d("Deleting file from namespace:",_) delfile(_)end end getgenv()._FOLDERS[b]=nil d("Deleted folder for namespace:",a)end function b.listNamespaces()d("Listing all namespaces") _() local b={} for a,_ in pairs(getgenv()._FOLDERS)do if a:sub(1,#c+1)==c.."/"then local _=a:sub(#c+2) d("Found namespace:",_) table.insert(b,_)end end return b end return b
		end
		local PointSave = PointSavef()
		function SBTf()
			-- Spring-based tweening module
			-- Implementation by TIESAS Team, respective credits towards the original creators for spring physics
		
			local a=function()local a=function()local a={}local function b(c,d,e,f,g,h)local i=d*d-4*e/c;local j=-0.5;local k=d+math.sqrt(i)local l=d-math.sqrt(i)local m,n=j*k,j*l;local o,p=(n*f-g)/(n-m),(m*f-g)/(m-n)local q=h/e;return{Offset=function(r)return o*math.exp(m*r)+p*math.exp(n*r)+q end,Velocity=function(r)return o*m*math.exp(m*r)+p*n*math.exp(n*r)end,Acceleration=function(r)return o*m*m*math.exp(m*r)+p*n*n*math.exp(n*r)end}end;local function s(c,d,e,f,g,h)local i=-d/2;local j,k=f,g-i*f;local l=h/e;return{Offset=function(m)return math.exp(i*m)*(j+k*m)+l end,Velocity=function(m)return math.exp(i*m)*(k*i*m+j*i+k)end,Acceleration=function(m)return i*math.exp(i*m)*(k*i*m+j*i+2*k)end}end;local function t(c,d,e,f,g,h)local i=d*d-4*e/c;local j=-d/2;local k=math.sqrt(-i)local l,m=f,(g-j*f)/k;local n=h/e;return{Offset=function(o)return math.exp(j*o)*(l*math.cos(k*o)+m*math.sin(k*o))+n end,Velocity=function(o)return-math.exp(j*o)*((l*k-m*j)*math.sin(k*o)+(-m*k-l*j)*math.cos(k*o))end,Acceleration=function(o)return-math.exp(j*o)*((m*k*k+2*l*j*k-m*j*j)*math.sin(k*o)+(l*k*k-2*m*j*k-l*j*j)*math.cos(k*o))end}end;function a.F(c)local d,e,f=c.InitialOffset,c.InitialVelocity,c.ExternalForce;local g,h,i=c.Mass,c.Damping,c.Constant;local j=h*h-4*i/g;if j>0 then return b(g,h,i,d,e,f)elseif j==0 then return s(g,h,i,d,e,f)else return t(g,h,i,d,e,f)end end;return a end;local c=a()local d=math.sqrt;local e=math.pi;local f={OFFSET="Offset",VELOCITY="Velocity",ACCELERATION="Acceleration",GOAL="Goal",FREQUENCY="Frequency"}local g=""local h=""local i={}local j={}j.__index=function(k,l)local m={[f.OFFSET]=function()local m=tick()-k.StartTick;local n=k.F;local o=n.Offset(m)return o end,[f.VELOCITY]=function()local m=tick()-k.StartTick;local n=k.F;local o=n.Velocity(m)return o end,[f.ACCELERATION]=function()local m=tick()-k.StartTick;local n=k.F;local o=n.Acceleration(m)return o end,[f.GOAL]=function()local m=k.ExternalForce;local n=k.Constant;return m/n end,[f.FREQUENCY]=function()local m=k.Damping;local n=k.Constant;local o=k.Mass;return d(-m*m+4*n/o)/(2*e)end}local n=rawget(k,l)if n~=nil then return n end;local o=m[l]if o~=nil then return o()end;return j[l]end;j.__tostring=function(k)local l=tick()-k.StartTick;local m=k.F;local n=k.AdvancedObjectStringEnabled;local o;if not n then o=string.format(g,m.Offset(l),m.Velocity(l),m.Acceleration(l))else o=string.format(h,k.Mass,k.Damping,k.Constant,k.Goal,k.Frequency,k.InitialOffset,k.InitialVelocity,k.ExternalForce,k.StartTick,m.Offset(l),m.Velocity(l),m.Acceleration(l))end;return o end;function i.fromDurationAndBounce(k,l)local m=1;local n=(2*math.pi/k)^2*m;local o=2*l*math.sqrt(m*n)return{m,o,n}end;function i.new(k,l,m,n,o,p)assert(k>0,"Mass for spring system cannot be less than or equal to 0")assert(m>0,"Spring constant for spring system cannot be less than or equal to 0")n=n or 0;o=o or 0;p=p or 0;local q=p*m;local r={Mass=k,Damping=l,Constant=m,InitialOffset=n-p,InitialVelocity=o,ExternalForce=q,AdvancedObjectStringEnabled=false,StartTick=0}setmetatable(r,j)r:Reset()return r end;function i.fromFrequency(k,l,m,n,o,p)assert(k>0,"Mass for spring system cannot be less than or equal to 0")assert(m>0,"Spring frequency for spring system cannot be less than or equal to 0")local q=0.25*k*(4*e*e*m*m+l*l)n=n or 0;o=o or 0;p=p or 0;local r=p*q;local u={Mass=k,Damping=l,Constant=q,InitialOffset=n-p,InitialVelocity=o,ExternalForce=r,AdvancedObjectStringEnabled=false,StartTick=0}setmetatable(u,j)u:Reset()return u end;function j.Reset(k)k.F=c.F(k)k.StartTick=tick()end;function j.SetExternalForce(k,l)k.ExternalForce=l;k.InitialOffset=k.Offset-l/k.Constant;k.InitialVelocity=k.Velocity;k:Reset()end;function j.SetGoal(k,l)k.ExternalForce=l*k.Constant;k.InitialOffset=k.Offset-l;k.InitialVelocity=k.Velocity;k:Reset()end;function j.SetFrequency(k,l)k.Constant=0.25*k.Mass*(4*e*e*l*l+k.Damping*k.Damping)k.InitialOffset=k.Offset;k.InitialVelocity=k.Velocity;k:Reset()end;function j.SnapToCriticalDamping(k)k.Damping=2*d(k.Constant/k.Mass)k.InitialOffset=k.Offset;k.InitialVelocity=k.Velocity;k:Reset()end;function j.SetOffset(k,l,m)k.InitialOffset=l-k.Goal;k.InitialVelocity=m and 0 or k.Velocity;k:Reset()end;function j.AddOffset(k,l)k.InitialOffset=k.Offset+l;k.InitialVelocity=k.Velocity;k:Reset()end;function j.SetVelocity(k,l)k.InitialOffset=k.Offset;k.InitialVelocity=l;k:Reset()end;function j.AddVelocity(k,l)k.InitialOffset=k.Offset;k.InitialVelocity=k.Velocity+l;k:Reset()end;function j.Print(k)local l=tostring(k)print(l)end;return i end;local c=a()local d=game:GetService"RunService"local e={}e.__index=e;function e.fromDurationAndBounce(f,g)local h=1;local i=(2*math.pi/f)^2*h;local j=2*(1-g)*math.sqrt(h*i)return{h,j,i}end;local f={number=function(f,g,h,i,j)local k=c.new(h,i,j,f[g],0,f[g])return{springType="number",springSet={k},updateFunc=function()f[g]=k.Offset end,setGoal=function(l)k:SetGoal(l)end}end,UDim2=function(f,g,h,i,j)local k=c.new(h,i,j,f[g].X.Offset,0,f[g].X.Offset)local l=c.new(h,i,j,f[g].X.Scale,0,f[g].X.Scale)local m=c.new(h,i,j,f[g].Y.Offset,0,f[g].Y.Offset)local n=c.new(h,i,j,f[g].Y.Scale,0,f[g].Y.Scale)return{springType="UDim2",springSet={XOffset=k,XScale=l,YOffset=m,YScale=n},updateFunc=function()f[g]=UDim2.new(l.Offset,k.Offset,n.Offset,m.Offset)end,setGoal=function(o)k:SetGoal(o.X.Offset)l:SetGoal(o.X.Scale)m:SetGoal(o.Y.Offset)n:SetGoal(o.Y.Scale)end}end,Vector2=function(f,g,h,i,j)local k=c.new(h,i,j,f[g].X,0,f[g].X)local l=c.new(h,i,j,f[g].Y,0,f[g].Y)return{springType="Vector2",springSet={X=k,Y=l},updateFunc=function()f[g]=Vector2.new(k.Offset,l.Offset)end,setGoal=function(m)k:SetGoal(m.X)l:SetGoal(m.Y)end}end,Vector3=function(f,g,h,i,j)local k=c.new(h,i,j,f[g].X,0,f[g].X)local l=c.new(h,i,j,f[g].Y,0,f[g].Y)local m=c.new(h,i,j,f[g].Z,0,f[g].Z)return{springType="Vector3",springSet={k,l,m},updateFunc=function()f[g]=Vector3.new(k.Offset,l.Offset,m.Offset)end,setGoal=function(n)k:SetTarget(n.X)l:SetTarget(n.Y)m:SetTarget(n.Z)end}end}function e.new(g,h,i,j,k)assert(g[h],"Property does not exist on object")local l=typeof(g[h])local m=f[l]if m then local n=setmetatable({},e)n.obj=g;n.propertyName=h;n.updater=nil;local o=m(g,h,i,j,k)n.springType=o.springType;n.springSet=o.springSet;n.updateFunc=o.updateFunc;n.setGoal=o.setGoal;return n else error("Type not supported: "..l)end end;function e.Start(g)if g.updater then return end;for h,i in pairs(g.springSet)do i:Reset()end;g.updater=d.RenderStepped:Connect(function(h)g.updateFunc()end)end;function e.Stop(g)if g.updater then g.updater:Disconnect()g.updater=nil end end;function e.SetGoal(g,h)g.setGoal(h)end;function e.SetParameters(g,h,i,j)for k,l in pairs(g.springSet)do l.Mass=h;l.Stiffness=i;l.Damping=j;l:Reset()end end;return e
		end
		local SBT = SBTf()
		
		
		
		local TIESASPointSave = PointSave.new("TIESAS")
		
		local States = {}
		local toggleStates = {}
		local rangeValueStates = {}
		getgenv().TIESAS_BUTTON_HEIGHT = getgenv().TIESAS_BUTTON_HEIGHT or 34
		getgenv().TIESAS_MENU_SCALE = getgenv().TIESAS_MENU_SCALE or 1
		getgenv().TIESAS_MENU_BUTTON_SIZE = getgenv().TIESAS_MENU_BUTTON_SIZE or 60
		local AREA = script.Parent.Menu.Area.Area
		local AREACONTAINER = script.Parent.Menu.Area
		
		local AREAModuleSelected = nil
		
		local fBSF = script.Parent.FloatingButtonSetting
		
		local function calculateWidth(n)
			if n <= 3 then
				return 30
			else
				local base = 30
				local additional = math.floor((n - 3) / 3) * 30
				return base + additional
			end
		end
		local function udim2Serializer(value)
			if typeof(value) == "UDim2" then
				return string.format("%g,%g,%g,%g", value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset)
			elseif typeof(value) == "string" then
				local xScale, xOffset, yScale, yOffset = string.match(value, "([^,]+),([^,]+),([^,]+),([^,]+)")
				assert(xScale and xOffset and yScale and yOffset, "Invalid UDim2 string format")
				return UDim2.new(tonumber(xScale), tonumber(xOffset), tonumber(yScale), tonumber(yOffset))
			end
		end
		local function lrp(a,b,t)
			return a + (b - a) * t
		end
		function roundNumber(num, numDecimalPlaces)
			return tonumber(string.format("%." .. numDecimalPlaces .. "f", num))
		end
		
		FUNCTIONSmodule.theme = {
			font = Enum.Font.Montserrat,
			textColor = Color3.fromRGB(69, 61, 82),
			accentColor = Color3.fromRGB(188, 166, 224),
			primaryColor = Color3.fromRGB(255, 248, 252),
			secondaryColor = Color3.fromRGB(242, 232, 247),

			backgroundColorCSQ = ColorSequence.new(Color3.fromRGB(233, 222, 246), Color3.fromRGB(252, 228, 238)),	
			strokeColorCSQ = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.fromRGB(194, 231, 218)),
				ColorSequenceKeypoint.new(0.25, Color3.fromRGB(213, 195, 239)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(250, 196, 216)),
				ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 222, 190)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(194, 231, 218))
			},
		}
		if getgenv then getgenv().TIESAS_THEME = FUNCTIONSmodule.theme end
		
		function FUNCTIONSmodule.getTheme()
			if getgenv then
				return getgenv().TIESAS_THEME or FUNCTIONSmodule.theme
			else
				return FUNCTIONSmodule.theme
			end
		end
		function FUNCTIONSmodule.setTheme(t)
			FUNCTIONSmodule.theme = t
			if getgenv then getgenv().TIESAS_THEME = t end
		end
		
		local floatingButtonObjects = {}
		local floatingButtonInvisibility = {}
		local floatingButtonDraggers = {}
		local floatingButtonKeybinds = {}
		local floatingButtonConnections = {}
		local floatingButtonGlobalConnections = {}
		
		local fBSFResizeDragger = nil
		getgenv().fBSFButton = nil
		getgenv().fBSFRealButton = nil
		getgenv().fBSF_ButtonDragger = nil
		
		local selected = Instance.new("ObjectValue")
		
		selected.Parent = script.Parent
		selected.Name = "Selected"
		
		local icons = {
			info = "rbxassetid://11780939099",
			x = "rbxassetid://10002373478",
			cross = "rbxassetid://10002373478",
			check = "rbxassetid://11604833061"
		}
		
		
		incomingNotif = false
		
		function FUNCTIONSmodule.to_base64(data)
			local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
			return ((data:gsub('.', function(x) 
				local r,b='',x:byte()
				for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
				return r;
			end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
				if (#x < 6) then return '' end
				local c=0
				for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
				return b:sub(c+1,c+1)
			end)..({ '', '==', '=' })[#data%3+1])
		end
		
		function FUNCTIONSmodule.from_base64(data)
			local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
			data = string.gsub(data, '[^'..b..'=]', '')
			return (data:gsub('.', function(x)
				if (x == '=') then return '' end
				local r,f='',(b:find(x)-1)
				for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
				return r;
			end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
				if (#x ~= 8) then return '' end
				local c=0
				for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
				return string.char(c)
			end))
		end
		
		function FUNCTIONSmodule.notification(s, color, icon)
			incomingNotif = true
			task.spawn(function()
				s = tostring(s)
				local notif = script.Parent.NotificationSample:Clone()
				notif.Parent = script.Parent
				notif.Position = UDim2.fromScale(0.5, -0.1)
				notif.UIScale.Scale = 0.5
				notif.Visible = true
				notif.Name = s
		
				if color and typeof(icon) == "Color3" then
					notif.UIStroke.Color = color
					notif.ImageLabel.ImageColor3 = color
				end
		
				if icon then
					if icons[icon] then notif.ImageLabel.Image = icons[icon] else
						if tonumber(icon) then
							notif.ImageLabel.Image = "rbxassetid://" .. tonumber(icon)
						else
							notif.ImageLabel.Image = icon
						end
					end
				end
		
				notif.TextLabel.MaxVisibleGraphemes = 0
				notif.TextLabel.Text = s
				notif:SetAttribute("close", false)
				ts:Create(notif, TweenInfo.new(0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Position = UDim2.new(0.5, 0, 0, 10)
				}):Play()
		
				ts:Create(notif.UIScale, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Scale = 0.8
				}):Play()
		
				ts:Create(notif.TextLabel, TweenInfo.new(0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					MaxVisibleGraphemes = #s
				}):Play()
		
				notif.Close.MouseButton1Click:Connect(function()
					notif:SetAttribute("close", true)
				end)
		
				task.wait()
				incomingNotif = false
				local lastclock = os.clock()
				repeat task.wait() until os.clock()-lastclock > 5 or incomingNotif or notif:GetAttribute("close")
		
				local finish = ts:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Position = UDim2.fromScale(0.5, -0.1)
				})
				finish:Play()
				finish.Completed:Connect(function()
					notif:Destroy()
				end)
			end)
		end
		
		local lockMode = false
		function FUNCTIONSmodule.lockModeSet(s)
			lockMode = s
		end
		
		function FUNCTIONSmodule.closeFinetuneFB()
			for _, b in ipairs(script.Parent.FloatingButtons:GetChildren()) do
				if b:IsA("TextButton") and b:FindFirstChildWhichIsA("UIScale") then
					local buttonScale = b:FindFirstChildWhichIsA("UIScale")
					ts:Create(buttonScale, TweenInfo.new(0.3), {
						Scale = 1
					}):Play()
				end
			end
		
			local buttonScale = getgenv().fBSFButton:FindFirstChildWhichIsA("UIScale") or Instance.new("UIScale", getgenv().fBSFButton)
			ts:Create(buttonScale, TweenInfo.new(0.3), {
				Scale = 0
			}):Play()
			ts:Create(fBSF, TweenInfo.new(0.3), {
				BackgroundTransparency = 1
			}):Play()
			local done = ts:Create(fBSF.ControlBarContainer.UIScale, TweenInfo.new(0.3), {
				Scale = 0
			})
			done:Play()
			done.Completed:Wait()
			--for _, b in ipairs(script.Parent.FloatingButtons:GetChildren()) do
			--	if b:FindFirstChildWhichIsA("UIScale") then
			--		b:FindFirstChildWhichIsA("UIScale"):Destroy()
			--	end
			--end
			getgenv().fBSFButton:Destroy()
			fBSF.Visible = false
		
			getgenv().fBSFButton = nil
			getgenv().fBSFRealButton = nil
			getgenv().fBSF_ButtonDragger = nil
		end
		
		function FUNCTIONSmodule.finetuneFloatingButton(button: TextButton, dragger)
			if getgenv().fBSFRealButton then return end
			getgenv().fBSFRealButton = button
			for _, b in ipairs(script.Parent.FloatingButtons:GetChildren()) do
				if b:IsA("TextButton") and b:FindFirstChildWhichIsA("UIScale") then
					local buttonScale = b:FindFirstChildWhichIsA("UIScale")
					ts:Create(buttonScale, TweenInfo.new(0.3), {
						Scale = 0
					}):Play()
				end
			end
		
			local finetuningButton = button:Clone()
			getgenv().fBSFButton = finetuningButton
			finetuningButton.Parent = fBSF
			finetuningButton.Name = "fBSFButton"
			finetuningButton.AnchorPoint = Vector2.new(0, 0)
			finetuningButton.Position = UDim2.fromOffset(button.AbsolutePosition.X, button.AbsolutePosition.Y + game:GetService("GuiService"):GetGuiInset().Y)
		
			fBSFResizeDragger = DraggableObject.new(finetuningButton, nil, nil, true)
		
			getgenv().fBSF_ButtonDragger = dragger
			local startingSize = finetuningButton.Size
			fBSFResizeDragger.DragStarted = function()
				startingSize = finetuningButton.Size
			end
			fBSFResizeDragger.Dragged = function(pos)
				local newSize =  UDim2.fromOffset(math.clamp(startingSize.X.Offset + pos.X.Offset, 30, 500), math.clamp(startingSize.Y.Offset + pos.Y.Offset, 10, 350))
				ts:Create(finetuningButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = newSize
				}):Play()
				button.Size = newSize
				TIESASPointSave:set(string.gsub(button.Name, "_", ""), udim2Serializer(button.Position) .. "|" .. udim2Serializer(button.Size) .. "|" .. tostring(button.Visible) .. "|" .. tostring(dragger.CanBeDragged))
			end
			fBSFResizeDragger:Enable()
		
			fBSF.ControlBarContainer.UIScale.Scale = 0
			fBSF.BackgroundTransparency = 1
			fBSF.Visible = true
			ts:Create(fBSF, TweenInfo.new(0.3), {
				BackgroundTransparency = 0.5
			}):Play()
			ts:Create(fBSF.ControlBarContainer.UIScale, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Scale = 1
			}):Play()
			ts:Create(finetuningButton, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5)
			}):Play()
		
			if finetuningButton.BackgroundTransparency == 1 then
				finetuningButton.Lock.TextTransparency = 0
				ts:Create(finetuningButton, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
					BackgroundTransparency = 0.5,
					TextTransparency = 0.5
				}):Play()
				ts:Create(finetuningButton.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
					Transparency = 0.5
				}):Play()
			end
		
			
		end
		
		function FUNCTIONSmodule.ftToggleLock()
			if getgenv().fBSF_ButtonDragger.CanBeDragged then
				getgenv().fBSF_ButtonDragger:Disable()
				getgenv().fBSFRealButton.Lock.UIScale.Scale = 1
				ts:Create(getgenv().fBSFButton.Lock.UIScale, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Scale = 1
				}):Play()
			else
				getgenv().fBSF_ButtonDragger:Enable()
				getgenv().fBSFRealButton.Lock.UIScale.Scale = 0
				ts:Create(getgenv().fBSFButton.Lock.UIScale, TweenInfo.new(0.3), {
					Scale = 0
				}):Play()
			end
			TIESASPointSave:set(string.gsub(getgenv().fBSFRealButton.Name, "_", ""), udim2Serializer(getgenv().fBSFRealButton.Position) .. "|" .. udim2Serializer(getgenv().fBSFRealButton.Size) .. "|" .. tostring(getgenv().fBSFRealButton.Visible) .. "|" .. tostring(getgenv().fBSF_ButtonDragger.CanBeDragged))
		end
		
		function FUNCTIONSmodule.ftToggleVisibility()
			if getgenv().fBSFButton.BackgroundTransparency == 0 then
				getgenv().fBSFRealButton.BackgroundTransparency = 1
				getgenv().fBSFRealButton.TextTransparency = 1
				getgenv().fBSFRealButton.UIStroke.Transparency = 1
				getgenv().fBSFRealButton.Lock.TextTransparency = 1
		
				ts:Create(getgenv().fBSFButton, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
					BackgroundTransparency = 0.5,
					TextTransparency = 0.5
				}):Play()
				ts:Create(getgenv().fBSFButton.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
					Transparency = 0.5
				}):Play()
			else
				getgenv().fBSFRealButton.BackgroundTransparency = 0
				getgenv().fBSFRealButton.TextTransparency = 0
				getgenv().fBSFRealButton.UIStroke.Transparency = 0
				getgenv().fBSFRealButton.Lock.TextTransparency = 0
		
				ts:Create(getgenv().fBSFButton, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
					BackgroundTransparency = 0,
					TextTransparency = 0
				}):Play()
				ts:Create(getgenv().fBSFButton.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
					Transparency = 0
				}):Play()
			end
			TIESASPointSave:set(string.gsub(getgenv().fBSFRealButton.Name, "_", ""), udim2Serializer(getgenv().fBSFRealButton.Position) .. "|" .. udim2Serializer(getgenv().fBSFRealButton.Size) .. "|" .. tostring(getgenv().fBSFRealButton.Visible) .. "|" .. tostring(getgenv().fBSF_ButtonDragger.CanBeDragged))
		end
		
		function FUNCTIONSmodule.createFloatingButton(item,button,buttonname,fromload)
			local normalizedName = string.gsub(buttonname, "_", "")
			local existingButton = getgenv().TIESAS.FloatingButtons:FindFirstChild(normalizedName)
			-- La carga inicial debe ser idempotente. Antes, encontrar SHOOT ya
			-- creado entraba en la rama de borrado y causaba una carrera con Init.
			if existingButton and fromload then return existingButton end
			if not existingButton then
				
				
				local UserInputService = game:GetService("UserInputService")
				local savedButtonData = TIESASPointSave:get(normalizedName)
				if not savedButtonData then
					TIESASPointSave:set(normalizedName, udim2Serializer(UDim2.fromOffset(125, 90)) .. "|" .. udim2Serializer(UDim2.fromOffset(200,50)) .. "|true|true")
				end
		
				local newFloatingButton = getgenv().TIESAS.FloatingButton:Clone()
				newFloatingButton.Parent = getgenv().TIESAS.FloatingButtons
				
				newFloatingButton.Name = normalizedName
				newFloatingButton.Text = string.gsub(buttonname, "_", " ")
				
				newFloatingButton.BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor
				local themedColor = Instance.new("StringValue", newFloatingButton)
				themedColor.Name = "themedColor"
				themedColor.Value = "primaryColor"
				newFloatingButton.Visible = true
				
				newFloatingButton.Font = Enum.Font.Montserrat
		
				table.insert(floatingButtonObjects, newFloatingButton)
				local floatingButtonObjectSelf = floatingButtonObjects[#floatingButtonObjects]
		
				newFloatingButton.MouseButton1Click:Connect(function()
					if typeof(item["Args"][2]) == "function" then
						item["Args"][2](button)
					else
						item["Args"][2][buttonname](button)
					end
				end)
				
				local ripple
				
				newFloatingButton.MouseButton1Down:Connect(function(x, y)
					ts:Create(newFloatingButton.UIScale, TweenInfo.new(0.1), {
						Scale = 0.95
					}):Play()
					
					
					ripple = newFloatingButton.Ripple:Clone()
					ripple.BackgroundColor3 = FUNCTIONSmodule.getTheme().textColor
					ripple.Parent = newFloatingButton
					ripple.Position = UDim2.fromOffset(x - newFloatingButton.AbsolutePosition.X, (y - newFloatingButton.AbsolutePosition.Y) - game:GetService("GuiService"):GetGuiInset().Y)
					ts:Create(ripple, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
						BackgroundTransparency = 0.6,
						Size = UDim2.fromOffset(50, 50)
					}):Play()
				end)
				
				
				local function closeRipple()
					if not getgenv().fBSFRealButton then
						ts:Create(newFloatingButton.UIScale, TweenInfo.new(0.1), {
							Scale = 1
						}):Play()
					end
		
					if ripple then
						task.spawn(function()
							local rippleToRemove = ripple
							local fade = ts:Create(rippleToRemove, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
								BackgroundTransparency = 1,
								Size = UDim2.fromOffset(150, 150)
							})
							fade:Play()
							fade.Completed:Once(function()
								rippleToRemove:Destroy()
							end)
						end)
					end
				end
				local releaseRippleConnection = appRuntime.track(UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
						closeRipple()
					end
				end))
				floatingButtonGlobalConnections[normalizedName] = {releaseRippleConnection}
				
				local shouldBeDraggable = true
				if not fromload then
					newFloatingButton.Position = UDim2.fromOffset(-125, 90)
				elseif savedButtonData then
					local data = savedButtonData:split("|")
					newFloatingButton.Position = udim2Serializer(data[1])
					ts:Create(newFloatingButton, TweenInfo.new(2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
						Size = udim2Serializer(data[2])
					}):Play()
					newFloatingButton.Visible = (data[3] == "true")
					if data[4] == "false" then
						newFloatingButton.Lock.UIScale.Scale = 1
						shouldBeDraggable = false
					end
				end
		
				task.spawn(function()
					if not fromload then
						ts:Create(newFloatingButton, TweenInfo.new(2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
							Size = UDim2.fromOffset(200, 50)
						}):Play()
						ts:Create(newFloatingButton, TweenInfo.new(0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
							Position = UDim2.fromOffset(125, 90)
						}):Play()
					end
				end)
		
				floatingButtonDraggers[string.gsub(buttonname, "_", "")] = DraggableObject.new(newFloatingButton)
				if shouldBeDraggable then
					floatingButtonDraggers[string.gsub(buttonname, "_", "")]:Enable()
				end
				floatingButtonDraggers[string.gsub(buttonname, "_", "")].Dragged = function(newPos)
					TIESASPointSave:set(string.gsub(buttonname, "_", ""), udim2Serializer(newPos) .. "|" .. udim2Serializer(newFloatingButton.Size) .. "|" .. tostring(newFloatingButton.Visible) .. "|" .. tostring(floatingButtonDraggers[string.gsub(buttonname, "_", "")].CanBeDragged))
				end
		
				local holder = ClickAndHold.new(newFloatingButton)
				holder.Holded.Event:Connect(function()
					if floatingButtonDraggers[string.gsub(buttonname, "_", "")].Dragging then return end
					if ripple then
						ripple:Destroy()
					end
					FUNCTIONSmodule.finetuneFloatingButton(floatingButtonObjectSelf, floatingButtonDraggers[string.gsub(buttonname, "_", "")])
				end)
		
				newFloatingButton.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton2 then
						FUNCTIONSmodule.notification("Press a key to bind " .. string.gsub(buttonname, "_", "") .. " to...")
						local keytobind
						local result
						repeat
							result = UserInputService.InputBegan:Wait()
							if result.UserInputType == Enum.UserInputType.Keyboard then keytobind = result.KeyCode end
						until keytobind
		
						FUNCTIONSmodule.notification(string.gsub(buttonname, "_", "") .. " binded to key " .. result.KeyCode.Name .. "!")
						task.wait(0.1) floatingButtonKeybinds[string.gsub(buttonname, "_", "")] = keytobind	
					end
				end)
		
				local uis = game:GetService("UserInputService")
				if uis.KeyboardEnabled and uis.MouseEnabled then
					floatingButtonConnections[string.gsub(buttonname, "_", "")] = appRuntime.track(uis.InputBegan:Connect(function(inp, processed)
						if processed then return end
						if inp.KeyCode == floatingButtonKeybinds[string.gsub(buttonname, "_", "")] then
							if typeof(item["Args"][2]) == "function" then
								item["Args"][2](button)
							else
								item["Args"][2][buttonname](button)
							end
						end
					end))
					table.insert(
						floatingButtonGlobalConnections[normalizedName],
						floatingButtonConnections[normalizedName]
					)
				end
		
			else
				floatingButtonKeybinds[string.gsub(buttonname, "_", "")] = nil
				if floatingButtonConnections[string.gsub(buttonname, "_", "")] then
					floatingButtonConnections[string.gsub(buttonname, "_", "")] = nil
				end
				for _, connection in ipairs(floatingButtonGlobalConnections[normalizedName] or {}) do
					appRuntime.release(connection)
				end
				floatingButtonGlobalConnections[normalizedName] = nil
				TIESASPointSave:remove(string.gsub(buttonname, "_", ""))
				task.spawn(function()
					local buttontodestroy = getgenv().TIESAS.FloatingButtons:FindFirstChild(string.gsub(buttonname, "_", ""))
					local btdtween = ts:Create(buttontodestroy, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
						Size = UDim2.new(0,0,0,0)
					})
					btdtween:Play()
					btdtween.Completed:Wait()
					buttontodestroy:Destroy()
				end)
			end
		end
		
		function FUNCTIONSmodule.loadFloatingButtons()
			repeat task.wait() until getgenv().Modules
			for _, module in ipairs(getgenv().Modules) do
				for _, item in ipairs(module) do
					if item["Type"] == "Button" then
						local key = string.gsub(item["Args"][1], "_", "")
						local saved = TIESASPointSave:get(key)
						if saved or item["FloatingDefault"] then
							FUNCTIONSmodule.createFloatingButton(item, Instance.new("TextButton"), item["Args"][1], true)
						end
					end
				end
			end
		end
		function FUNCTIONSmodule.loader(module)
			--local unloadtween = ts:Create(AREA, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			--	Position = UDim2.fromScale(1.55, 0.606)
			--})
		
			--unloadtween:Play()
			--unloadtween.Completed:Wait()
		
		
			local AREAframes = {}
			for _, i in ipairs(AREA:GetChildren()) do if i:IsA("Frame") then table.insert(AREAframes, i) end end
			if #AREAframes > 5 then
				ts:Create(AREA, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { CanvasPosition = Vector2.zero }):Play()
				for i=1, math.min(7, #AREAframes) do
					task.wait(0.01)
					ts:Create(AREAframes[i]:GetChildren()[1], TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
						Position = UDim2.fromScale(2, 0)
					}):Play()
				end
				task.wait(0.18)
			end
		
			AREA:ClearAllChildren()
			
			
			local listlayout = Instance.new("UIListLayout")
			listlayout.Parent = AREA
			listlayout.Padding = UDim.new(0, 10)
			listlayout.FillDirection = Enum.FillDirection.Vertical
			listlayout.SortOrder = Enum.SortOrder.LayoutOrder
			listlayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			
			
			for _, item in ipairs(module) do
				local frameHolder = Instance.new("Frame")
				frameHolder.Name = "Holder"
				frameHolder.BackgroundTransparency = 1
				frameHolder.Size = UDim2.new(1,0,0,0)
				frameHolder.AutomaticSize = Enum.AutomaticSize.XY
				frameHolder.Parent = AREA
		
				if item["Type"] == "Text" then
		
					local text = Instance.new("TextLabel")
					text.Parent = frameHolder
		
					text.BackgroundTransparency = 1
					text.Text = item["Args"][1]
					text.TextScaled = true
					text.TextColor3 = FUNCTIONSmodule.getTheme().textColor
					text.Font = Enum.Font.GothamBold
					text.Size = UDim2.new(1,0,0,20)
					text.TextXAlignment = item["Args"][2] == "center" and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
					text.RichText = true
		
		
				elseif item["Type"] == "Button" then
		
					local button = Instance.new("TextButton")
					button.Parent = frameHolder
		
					button.BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor
					button.Text = item["Args"][1]
					button.TextScaled = true
					button.TextColor3 = FUNCTIONSmodule.getTheme().textColor
					button.Font = Enum.Font.GothamBold
					button.Size = UDim2.new(1, 0, 0, getgenv().TIESAS_BUTTON_HEIGHT)
					button:SetAttribute("TiesasResizableButton", true)
		
					local padding = Instance.new("UIPadding")
					padding.Parent = button
		
					padding.PaddingTop = UDim.new(0, 5)
					padding.PaddingBottom = UDim.new(0, 5)
		
		
					local corner = Instance.new("UICorner", button)
					corner.CornerRadius = UDim.new(0, 10)
					local stroke = Instance.new("UIStroke", button)
					stroke.Color = Color3.fromRGB(215, 198, 235)
					stroke.Transparency = 0.35
					stroke.Thickness = 1
		
					local hold = false
		
					button.MouseButton1Click:Connect(function()
						item["Args"][2](button)
					end)
					
					local cah = ClickAndHold.new(button, 0.5)
					cah.Holded.Event:Connect(function()
						FUNCTIONSmodule.createFloatingButton(item, button, item["Args"][1])
					end)
		
					
				elseif item["Type"] == "ButtonGrid" then
		
		
		
		
					local frame = Instance.new("Frame")
					frame.Parent = frameHolder
					frame.Size = UDim2.new(1, 0, 0, 0)
					frame.AutomaticSize = Enum.AutomaticSize.Y
					frame.BackgroundTransparency = 1
		
		
					local gridlayout = Instance.new("UIGridLayout")
					gridlayout.Parent = frame
					gridlayout.CellSize = UDim2.new((1 / item["Args"][1]) - 0.03, 0, 0, getgenv().TIESAS_BUTTON_HEIGHT)
					gridlayout:SetAttribute("TiesasResizableGrid", true)
		
					--print("------")
					--print(item["Args"][2])
					--print(States)
					for buttonname, args in item["Args"][2] do
						local button = Instance.new("TextButton")
						button.Parent = frame
		
						--print(args)
						if States[buttonname .. module.Name] == nil
							and item["DefaultStates"]
							and table.find(item["DefaultStates"], buttonname)
						then
							States[buttonname .. module.Name] = true
						end
						button.BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor
						if States[buttonname .. module.Name] then
							button.BackgroundColor3 = FUNCTIONSmodule.getTheme().accentColor
						end
						button.Text = string.gsub(buttonname, "_", " ")
						button.TextScaled = true
						button.TextColor3 = FUNCTIONSmodule.getTheme().textColor
						button.Font = Enum.Font.GothamBold
						button:SetAttribute("TiesasResizableButton", true)
		
						local padding = Instance.new("UIPadding")
						padding.Parent = button
		
						padding.PaddingTop = UDim.new(0, 5)
						padding.PaddingBottom = UDim.new(0, 5)
		
						local corner = Instance.new("UICorner", button)
						corner.CornerRadius = UDim.new(0, 10)
						local stroke = Instance.new("UIStroke", button)
						stroke.Color = Color3.fromRGB(215, 198, 235)
						stroke.Transparency = 0.35
						stroke.Thickness = 1
		
						button.MouseButton1Click:Connect(function()
							if item["Toggleable"] then
								item["Args"][2][buttonname](button)
								--print(States[buttonname .. module.Name])
								if States[buttonname .. module.Name] then
									ts:Create(button, TweenInfo.new(0.3), {
										BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor
									}):Play()
									States[buttonname .. module.Name] = false
								else
									ts:Create(button, TweenInfo.new(0.3), {
										BackgroundColor3 = FUNCTIONSmodule.getTheme().accentColor
									}):Play()
									States[buttonname .. module.Name] = true
								end
							else
								item["Args"][2][buttonname](button)
							end
						end)
		
						local cah = ClickAndHold.new(button, 0.5)
						cah.Holded.Event:Connect(function()
							FUNCTIONSmodule.createFloatingButton(item, button, buttonname)
						end)
					end
		
		
				elseif item["Type"] == "Input" then
					local cloneinput = getgenv().TIESAS.TextBoxPlaceholder:Clone()
					cloneinput.Parent = frameHolder
					cloneinput.Visible = true
					
					cloneinput.TextBox.PlaceholderText = item["Args"][1]
					cloneinput.TextButton.Text = item["Args"][2]
					
					cloneinput.TextBox.TextColor3 = FUNCTIONSmodule.getTheme().textColor
					cloneinput.TextButton.TextColor3 = FUNCTIONSmodule.getTheme().textColor
					
					cloneinput.TextBox.BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor
					cloneinput.TextButton.BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor
		
		
					cloneinput.TextButton.MouseButton1Click:Connect(function()
						item["Args"][3](cloneinput.TextButton, cloneinput.TextBox.Text)
					end)
				elseif item["Type"] == "Toggle" then
					local clonetoggle = getgenv().TIESAS.Toggle:Clone()
					clonetoggle.Parent = frameHolder
					clonetoggle.Visible = true
		
					clonetoggle.TextLabel.Text = item["Args"][1]
					clonetoggle.TextLabel.TextColor3 = FUNCTIONSmodule.getTheme().textColor
					clonetoggle.TextLabel.Font = Enum.Font.Montserrat
		
		
		
					local clonetoggletoggler = clonetoggle.Frame.Frame.Toggler
					
					clonetoggletoggler.ImageLabel.ImageColor3 = FUNCTIONSmodule.getTheme().accentColor
					clonetoggletoggler.Parent.BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor
					if toggleStates[item["Args"][1] .. module.Name] then
						clonetoggletoggler.Position = UDim2.fromScale(0.7, 0.5)
						clonetoggletoggler.ImageLabel.Image = "rbxassetid://5959696880"
					end
		
					clonetoggletoggler.MouseButton1Click:Connect(function()
						if toggleStates[item["Args"][1] .. module.Name] then
							toggleStates[item["Args"][1] .. module.Name] = false
							ts:Create(clonetoggletoggler, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
								Position = UDim2.fromScale(0.3, 0.5)
							}):Play()
							clonetoggletoggler.ImageLabel.Image = "rbxassetid://10002373478"
						else
							toggleStates[item["Args"][1] .. module.Name] = true
							ts:Create(clonetoggletoggler, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
								Position = UDim2.fromScale(0.7, 0.5)
							}):Play()
							clonetoggletoggler.ImageLabel.Image = "rbxassetid://5959696880"
						end
						item["Args"][2](clonetoggletoggler, toggleStates[item["Args"][1] .. module.Name])
					end)
				elseif item["Type"] == "Dropdown" then	
					local clonedropdown = getgenv().TIESAS.Dropdown:Clone()
					local dropdownFrame = getgenv().TIESAS.DropdownFrameSample
					clonedropdown.Parent = frameHolder
					clonedropdown.Visible = true
		
					clonedropdown.TextLabel.Text = item["Args"][1]
					clonedropdown.Frame.MouseButton1Click:Connect(function()
						for _, v in ipairs(dropdownFrame.ScrollingFrame:GetChildren()) do if v:IsA("TextButton") and v.Name ~= "Sample" then v:Destroy() end end
						local mouse = game.Players.LocalPlayer:GetMouse()
						dropdownFrame.Position = UDim2.fromOffset(mouse.X, mouse.Y - 55)
						dropdownFrame.Size = UDim2.new(0,108/2,0,0)
						dropdownFrame.Visible = true
						ts:Create(dropdownFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
							Size = UDim2.fromOffset(108, 239)
						}):Play()
		
						local items
						if typeof(item["Args"][2]) == "function" then
							items = item["Args"][2]()
						else
							items = item["Args"][2]
						end
		
						for _, v in ipairs(items) do
							local clonedropdownbutton = dropdownFrame.ScrollingFrame.Sample:Clone()
							clonedropdownbutton.Parent = dropdownFrame.ScrollingFrame
							clonedropdownbutton.Name = v
							clonedropdownbutton.Visible = true
							clonedropdownbutton.Text = v
							clonedropdownbutton.MouseButton1Click:Connect(function()
								--dropdownFrame.Visible = false
								clonedropdown.Frame.Text = v
								item["Args"][3](clonedropdown.Frame, v)
								local after = ts:Create(dropdownFrame, TweenInfo.new(0.1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
									Size = UDim2.fromOffset(108/2, 0)
								})
								after:Play()
								after.Completed:Once(function()
									dropdownFrame.Visible = false
								end)
							end)
						end
					end)
				elseif item["Type"] == "Range" then
					local clonerange = getgenv().TIESAS.Range:Clone()
					clonerange.Parent = frameHolder
					clonerange.Visible = true
		
					clonerange.TextLabel.Text = item["Args"][1]
					clonerange.TextLabel.TextColor3 = FUNCTIONSmodule.getTheme().textColor
					clonerange.TextLabel.Font = Enum.Font.Montserrat
					
					clonerange.Frame.Track.Ball.BackgroundColor3 = FUNCTIONSmodule.getTheme().accentColor
					clonerange.Frame.Track.BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor
					
					if not rangeValueStates[item["Args"][1] .. module.Name] then
						rangeValueStates[item["Args"][1] .. module.Name] = item["Args"][2]
					end
					clonerange.Frame.Track.Ball.Size = UDim2.new(lrp(0.06, 1, rangeValueStates[item["Args"][1] .. module.Name] / item["Args"][3]), 0, 1, 0)
		
					local slider = DraggableObject.new(clonerange.Frame, nil, false, true)
					slider:Enable()
					
					local relativeSlide = nil
					slider.Dragged = function(pos: UDim2)
						if not relativeSlide then relativeSlide = pos end
						local dragDistance = pos - relativeSlide
						
						local resolvedVal = rangeValueStates[item["Args"][1] .. module.Name]
						local deltaChange = dragDistance.X.Offset
						if math.abs(deltaChange) * 2 > item["Args"][4] then
							resolvedVal = math.clamp(resolvedVal + deltaChange, 0, item["Args"][3])
							relativeSlide = pos
							
							if item["Args"][4] > 1 then
								resolvedVal = math.round(resolvedVal)
							end
							
							rangeValueStates[item["Args"][1] .. module.Name] = resolvedVal
						end
						
						clonerange.Frame.Track.Ball.Size = UDim2.new(lrp(0.06, 1, resolvedVal / item["Args"][3]), 0, 1, 0)
		
						
						
						clonerange.Frame.Track.Ball.BallProgress.Text = roundNumber(resolvedVal, 2)
						clonerange.Frame.Track.TrackProgress.Text = tostring(resolvedVal, 2)
						if resolvedVal > item["Args"][3] / 2 then
							ts:Create(clonerange.Frame.Track.Ball.BallProgress, TweenInfo.new(0.2), {
								TextTransparency = 0,
								TextStrokeTransparency = 0
							}):Play()
							ts:Create(clonerange.Frame.Track.TrackProgress, TweenInfo.new(0.2), {
								TextTransparency = 1,
								TextStrokeTransparency = 1
							}):Play()
						else
							ts:Create(clonerange.Frame.Track.Ball.BallProgress, TweenInfo.new(0.2), {
								TextTransparency = 1,
								TextStrokeTransparency = 1
							}):Play()
							ts:Create(clonerange.Frame.Track.TrackProgress, TweenInfo.new(0.2), {
								TextTransparency = 0,
								TextStrokeTransparency = 0
							}):Play()
						end
						
						rangeValueStates[item["Args"][1] .. module.Name] = resolvedVal
						
						if item["Args"][5] then
							item["Args"][5](clonerange, resolvedVal)
						end
					end
					
					slider.DragEnded = function()
						relativeSlide = nil
						ts:Create(clonerange.Frame.Track.Ball.BallProgress, TweenInfo.new(0.2), {
							TextTransparency = 1,
							TextStrokeTransparency = 1
						}):Play()
						ts:Create(clonerange.Frame.Track.TrackProgress, TweenInfo.new(0.2), {
							TextTransparency = 1,
							TextStrokeTransparency = 1
						}):Play()
					end
		
						
				end
				
		
		
			end
			
			--if AREACONTAINER:FindFirstChildWhichIsA("UIListLayout") then
			--	AREACONTAINER:FindFirstChildWhichIsA("UIListLayout"):Destroy()
			--end -- idk where this instance coming from sorry
			AREACONTAINER.Area.Position = UDim2.fromScale(0.5, 0.5)
			ts:Create(AREACONTAINER.Area, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
				Position = UDim2.fromScale(0.5, 0.5)
			}):Play()
		
			ts:Create(listlayout, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
				Padding = UDim.new(0, 10)
			}):Play()
			local AREAframes = {}
			for _, i in ipairs(AREA:GetChildren()) do if i:IsA("Frame") then table.insert(AREAframes, i) end end
			if #AREAframes > 5 then
				for i=1, math.min(7, #AREAframes) do AREAframes[i]:GetChildren()[1].Position = UDim2.fromScale(-1, 0) end
				ts:Create(AREA, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { CanvasPosition = Vector2.zero }):Play()
				for i=1, math.min(7, #AREAframes) do
					task.wait(0.02)
					task.spawn(function()
						local springEnter = SBT.new(AREAframes[i]:GetChildren()[1], "Position", 1, 17, 100)
						springEnter:SetGoal(UDim2.fromScale(0, 0))
						springEnter:Start()
						task.wait(0.9)
						springEnter:Stop()
					end)
					--ts:Create(AREAframes[i]:GetChildren()[1], TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					--	Position = UDim2.fromScale(0, 0)
					--}):Play()
				end
				--task.wait(0.1)
			end
			
		end
		
		
		
		function FUNCTIONSmodule.refreshlist()
		
			for _, v in ipairs(script.Parent.Menu.List.ScrollingFrame:GetChildren()) do
				if v:IsA("TextButton") then
					v:Destroy()
				end
			end
		
			local dense = {}
			for _, module in pairs(getgenv().Modules) do
				if module then
					table.insert(dense, module)
				end
			end
			
			if not AREAModuleSelected then
				AREAModuleSelected = dense[1]
			end
			
		
			for i, module in ipairs(dense) do
				local success, err = pcall(function()
		
					local listbutton = getgenv().TIESAS.ListButton:Clone()
					listbutton.Parent           = script.Parent.Menu.List.ScrollingFrame
					listbutton.Name             = module.Name
					listbutton.Text             = module.Name
					listbutton.BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor
					listbutton.Visible          = true
					
					local themedColor = Instance.new("StringValue", listbutton)
					themedColor.Name = "themedColor"
					themedColor.Value = "primaryColor"
		
					listbutton.MouseButton1Click:Connect(function()
		
						if selected.Value then
							ts:Create(selected.Value, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								BackgroundColor3 = FUNCTIONSmodule.getTheme().primaryColor,
								TextColor3       = FUNCTIONSmodule.getTheme().textColor,
							}):Play()
						end
		
						selected.Value = listbutton
						AREAModuleSelected = module
						ts:Create(selected.Value, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							BackgroundColor3 = Color3.fromRGB(255,255,255),
							TextColor3       = Color3.fromRGB(0,0,0),
						}):Play()
		
						FUNCTIONSmodule.loader(module)
					end)
		
					listbutton.MouseButton1Down:Connect(function()
						ts:Create(listbutton, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Size = UDim2.new(1, -10, 0, 40)
						}):Play()
					end)
		
					listbutton.MouseButton1Up:Connect(function()
						ts:Create(listbutton, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
							Size = UDim2.new(1, 0, 0, 50),
						}):Play()
					end)
		
					listbutton.MouseLeave:Connect(function()
						ts:Create(listbutton, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
							Size = UDim2.new(1, 0, 0, 50),
						}):Play()
					end)
				end)
		
				if not success then
					warn(("[TIESAS] Error loading module %q: %s"):format(module.Name, err))
				end
			end
		end
		
		function FUNCTIONSmodule.refresharea(preferredModule)
			if preferredModule then
				AREAModuleSelected = preferredModule
			end

			-- Init puede terminar antes de que los módulos estén registrados.
			-- En ese caso se conserva el contenido en vez de vaciar el panel.
			if not AREAModuleSelected then
				for _, availableModule in pairs(getgenv().Modules or {}) do
					if availableModule then
						AREAModuleSelected = availableModule
						break
					end
				end
			end

			if AREAModuleSelected then
				FUNCTIONSmodule.loader(AREAModuleSelected)
			end
		end
		
		function FUNCTIONSmodule.dialog(title, description, buttons)
			local dialog = script.Parent.Dialog
			dialog.DialogTitle.Text = title
			dialog.DialogDesc.Text = description
		
			for _,v in ipairs(dialog.Options:GetChildren()) do
				if v:IsA("TextButton") and v.Name ~= "OptionPlaceholder" then v:Destroy() end
			end
			for _, button in buttons do
				local newButton = dialog.Options.OptionPlaceholder:Clone()
		
				newButton.Visible = true
				newButton.Name = button
				newButton.Text = button
				newButton.Parent = dialog.Options
				newButton.MouseButton1Click:Connect(function()
					newButton.Parent.Parent.OnSelect:Fire(newButton.Name)
				end)
			end
		
			ts:Create(dialog, TweenInfo.new(1.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out),{
				Size = UDim2.fromOffset(313, 147)
			}):Play()
		
			ts:Create(dialog.UIScale, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out),{
				Scale = 1
			}):Play()
		end
		
		function FUNCTIONSmodule.closedialog()
			local dialog = script.Parent.Dialog
			ts:Create(dialog, TweenInfo.new(1.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),{
				Size = UDim2.fromOffset(0, 147)
			}):Play()
		
			ts:Create(dialog.UIScale, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out),{
				Scale = 0
			}):Play()
		end
		
		function FUNCTIONSmodule.waitfordialog()
			return script.Parent.Dialog.OnSelect.Event:Wait()
		end
		
		
		getgenv().TIESASFUNCTIONS = FUNCTIONSmodule
		return FUNCTIONSmodule
		
    end
    routine_module_scripts[script] = module_script
end
do -- Routine Module: StarterGui.TIESAS.Bezier
    local script = Instance.new("ModuleScript")
    script.Name = "Bezier"
    script.Parent = Converted["_TIESAS"]
    local function module_script()

		local h={} h.__index=h function h.new(...)local k={...} assert(#k>=3,"Must have at least 3 points") local e=(#k==3) local _=(#k==4) local j={} local d=Vector3.new local b=d().lerp local f=nil local i={} local c=0 local a=nil local function g(_)local _={_.X,_.Y,_.Z} function _:ToVector3()return d(self[1],self[2],self[3])end function _:lerp(_,a)return b(self:ToVector3(),_:ToVector3(),a)end return _ end if(not e and not _)then for _=1,#k-1 do local a=g(k[_]) local _=g(k[_+1]) local _={a,_,g(a)} i[#i+1]=_ end local b=i for _=#i,2,-1 do local a={} for c=1,_-1 do local b,_=b[c],b[c+1] local _={b[3],_[3],g(b[3])} a[c]=_ i[#i+1]=_ end b=a end a=b[1] c=#i end if(e)then local b,c,_=k[1],k[2],k[3] function j:Get(d,a)if(a)then d=(d<0 and 0 or d>1 and 1 or d)end return(1-d)*(1-d)*b+2*(1-d)*d*c+d*d*_ end elseif(_)then local _,a,c,b=k[1],k[2],k[3],k[4] function j:Get(e,d)if(d)then e=(e<0 and 0 or e>1 and 1 or e)end return(1-e)*(1-e)*(1-e)*_+3*(1-e)*(1-e)*e*a+3*(1-e)*e*e*c+e*e*e*b end else function j:Get(b,_)if(_)then b=(b<0 and 0 or b>1 and 1 or b)end for _=1,c do local _=i[_] local a=_[1]:lerp(_[2],b) local _=_[3] _[1],_[2],_[3]=a.X,a.Y,a.Z end return a[3]:ToVector3()end end function j:GetLength(_)if(not f)then local a=self:GetPath(_ or 0.1) local b=0 for _=2,#a do local _=(a[_-1]-a[_]).Magnitude b=(b+_)end f=b end return f end function j:GetPath(_)assert(type(_)=="number","Must provide a step increment") assert(_>0 and _<1,"Step out of domain; should be between 0 and 1 (exclusive)") local b={} local a=0 for _=0,1,_ do a=_ b[#b+1]=self:Get(_)end if(a<1)then local _=((1-a)<(_*0.5)) b[#b+(_ and 0 or 1)]=self:Get(1)end return b end function j:GetPathByNumberSegments(_)assert(type(_)=="number","Must provide number of segments") assert(_>0,"Number of segments must be greater than 0") return self:GetPath(1/_)end function j:GetPathBySegmentLength(a)assert(type(a)=="number","Must provide a segment length") assert(a>0,"Segment length must be greater than 0") local _=self:GetLength() local _=_/a return self:GetPathByNumberSegments(math.floor(_+0.5))end function j:GetPoints()return k end return setmetatable(j,h)end return h
    end
    routine_module_scripts[script] = module_script
end
do -- Routine Module: StarterGui.TIESAS.PointSave
    local script = Instance.new("ModuleScript")
    script.Name = "PointSave"
    script.Parent = Converted["_TIESAS"]
    local function module_script()

		-- Datasaving module using files and folders
		-- Designed and written by TIESAS
		
		local _=false local function d(...)if _ then print("[PointSave DEBUG]:",...)end end getgenv()._FOLDERS=getgenv()._FOLDERS or{} getgenv()._FILES=getgenv()._FILES or{} isfolder=isfolder or function(_)d("Checking if folder exists:",_) return getgenv()._FOLDERS[_]~=nil end makefolder=makefolder or function(_)d("Creating folder:",_) getgenv()._FOLDERS[_]={} return getgenv()._FOLDERS[_]end isfile=isfile or function(_)d("Checking if file exists:",_) return getgenv()._FILES[_]~=nil end writefile=writefile or function(a,_)d("Writing file:",a,"with content:",_) getgenv()._FILES[a]=_ return getgenv()._FILES[a]end readfile=readfile or function(_)d("Reading file:",_) return getgenv()._FILES[_]end delfile=delfile or function(_)d("Deleting file:",_) getgenv()._FILES[_]=nil end listfiles=listfiles or function(c)d("Listing files in folder:",c) local _=getgenv()._FOLDERS[c] if _ then local a={} for b,_ in pairs(getgenv()._FILES)do if b:sub(1,#c+1)==c.."/"then local _=b:sub(#c+2) d("Found file in folder:",_) table.insert(a,_)end end return a end d("Folder does not exist:",c) return{}end local b={} b.__index=b local c="PointSaveData" local function _()if not isfolder(c)then d("Base folder not found, creating:",c) makefolder(c)else d("Base folder already exists:",c)end end function b.new(a)d("Initializing new PointSave instance for namespace:",a) _() local _=setmetatable({},b) _.namespace=a _.folderPath=c.."/"..a if not isfolder(_.folderPath)then d("Namespace folder does not exist, creating:",_.folderPath) makefolder(_.folderPath)else d("Namespace folder already exists:",_.folderPath)end return _ end function b:set(b,a)local _=self.folderPath.."/"..b..".txt" d("Setting value for key:",b,"->",a) writefile(_,tostring(a))end function b:get(a)local _=self.folderPath.."/"..a..".txt" d("Getting value for key:",a) if isfile(_)then local _=readfile(_) d("Found value for key:",a,"->",_) return _ end d("Key not found:",a) return nil end function b:remove(a)local _=self.folderPath.."/"..a..".txt" d("Removing key:",a) if isfile(_)then delfile(_) d("Removed file for key:",a)else d("File for key does not exist:",a)end end function b:clear()d("Clearing all keys in namespace:",self.namespace) local _=listfiles(self.folderPath) for _,_ in ipairs(_)do local _=self.folderPath.."/".._ if isfile(_)then d("Deleting file:",_) delfile(_)end end end function b.deleteNamespace(a)local b=c.."/"..a d("Deleting namespace:",a) local _=listfiles(b) for _,_ in ipairs(_)do local _=b.."/".._ if isfile(_)then d("Deleting file from namespace:",_) delfile(_)end end getgenv()._FOLDERS[b]=nil d("Deleted folder for namespace:",a)end function b.listNamespaces()d("Listing all namespaces") _() local b={} for a,_ in pairs(getgenv()._FOLDERS)do if a:sub(1,#c+1)==c.."/"then local _=a:sub(#c+2) d("Found namespace:",_) table.insert(b,_)end end return b end return b
    end
    routine_module_scripts[script] = module_script
end
do -- Routine Module: StarterGui.TIESAS.Theme
    local script = Instance.new("ModuleScript")
    script.Name = "Theme"
    script.Parent = Converted["_TIESAS"]
    local function module_script()

		-- Beautiful theming module for TIESAS
		
		local TIESASRoot = getgenv().TIESAS
		local api = {
			colors = {
				font = Enum.Font.Montserrat,
				textColor = Color3.fromRGB(69, 61, 82),
				accentColor = Color3.fromRGB(188, 166, 224),
				primaryColor = Color3.fromRGB(255, 248, 252),
				secondaryColor = Color3.fromRGB(242, 232, 247),
		
				backgroundColorCSQ = ColorSequence.new(Color3.fromRGB(233, 222, 246), Color3.fromRGB(252, 228, 238)),	
				strokeColorCSQ = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(194, 231, 218)),
					ColorSequenceKeypoint.new(0.25, Color3.fromRGB(213, 195, 239)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(250, 196, 216)),
					ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 222, 190)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(194, 231, 218))
				},
			}
		}
		
		local themeObjects = {
			font = {},
			textColor = {},
			accentColor = {},
			primaryColor = {},
			secondaryColor = {},
			backgroundColorCSQ = {},
			strokeColorCSQ = {},
		}
		
		
		
		-- value method matching
		function api:sortObjects(gui)
			for _, obj in next, gui:GetDescendants() do
				if obj:FindFirstChild("themedColor") then 
					if obj:FindFirstChild("themedColor").Value == "accentColor" then
						table.insert(themeObjects.accentColor, obj)
					elseif obj:FindFirstChild("themedColor").Value == "primaryColor" then
						table.insert(themeObjects.primaryColor, obj)
					elseif obj:FindFirstChild("themedColor").Value == "secondaryColor" then
						table.insert(themeObjects.secondaryColor, obj)
					elseif obj:FindFirstChild("themedColor").Value == "backgroundColorCSQ" then
						for _, find in ipairs(obj:GetChildren()) do
							if find:IsA("UIGradient") then table.insert(themeObjects.backgroundColorCSQ, find) break end
						end
					else
						warn("FRAME unknown obj: "..obj.Name)
					end
				end
				if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
					--print("found obj")
					
					table.insert(themeObjects.font, obj)
					table.insert(themeObjects.textColor, obj)
					--print("added to font obj",obj.Name)
				end
				if obj:IsA("UIStroke") and obj:FindFirstChildWhichIsA("UIGradient") then
					table.insert(themeObjects.strokeColorCSQ, obj:FindFirstChildWhichIsA("UIGradient"))
				end
				
			end
			--print("sorted")
		end
		
		
		--function api:sortObjects(gui)
		--	for _, obj in next, gui:getDescendants() do
		--		if obj:IsA("Frame") then 
		--			if obj.BackgroundColor == api.colors.primaryColor then
		--				table.insert(themeObjects.primaryColor, obj)
		--			elseif obj.BackgroundColor == api.colors.secondaryColor then
		--				table.insert(themeObjects.secondaryColor, obj)
		--			else
		--				warn("FRAME unknown obj: "..obj.Name)
		--				local c = obj.BackgroundColor3
						--print(string.format("color of unknown obj: (%d, %d, %d)", c.R * 255, c.G * 255, c.B * 255))
		--			end
		--		elseif obj:IsA("TextLabel") or obj:IsA("TextButton") then
					--print("found obj")
		--			if obj.BackgroundColor == api.colors.primaryColor then
		--				table.insert(themeObjects.primaryColor, obj)
		--			elseif obj.BackgroundColor == api.colors.secondaryColor then
		--				table.insert(themeObjects.secondaryColor, obj)
		--		--[[
		--			elseif obj.Font == api.colors.font then
						--print("FONT OBJECT", api.colors.font)
		--				table.insert(themeObjects.font, obj)
		--			elseif obj.Text and obj.TextColor == api.colors.textColor then
		--				table.insert(themeObjects.textColor, obj)
		--		]]
		--			else
		--				warn("TEXT unknown obj: "..obj.Name)
		--			end
		--			table.insert(themeObjects.font, obj)
		--			table.insert(themeObjects.textColor, obj)
					--print("added to font obj",obj.Name)
		--		end
		--	end
			--print("sorted")
		--end
		
		function api:updateColor(colorType, newColor)
			--print("aplying")
			--api.colors[colorType] = (colorType == "font" and newColor) or newColor
			if colorType == "font" then
				--for _, obj in next, themeObjects.font do
				--	obj.Font = newColor
				--end
				
				-- changed weights so disabeled sorry
			elseif colorType == "textColor" then
				for _, obj in next, themeObjects.textColor do
					obj.TextColor3 = newColor
				end
			elseif colorType == "accentColor" then
				for _, obj in next, themeObjects.accentColor do
					local s=pcall(function() obj.Color = newColor end)
					if not s then obj.BackgroundColor3 = newColor end
				end
			elseif colorType == "primaryColor" then
				for _, obj in next, themeObjects.primaryColor do
					local s=pcall(function() obj.Color = newColor end)
					if not s then obj.BackgroundColor3 = newColor end
				end
			elseif colorType == "secondaryColor" then
				for _, obj in next, themeObjects.secondaryColor do
					local s=pcall(function() obj.Color = newColor end)
					if not s then obj.BackgroundColor3 = newColor end
				end
			elseif colorType == "backgroundColorCSQ" then
				for _, obj in next, themeObjects.backgroundColorCSQ do
					obj.Color = newColor
				end
			elseif colorType == "strokeColorCSQ" then
				for _, obj in next, themeObjects.strokeColorCSQ do
					obj.Color = newColor
				end
			end
		end
		
		function api:setColorTable(t)
			api.colors = t
			if getgenv then getgenv().TIESAS_THEME = t end
		end
		
		function api:init(p)
			api:sortObjects(p)
			for colorKey, color in api.colors do
				local s, e = pcall(function() 
					api:updateColor(colorKey, color)
				end)
				if not s then warn(e) end
			end
		end
		
		getgenv().ThemeManager = api
		getgenv().ThemeObjects = themeObjects
		
		getgenv().ThemeManagerModuleObject = script
		
		return api
		
    end
    routine_module_scripts[script] = module_script
end
local function DSZIHQM_routine() -- Routine: StarterGui.TIESAS.Init
    local script = Instance.new("LocalScript")
    script.Name = "Init"
    script.Parent = Converted["_TIESAS"]
    local req = require
    local require = function(obj)
        local routine = routine_module_scripts[obj]
        if routine then
            return routine()
        end
        return req(obj)
    end



	getgenv().Modules = {}
	getgenv().TIESAS_MODULES_READY = false
	
	local ts = game:GetService("TweenService")
	
	
	getgenv().TIESAS = script.Parent
	getgenv().ThemeManager = require(script.Parent.Theme)
	local COREGUI = game:GetService("CoreGui")
	function randomString()
		local length = math.random(10,20)
		local array = {}
		for i = 1, length do
			array[i] = string.char(math.random(32, 126))
		end
		return table.concat(array)
	end
	local s, e = pcall(function()
		if get_hidden_gui or gethui then
			local hiddenUI = get_hidden_gui or gethui
			script.Parent.Name = randomString()
			script.Parent.Parent = hiddenUI()
			--print("[TIESAS] - Using get_hidden_gui for anti-detection.")
		elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
			script.Parent.Name = randomString()
			syn.protect_gui(script.Parent)
			script.Parent.Parent = COREGUI
			--print("[TIESAS] - Using syn.protect_gui for anti-detection.")
		elseif COREGUI:FindFirstChild('RobloxGui') then
			script.Parent.Parent = COREGUI.RobloxGui
			--print("[TIESAS] - Using RobloxGui for anti-detection.")
		else
			--warn("[TIESAS] - Using CoreGui as anti-detection. This is the most basic coverage and can still be detected.")
		end
	end)
	
	--print("[TIESAS] - TIESAS is now in " .. tostring(script.Parent:GetFullName()))
	if not s then
		--warn("[TIESAS] - Attempts at anti-detection failed. Using CoreGui as anti-detection.")
		warn(e)	
	end
	
	--printidentity("[TIESAS] - Your executor level (identity) is")
	
	local getExeName = identifyexecutor or getexecutorname or function() return "Ejecutor de Roblox" end
	--print("[TIESAS] - Your executor is " .. getExeName())
	
	script.Parent.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
	script.Parent.ScreenInsets = Enum.ScreenInsets.None
	script.Parent.ResetOnSpawn = false
	script.Parent.Menu.UIScale.Scale = getgenv().TIESAS_MENU_SCALE or 1
	script.Parent.Menu.List.Visible = false
	script.Parent.Menu.Area.Position = UDim2.fromScale(0.5, 0.61)
	script.Parent.Menu.Area.Size = UDim2.new(0.91, 0, 0.77, 0)
	
	
	script.Parent.Menu.Position = UDim2.fromScale(0.5, -0.6)
	--script.Parent.Menu.Size = UDim2.fromOffset(441,0)
	
	script.Parent.Dialog.Size = UDim2.fromOffset(0, 147)
	script.Parent.Dialog.UIScale.Scale = 0
	
	script.Parent.Dialog.Visible = true
	
	script.Parent.Menu.CanvasGroup.Visible = true
	script.Parent.Menu.CanvasGroup.GroupTransparency = 0
	
	if not game:IsLoaded() then
		game.Loaded:Wait()
	end
	
	-- Cabecera de Tiesas Scripts
	script.Parent.Menu.HubName.Text = script.Parent.Menu.HubName.Text .. `<font transparency="0.8" size="5">{require(script.Parent.FUNCTIONS).__v}</font>`
	
	ts:Create(script.Parent.Menu, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), 
		{Position = UDim2.fromScale(0.5, 0.05)}
	):Play()
	
	task.wait(1)
	ts:Create(script.Parent.Menu.CanvasGroup, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), 
		{GroupTransparency = 1}
	):Play()

	-- MM2 y la interfaz arrancaban en paralelo y ambos reconstruían el panel.
	-- Esperar una única señal elimina el panel vacío, la doble creación de
	-- controles y la carrera que podía borrar SHOOT.
	local moduleDeadline = os.clock() + 8
	repeat
		task.wait(0.05)
	until not appRuntime.alive
		or getgenv().TIESAS_MODULES_READY
		or os.clock() >= moduleDeadline
	if not appRuntime.alive then return end
	require(script.Parent.FUNCTIONS).refreshlist()
	require(script.Parent.FUNCTIONS).refresharea()
	task.wait(0.5)
	script.Parent.Menu.CanvasGroup.Visible = false
	script.Parent.Menu.CanvasGroup.TextLabel.Visible = true
	script.Parent.Menu.CanvasGroup.ImageLabel.Visible = false
	script.Parent.Menu.CanvasGroup.Interactable = true
	
	script.Parent.Menu.CloseArea.AllowForSpring:Fire()
	task.wait(1)
	require(script.Parent.FUNCTIONS).loadFloatingButtons()
	require(script.Parent.Theme):init(getgenv().TIESAS)
	script.Parent.Menu.Visible = true
	script.Parent.Open.Visible = false
	script.Parent.Dropdown.Visible = false
	script.Parent.Dialog.Visible = false
	require(script.Parent.FUNCTIONS).notification(
		"Menú, ESP y SHOOT listos. Minimiza el menú para dejar visible el botón TS."
	)
	
	--require(script.Parent.FUNCTIONS).refreshlist()
	--require(script.Parent.FUNCTIONS).refresharea()
	
	--getgenv().ThemeManager:init(script.Parent)
end
local function XXZOB_routine() -- Routine: StarterGui.TIESAS.Murder Mystery 2
    local script = Instance.new("LocalScript")
    script.Name = "Murder Mystery 2"
    script.Parent = Converted["_TIESAS"]
    local req = require
    local require = function(obj)
        local routine = routine_module_scripts[obj]
        if routine then
            return routine()
        end
        return req(obj)
    end


	local module = {}
	module["gameId"] = game.GameId
	
	local fu = require(getgenv().TIESAS.FUNCTIONS)
	local previousRuntime = runtimeEnvironment.TIESAS_MM2_V6_RUNTIME
	if type(previousRuntime) == "table" and type(previousRuntime.stop) == "function" then
		pcall(previousRuntime.stop)
	end

	local runtime = {
		alive = true,
		connections = {},
		cleanups = {},
	}
	function runtime.track(connection)
		if connection then
			table.insert(runtime.connections, connection)
		end
		return connection
	end
	function runtime.release(connection)
		if not connection then return end
		pcall(function() connection:Disconnect() end)
		local index = table.find(runtime.connections, connection)
		if index then table.remove(runtime.connections, index) end
	end
	function runtime.cleanup(callback)
		if type(callback) == "function" then
			table.insert(runtime.cleanups, callback)
		end
	end
	function runtime.stop()
		if not runtime.alive then return end
		runtime.alive = false
		for _, connection in ipairs(runtime.connections) do
			pcall(function() connection:Disconnect() end)
		end
		for _, callback in ipairs(runtime.cleanups) do
			pcall(callback)
		end
		table.clear(runtime.connections)
		table.clear(runtime.cleanups)
	end
	runtimeEnvironment.TIESAS_MM2_V6_RUNTIME = runtime
	appRuntime.cleanup(runtime.stop)
	runtime.track(script.Parent.AncestryChanged:Connect(function(_, parent)
		if not parent then runtime.stop() end
	end))

	-- ESP propio de MM2 V6. Sus grupos pertenecen a esta instancia y las flechas
	-- se actualizan a 15 Hz, evitando los tweens y limpiezas de cada frame del
	-- contenedor genérico.
	local function createMM2ESPContainer()
		local coreGui = game:GetService("CoreGui")
		local oldGui = coreGui:FindFirstChild("TiesasMM2ESP")
		if oldGui then oldGui:Destroy() end

		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "TiesasMM2ESP"
		screenGui.IgnoreGuiInset = true
		screenGui.ResetOnSpawn = false
		screenGui.DisplayOrder = 4
		screenGui.Parent = coreGui

		local container = {
			ScreenGui = screenGui,
			Indicators = {},
			Groups = {},
		}

		local function removeIndicator(target)
			local indicator = container.Indicators[target]
			if not indicator then return end
			if indicator.highlight then indicator.highlight:Destroy() end
			if indicator.arrow then indicator.arrow:Destroy() end
			if indicator.label then indicator.label:Destroy() end
			container.Indicators[target] = nil
			for _, group in pairs(container.Groups) do
				group[target] = nil
			end
		end

		local function applyIndicatorOptions(indicator, target, options)
			local color = options.AccentColor or Color3.new(1, 1, 0)
			indicator.highlight.Adornee = target
			indicator.highlight.FillColor = color
			indicator.highlight.OutlineColor = color
			indicator.highlight.FillTransparency = options.HighlightFillTransparency or 0.68
			if indicator.arrow then
				indicator.arrow.ImageColor3 = color
				indicator.arrow.Size = options.ArrowSize or UDim2.fromOffset(40, 40)
			end
			if indicator.label then
				indicator.label.Adornee = target
				local text = indicator.label:FindFirstChildOfClass("TextLabel")
				if text then
					text.Text = options.LabelText or "Objetivo"
					text.TextColor3 = color
				end
			end
			indicator.options = options
		end

		function container:Add(target, options)
			if not target then return end
			options = options or {}
			local existing = container.Indicators[target]
			if existing
				and (existing.arrow ~= nil) == (options.ArrowShow == true)
				and (existing.label ~= nil) == (options.ShowLabel == true) then
				applyIndicatorOptions(existing, target, options)
				local groupName = options.GroupName
				if groupName then
					container.Groups[groupName] = container.Groups[groupName] or {}
					container.Groups[groupName][target] = true
				end
				return existing
			end
			if existing then removeIndicator(target) end

			local color = options.AccentColor or Color3.new(1, 1, 0)
			local highlight = Instance.new("Highlight")
			highlight.Name = "TiesasHighlight"
			highlight.Adornee = target
			highlight.FillColor = color
			highlight.OutlineColor = color
			highlight.FillTransparency = options.HighlightFillTransparency or 0.68
			highlight.OutlineTransparency = 0
			highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			highlight.Parent = screenGui

			local arrow
			if options.ArrowShow then
				arrow = Instance.new("ImageLabel")
				arrow.Name = "TiesasArrow"
				arrow.AnchorPoint = Vector2.new(0.5, 0.5)
				arrow.BackgroundTransparency = 1
				arrow.Image = "rbxassetid://97136202386756"
				arrow.ImageColor3 = color
				arrow.Size = options.ArrowSize or UDim2.fromOffset(40, 40)
				arrow.Visible = false
				arrow.Parent = screenGui
			end

			local label
			if options.ShowLabel then
				label = Instance.new("BillboardGui")
				label.Name = "TiesasLabel"
				label.Adornee = target
				label.AlwaysOnTop = true
				label.MaxDistance = 99999
				label.Size = UDim2.fromOffset(95, 34)
				label.StudsOffset = Vector3.new(0, 3, 0)
				label.Parent = screenGui
				local text = Instance.new("TextLabel")
				text.BackgroundTransparency = 1
				text.Size = UDim2.fromScale(1, 1)
				text.Font = Enum.Font.GothamBold
				text.Text = options.LabelText or "Objetivo"
				text.TextColor3 = color
				text.TextScaled = true
				text.Parent = label
				local stroke = Instance.new("UIStroke")
				stroke.Thickness = 1.5
				stroke.Parent = text
			end

			local indicator = {
				highlight = highlight,
				arrow = arrow,
				label = label,
			}
			container.Indicators[target] = indicator
			applyIndicatorOptions(indicator, target, options)
			local groupName = options.GroupName
			if groupName then
				container.Groups[groupName] = container.Groups[groupName] or {}
				container.Groups[groupName][target] = true
			end
			return indicator
		end

		function container:SyncGroup(groupName, desired)
			local group = container.Groups[groupName] or {}
			container.Groups[groupName] = group
			local toRemove = {}
			for target in pairs(group) do
				if not desired[target] then table.insert(toRemove, target) end
			end
			for _, target in ipairs(toRemove) do removeIndicator(target) end
			for target, options in pairs(desired) do
				options.GroupName = groupName
				container:Add(target, options)
			end
		end

		function container:Remove(target)
			removeIndicator(target)
		end

		function container:RemoveGroup(groupName)
			local group = container.Groups[groupName]
			if not group then return end
			local targets = {}
			for target in pairs(group) do table.insert(targets, target) end
			container.Groups[groupName] = nil
			for _, target in ipairs(targets) do removeIndicator(target) end
		end

		function container:ClearAllGroups()
			local targets = {}
			for target in pairs(container.Indicators) do table.insert(targets, target) end
			for _, target in ipairs(targets) do removeIndicator(target) end
			table.clear(container.Groups)
		end

		function container:Destroy()
			container:ClearAllGroups()
			if screenGui.Parent then screenGui:Destroy() end
		end

		local arrowAccumulator = 0
		local frameTimeAverage = 1 / 60
		runtime.track(game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
			if not runtime.alive then return end
			frameTimeAverage = frameTimeAverage + (deltaTime - frameTimeAverage) * 0.08
			arrowAccumulator = arrowAccumulator + deltaTime
			local updateRate = frameTimeAverage > 1 / 38 and 10 or 15
			if arrowAccumulator < 1 / updateRate then return end
			arrowAccumulator = 0

			local camera = workspace.CurrentCamera
			if not camera then return end
			local viewport = camera.ViewportSize
			local center = viewport * 0.5
			local padding = 54
			for target, indicator in pairs(container.Indicators) do
				local arrow = indicator.arrow
				if not target.Parent then
					removeIndicator(target)
				elseif arrow then
					local position
					if target:IsA("Model") then
						pcall(function() position = target:GetPivot().Position end)
					elseif target:IsA("BasePart") then
						position = target.Position
					end
					if position then
						local projected, onScreen = camera:WorldToViewportPoint(position)
						if onScreen and projected.Z > 0 then
							arrow.Visible = false
						else
							local localPosition = camera.CFrame:PointToObjectSpace(position)
							local direction = Vector2.new(localPosition.X, -localPosition.Y)
							if localPosition.Z > 0 then direction = -direction end
							if direction.Magnitude < 0.001 then
								direction = Vector2.new(0, -1)
							end
							direction = direction.Unit
							local horizontal = math.max(1, viewport.X * 0.5 - padding)
							local vertical = math.max(1, viewport.Y * 0.5 - padding)
							local scale = math.min(
								horizontal / math.max(math.abs(direction.X), 0.001),
								vertical / math.max(math.abs(direction.Y), 0.001)
							)
							local point = center + direction * scale
							arrow.Position = UDim2.fromOffset(point.X, point.Y)
							arrow.Rotation = math.deg(math.atan2(direction.Y, direction.X)) + 90
							arrow.Visible = true
						end
					else
						arrow.Visible = false
					end
				end
			end
		end))

		return container
	end

	local espcontainer = createMM2ESPContainer()
	runtime.cleanup(function() espcontainer:Destroy() end)
	
	local playerESP = true
	local shootOffset = 2.8
	local offsetToPingMult = 1
	local gunDropESP = true

	local trapDetection = true
	--local trapESP = Instance.new("Highlight")
	--trapESP.Name = "TrapESP"
	--trapESP.FillColor = Color3.fromRGB(255, 112, 10)
	--trapESP.OutlineColor = Color3.fromRGB(255, 112, 10)
	--trapESP.FillTransparency = 0.5
	
	
	local autoGetDroppedGun = false
	
	local localplayer = game:GetService("Players").LocalPlayer
	
	local playerData = {}
	
	local rs = game:GetService("RunService")
	local cachedMap
	local cachedMurderer
	local cachedSheriff
	local cachedHero
	local lastRoleResolutionAt = 0

	local function scanForMap()
		for _, object in ipairs(workspace:GetChildren()) do
			if object:FindFirstChild("CoinContainer") and object:FindFirstChild("Spawns") then
				return object
			end
		end
		return nil
	end

	local function getMap()
		if cachedMap and cachedMap.Parent then return cachedMap end
		cachedMap = scanForMap()
		return cachedMap
	end

	local function isMapModel(object)
		return object
			and object:FindFirstChild("CoinContainer")
			and object:FindFirstChild("Spawns")
	end

	local function findDroppedGun()
		local map = getMap()
		return map and map:FindFirstChild("GunDrop", true) or nil
	end

	local function isRoundActive()
		return getMap() ~= nil
	end

	local function resolveRoles(force)
		local now = os.clock()
		if not force and now - lastRoleResolutionAt < 0.08 then
			return cachedMurderer, cachedSheriff or cachedHero
		end
		lastRoleResolutionAt = now

		local murdererFromTool
		local sheriffFromTool
		for _, player in ipairs(game.Players:GetPlayers()) do
			local backpack = player:FindFirstChildOfClass("Backpack")
			local character = player.Character
			if (backpack and backpack:FindFirstChild("Knife"))
				or (character and character:FindFirstChild("Knife")) then
				murdererFromTool = player
			end
			if (backpack and backpack:FindFirstChild("Gun"))
				or (character and character:FindFirstChild("Gun")) then
				sheriffFromTool = player
			end
		end

		local murdererFromData
		local sheriffFromData
		local heroFromData
		if type(playerData) == "table" then
			for playerName, data in pairs(playerData) do
				if type(data) == "table" then
					local player = typeof(playerName) == "Instance"
						and playerName:IsA("Player") and playerName
						or game.Players:FindFirstChild(tostring(playerName))
					if data.Role == "Murderer" then murdererFromData = player end
					if data.Role == "Sheriff" then sheriffFromData = player end
					if data.Role == "Hero" then heroFromData = player end
				end
			end
		end

		cachedMurderer = murdererFromTool or murdererFromData
		cachedSheriff = sheriffFromTool or sheriffFromData
		cachedHero = heroFromData
		return cachedMurderer, cachedSheriff or cachedHero
	end

	local function findMurderer()
		resolveRoles(false)
		return cachedMurderer
	end

	local function findSheriff()
		resolveRoles(false)
		return cachedSheriff or cachedHero
	end

	local hideMeEsp = false
	local originalTrapTransparency = setmetatable({}, {__mode = "k"})
	local function trapOptions()
		return {
			AccentColor = Color3.fromRGB(255, 80, 90),
			ArrowShow = false,
			ShowLabel = true,
			LabelText = "Trampa",
			GroupName = "trap",
		}
	end
	local function revealTrap(object)
		if object:IsA("BasePart") then
			if originalTrapTransparency[object] == nil then
				originalTrapTransparency[object] = object.Transparency
			end
			object.Transparency = 0
		end
		espcontainer:Add(object, trapOptions())
	end
	runtime.cleanup(function()
		for object, transparency in pairs(originalTrapTransparency) do
			if object.Parent then object.Transparency = transparency end
		end
	end)

	local function reloadESP()
		local desired = {}
		if not playerESP then
			espcontainer:SyncGroup("players", desired)
			return
		end

		local murderer = findMurderer()
		local sheriff = findSheriff()
		-- No pintar a todo el lobby de verde. El ESP aparece en cuanto MM2
		-- entrega al menos uno de los roles, incluso antes de crear el mapa.
		if not murderer and not sheriff then
			espcontainer:SyncGroup("players", desired)
			return
		end

		for _, player in ipairs(game.Players:GetPlayers()) do
			if player == localplayer and hideMeEsp then continue end
			local character = player.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if not character or not humanoid or humanoid.Health <= 0 then continue end

			if player == murderer then
				desired[character] = {
					AccentColor = Color3.new(1, 0, 0.0156863),
					ArrowShow = true,
					ArrowMinDistance = 999999,
					ArrowSize = UDim2.new(0, 40, 0, 40),
					LabelText = "Asesino",
					ShowLabel = true,
					GroupName = "players",
				}
			elseif player == sheriff then
				desired[character] = {
					AccentColor = Color3.new(0, 0.6, 1),
					ArrowShow = false,
					ShowLabel = false,
					GroupName = "players",
				}
			else
				desired[character] = {
					AccentColor = Color3.new(0, 1, 0.0313725),
					ArrowShow = false,
					ShowLabel = false,
					GroupName = "players",
				}
			end
		end
		espcontainer:SyncGroup("players", desired)
	end

	local function reloadGunESP()
		local desired = {}
		if gunDropESP and isRoundActive() then
			local droppedGun = findDroppedGun()
			if droppedGun then desired[droppedGun] = {
				AccentColor = Color3.fromRGB(255, 224, 19),
				ArrowShow = true,
				ArrowMinDistance = 999999,
				ArrowSize = UDim2.new(0, 40, 0, 40),
				LabelText = "Arma caída",
				ShowLabel = true,
				GroupName = "gun",
			} end
		end
		espcontainer:SyncGroup("gun", desired)
	end

	local function reloadTrapESP()
		local desired = {}
		if trapDetection then
			local map = getMap()
			if map then
				for _, object in ipairs(map:GetDescendants()) do
					local parent = object.Parent
					if object.Name == "Trap" and parent
						and (parent:IsA("Folder") or parent:IsA("Model")) then
						if object:IsA("BasePart") then
							if originalTrapTransparency[object] == nil then
								originalTrapTransparency[object] = object.Transparency
							end
							object.Transparency = 0
						end
						desired[object] = trapOptions()
					end
				end
			end
		else
			for object, transparency in pairs(originalTrapTransparency) do
				if object.Parent then object.Transparency = transparency end
			end
		end
		espcontainer:SyncGroup("trap", desired)
	end

	local function reloadAllESP()
		reloadESP()
		reloadGunESP()
		reloadTrapESP()
	end

	local hasRoleDataRemote = false
	-- Los roles se asignan antes de que aparezca el mapa. Se observan por separado
	-- para mostrar el ESP durante la cuenta atrás, sin esperar a CoinContainer.
	task.spawn(function()
		local observedMap
		local observedMurderer
		local observedSheriff
		local ignoreRolesUntil = 0
		while runtime.alive
			and task.wait(hasRoleDataRemote and 0.75 or 0.25) do
			local map = getMap()
			if map ~= observedMap then
				if observedMap and not map then
					playerData = {}
					observedMurderer = nil
					observedSheriff = nil
					ignoreRolesUntil = os.clock() + 1
				end
				observedMap = map
				espcontainer:ClearAllGroups()
				if map then
					reloadAllESP()
				end
			end

			if not hasRoleDataRemote and os.clock() >= ignoreRolesUntil then
				local murderer = findMurderer()
				local sheriff = findSheriff()
				if playerESP
					and (murderer ~= observedMurderer or sheriff ~= observedSheriff) then
					observedMurderer = murderer
					observedSheriff = sheriff
					reloadESP()
				end
			end
		end
	end)
	
	
	
	local function connectRoleDataRemote(playerDataChanged)
		if hasRoleDataRemote or not playerDataChanged
			or not playerDataChanged:IsA("RemoteEvent") then
			return false
		end
		hasRoleDataRemote = true
		runtime.track(playerDataChanged.OnClientEvent:Connect(function(data)
			playerData = data
			resolveRoles(true)
			if playerESP then
				reloadESP()
			end
		end))
		return true
	end

	local remotesFolder = game.ReplicatedStorage:FindFirstChild("Remotes")
	local gameplayFolder = remotesFolder and remotesFolder:FindFirstChild("Gameplay")
	local playerDataChanged = gameplayFolder
		and gameplayFolder:FindFirstChild("PlayerDataChanged")
	if not connectRoleDataRemote(playerDataChanged) then
		task.spawn(function()
			local deadline = os.clock() + 4
			repeat
				task.wait(0.2)
				remotesFolder = game.ReplicatedStorage:FindFirstChild("Remotes")
				gameplayFolder = remotesFolder
					and remotesFolder:FindFirstChild("Gameplay")
				playerDataChanged = gameplayFolder
					and gameplayFolder:FindFirstChild("PlayerDataChanged")
			until not runtime.alive
				or connectRoleDataRemote(playerDataChanged)
				or os.clock() >= deadline
		end)
	end
	
	
	module["Name"] = currentGameName
	
	-- Los estados permanecen activos entre rondas. Cada mapa nuevo reconstruye
	-- los tres grupos, aunque el script se haya ejecutado desde el lobby.
	runtime.track(workspace.ChildAdded:Connect(function(ch)
		if isMapModel(ch) then
			cachedMap = ch
			task.spawn(function()
				task.wait(0.25)
				if not runtime.alive or not ch.Parent then return end
				reloadAllESP()

				local startedWaiting = os.clock()
				repeat
					task.wait(0.4)
				until not runtime.alive
					or not ch.Parent
					or findMurderer()
					or findSheriff()
					or os.clock() - startedWaiting > 12

				if runtime.alive and ch.Parent and playerESP then
					reloadESP()
				end
			end)
		end
	end))

	runtime.track(workspace.ChildRemoved:Connect(function(ch)
		if isMapModel(ch) then
			if cachedMap == ch then cachedMap = nil end
			playerData = {}
			cachedMurderer = nil
			cachedSheriff = nil
			cachedHero = nil
			espcontainer:ClearAllGroups()
		end
	end))

	-- Dropped Gun ESP
	runtime.track(workspace.DescendantAdded:Connect(function(ch)
		local parent = ch.Parent
		if trapDetection and ch.Name == "Trap" and parent
			and (parent:IsA("Folder") or parent:IsA("Model")) then
			revealTrap(ch)
			fu.notification("El asesino ha colocado una trampa.")
		end

		if gunDropESP and ch.Name == "GunDrop" then
			reloadGunESP()
			--if not script.Parent:FindFirstChild("GunESP") then
			--	local gunesp = Instance.new("Highlight", script.Parent)
			--	gunesp.OutlineTransparency = 1
			--	gunesp.FillColor = Color3.fromRGB(255, 255, 0)
			--	gunesp.Name = "GunESP"
			--	gunesp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			--	gunesp.Adornee = ch
			--	gunesp.Enabled = true
			--end
			--script.Parent:FindFirstChild("GunESP").Adornee = ch
			--script.Parent:FindFirstChild("GunESP").Enabled = true
			--local bguiclone = script.Parent.DroppedGunBGUI:Clone()
			--bguiclone.Parent = script.Parent
			--bguiclone.Adornee = ch
			--bguiclone.Enabled = true
			--bguiclone.Name = "DGBGUIClone"
			fu.notification("El arma ha caído. Está marcada en amarillo.")
			if autoGetDroppedGun then
				fu.notification("Recogida automática del arma en proceso...")
				task.wait(1)
				local droppedGun = findDroppedGun()
				if not droppedGun then fu.notification("No hay ningún arma caída.") return end
				local character = localplayer.Character
				local backpack = localplayer:FindFirstChildOfClass("Backpack")
				if not character or not backpack then return end
				local previousPosition = character:GetPivot()
				character:MoveTo(droppedGun.Position)
				local deadline = os.clock() + 2.5
				repeat
					task.wait(0.05)
				until not runtime.alive
					or not character.Parent
					or backpack:FindFirstChild("Gun")
					or character:FindFirstChild("Gun")
					or os.clock() >= deadline
				if character.Parent then character:PivotTo(previousPosition) end
			end
		end
		end))
		
		runtime.track(workspace.DescendantRemoving:Connect(function(ch)
		if ch.Name == "Trap" then
			espcontainer:Remove(ch)
			originalTrapTransparency[ch] = nil
		end
		if gunDropESP and ch.Name == "GunDrop" then
			espcontainer:RemoveGroup("gun")
			fu.notification("Alguien ha recogido el arma.")
			task.delay(0.5, function()
				if not runtime.alive then return end
				reloadGunESP()
				reloadESP()
			end)
			--if playerESP then
			--	for _, v in ipairs(script.Parent:GetChildren()) do
			--		if v:IsA("Highlight") then
			--			v:Destroy()
			--		end
			--	end
			--end
	
			--local listplayers = game.Players:GetChildren()
			--for _, player in ipairs(listplayers) do
			--	if  player.Character ~= nil then
			--		local character = player.Character
			--		if not character:FindFirstChild("PlayerESP") then
			--			local a = Instance.new("Highlight", script.Parent)
			--			a.Name = "PlayerESP"
			--			a.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			--			a.Adornee = character
			--			a.FillColor = Color3.fromRGB(255, 255, 255)
			--			a.FillTransparency = 0.5
			--			task.spawn(function()
			--				if player == findMurderer() then
			--					local mbgui = script.Parent.MurdererBGUI:Clone()
			--					mbgui.Enabled = true
			--					mbgui.Name = "AppliedMurdererBGUI"
			--					mbgui.Parent = getgenv().TIESAS
			--					mbgui.Adornee = character
			--					a.FillColor = Color3.fromRGB(255,0,0)
			--					a.OutlineColor = Color3.fromRGB(255,0,0)
			--				elseif player == findSheriff() then
			--					a.FillColor = Color3.fromRGB(255, 255,0)
			--					a.OutlineColor = Color3.fromRGB(255, 255,0)
			--				else
			--					a.FillColor = Color3.fromRGB(0,255,0)
			--					a.OutlineColor = Color3.fromRGB(0, 255, 0)
			--				end
			--				if a then
			--					if not player then return end
			--					a.Adornee = player.Character or player.CharactedAdded:Wait()
			--				end
			--			end)
			--		end
			--	end
			--end
		end
	end))

		local function watchPlayerForESP(player)
			runtime.track(player.CharacterAdded:Connect(function()
				task.delay(0.5, function()
					if runtime.alive and playerESP then
						reloadESP()
					end
				end)
			end))
		end

	for _, player in ipairs(game.Players:GetPlayers()) do
		watchPlayerForESP(player)
	end
		runtime.track(game.Players.PlayerAdded:Connect(watchPlayerForESP))
	
	-- Aim V6 móvil. No captura InputBegan, TouchTap ni __namecall: únicamente
	-- calcula un destino al pulsar SHOOT. Separa la pistola instantánea del
	-- cuchillo físico y fecha cada muestra con la edad real de replicación.
	local predictionTracks = setmetatable({}, {__mode = "k"})
	local smoothedNetworkPing = 0
	local smoothedDataPing = 0
	local networkPingJitter = 0
	local httpService = game:GetService("HttpService")
	local statsService = game:GetService("Stats")
	local aimDataFolder = "TiesasScripts"
	local aimDataPath = aimDataFolder .. "/mm2_aim_v6_"
		.. tostring(game.GameId) .. ".json"
	local aimDataBackupPath = aimDataPath .. ".backup"
	local legacyV5AimDataPath = aimDataFolder .. "/mm2_aim_v5.json"
	local legacyV4AimDataPath = aimDataFolder .. "/mm2_aim_v4.json"
	local aimData = {
		version = 6,
		gameId = game.GameId,
		knifePhysics = {
			speed = 200,
			gravity = 0,
			measurements = 0,
			gravityMeasurements = 0,
			model = "unknown",
			modelConfidence = 0,
			ballisticVotes = 0,
			linearVotes = 0,
			recentSpeeds = {},
			recentGravities = {},
			recentModels = {},
		},
		routeStats = {},
		recentShots = {},
	}
	local saveAimGeneration = 0

	local function clampVector(vector, maximum)
		if vector.Magnitude > maximum then
			return vector.Unit * maximum
		end
		return vector
	end

	local function medianNumber(values)
		if #values == 0 then return nil end
		local copy = {}
		for index, value in ipairs(values) do
			copy[index] = value
		end
		table.sort(copy)
		local middle = math.floor(#copy / 2)
		if #copy % 2 == 0 then
			return (copy[middle] + copy[middle + 1]) * 0.5
		end
		return copy[middle + 1]
	end

	local function readLocalJson(path)
		if type(isfile) ~= "function" or type(readfile) ~= "function" then return nil end
		local ok, decoded = pcall(function()
			if not isfile(path) then return nil end
			return httpService:JSONDecode(readfile(path))
		end)
		return ok and type(decoded) == "table" and decoded or nil
	end

	local function loadLocalAimData()
		local decoded = readLocalJson(aimDataPath)
			or readLocalJson(aimDataBackupPath)
		if decoded and decoded.version == 6 then
			if type(decoded.knifePhysics) == "table" then
				aimData.knifePhysics = decoded.knifePhysics
			end
			if type(decoded.routeStats) == "table" then
				aimData.routeStats = decoded.routeStats
			end
			if type(decoded.recentShots) == "table" then
				aimData.recentShots = decoded.recentShots
			end
			return
		end

		-- Entre juegos solo se migran las mediciones físicas robustas. Las rutas,
		-- resultados y modelos se vuelven a aprender para no mezclar MM2 y MMV.
		local legacy = readLocalJson(legacyV5AimDataPath)
			or readLocalJson(legacyV4AimDataPath)
		if legacy and type(legacy.knifePhysics) == "table" then
			local physics = legacy.knifePhysics
			aimData.knifePhysics.speed = math.clamp(
				tonumber(physics.speed) or 200,
				70,
				280
			)
			aimData.knifePhysics.measurements = math.clamp(
				tonumber(physics.measurements) or 0,
				0,
				100
			)
			if type(physics.recentSpeeds) == "table" then
				for index = math.max(1, #physics.recentSpeeds - 11), #physics.recentSpeeds do
					local speed = tonumber(physics.recentSpeeds[index])
					if speed and speed >= 70 and speed <= 280 then
						table.insert(aimData.knifePhysics.recentSpeeds, speed)
					end
				end
			end
		end
	end

	local function writeAimDataNow()
		if type(writefile) ~= "function" then return end
		pcall(function()
			if type(isfolder) == "function" and type(makefolder) == "function"
				and not isfolder(aimDataFolder) then
				makefolder(aimDataFolder)
			end
			if type(isfile) == "function" and type(readfile) == "function"
				and isfile(aimDataPath) then
				writefile(aimDataBackupPath, readfile(aimDataPath))
			end
			writefile(aimDataPath, httpService:JSONEncode(aimData))
		end)
	end

	local function scheduleAimDataSave()
		if type(writefile) ~= "function" then return end
		saveAimGeneration = saveAimGeneration + 1
		local generation = saveAimGeneration
		task.delay(1.5, function()
			if not runtime.alive or generation ~= saveAimGeneration then return end
			writeAimDataNow()
		end)
	end

	loadLocalAimData()
	aimData.knifePhysics = type(aimData.knifePhysics) == "table"
		and aimData.knifePhysics or {}
	aimData.knifePhysics.recentSpeeds = type(aimData.knifePhysics.recentSpeeds) == "table"
		and aimData.knifePhysics.recentSpeeds or {}
	aimData.knifePhysics.recentGravities = type(aimData.knifePhysics.recentGravities) == "table"
		and aimData.knifePhysics.recentGravities or {}
	aimData.knifePhysics.recentModels = type(aimData.knifePhysics.recentModels) == "table"
		and aimData.knifePhysics.recentModels or {}
	aimData.routeStats = type(aimData.routeStats) == "table"
		and aimData.routeStats or {}
	aimData.recentShots = type(aimData.recentShots) == "table"
		and aimData.recentShots or {}
	while #aimData.knifePhysics.recentSpeeds > 12 do
		table.remove(aimData.knifePhysics.recentSpeeds, 1)
	end
	while #aimData.knifePhysics.recentGravities > 8 do
		table.remove(aimData.knifePhysics.recentGravities, 1)
	end
	while #aimData.knifePhysics.recentModels > 12 do
		table.remove(aimData.knifePhysics.recentModels, 1)
	end
	while #aimData.recentShots > 40 do table.remove(aimData.recentShots, 1) end
	local measuredKnifeSpeed = math.clamp(
		tonumber(aimData.knifePhysics.speed) or 200,
		70,
		280
	)
	local measuredKnifeGravity = math.clamp(
		tonumber(aimData.knifePhysics.gravity) or 0,
		0,
		240
	)
	getgenv().TIESAS_MEASURED_KNIFE_SPEED = measuredKnifeSpeed
	runtime.cleanup(writeAimDataNow)

	local function readReceiveAge(root)
		local ok, value = pcall(function() return root.ReceiveAge end)
		if not ok or type(value) ~= "number" or value <= 0 or value > 0.35 then
			return nil
		end
		return value
	end

	local function samplePlayerMotion(player, forceSample, suppliedTime)
		local character = player and player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not root or not humanoid or humanoid.Health <= 0 then
			predictionTracks[player] = nil
			return nil
		end

		local now = suppliedTime or os.clock()
		local track = predictionTracks[player]
		if not track or track.character ~= character
			or now - (track.lastSeenAt or 0) > 0.85 then
			track = {
				character = character,
				samples = {},
				lastSeenAt = now,
			}
			predictionTracks[player] = track
		end

		local position = root.Position
		local receiveAge = readReceiveAge(root)
		local measurementTime = now - (receiveAge or 0)
		local airborne = false
		pcall(function()
			airborne = humanoid.FloorMaterial == Enum.Material.Air
		end)
		local samples = track.samples
		local lastSample = samples[#samples]
		if lastSample then
			local arrivalElapsed = now - (lastSample.arrivalTime or lastSample.time)
			local movement = (position - lastSample.position).Magnitude
			if arrivalElapsed < (forceSample and 0.01 or 0.032) then
				track.lastSeenAt = now
				return track
			end
			-- Roblox puede entregar varias frames con la misma posición remota.
			-- No se introducen duplicados que aparenten una frenada inexistente.
			if movement < 0.015 and arrivalElapsed < 0.16 then
				track.lastSeenAt = now
				track.receiveAge = receiveAge
				return track
			end
			local measurementElapsed = math.max(
				measurementTime - lastSample.time,
				0.004
			)
			if movement > math.max(15, measurementElapsed * 78) then
				table.clear(samples)
				track.teleportedAt = now
			elseif measurementTime <= lastSample.time then
				measurementTime = lastSample.time + 0.004
			end
		end

		table.insert(samples, {
			position = position,
			time = measurementTime,
			arrivalTime = now,
			receiveAge = receiveAge,
			airborne = airborne,
		})
		while #samples > 12
			or (#samples > 3 and measurementTime - samples[1].time > 0.72) do
			table.remove(samples, 1)
		end
		track.lastSeenAt = now
		track.position = position
		track.receiveAge = receiveAge
		return track
	end

	local function weightedLinearFit(samples, firstIndex, lastIndex, now)
		if lastIndex - firstIndex < 1 then return nil end
		local residualWeights
		local velocity
		local positionNow
		local meanResidual = math.huge

		for pass = 1, 2 do
			local totalWeight = 0
			local sumTime = 0
			local sumTimeSquared = 0
			local sumPosition = Vector3.zero
			local sumTimePosition = Vector3.zero
			for index = firstIndex, lastIndex do
				local sample = samples[index]
				local relativeTime = sample.time - now
				local recency = math.exp(relativeTime / 0.24)
				local robustWeight = residualWeights and residualWeights[index] or 1
				local weight = recency * robustWeight
				totalWeight = totalWeight + weight
				sumTime = sumTime + relativeTime * weight
				sumTimeSquared = sumTimeSquared
					+ relativeTime * relativeTime * weight
				sumPosition = sumPosition + sample.position * weight
				sumTimePosition = sumTimePosition
					+ sample.position * (relativeTime * weight)
			end
			if totalWeight <= 0 then return nil end
			local denominator = sumTimeSquared
				- sumTime * sumTime / totalWeight
			if denominator <= 0.000001 then return nil end
			velocity = (
				sumTimePosition - sumPosition * (sumTime / totalWeight)
			) / denominator
			local meanTime = sumTime / totalWeight
			positionNow = sumPosition / totalWeight - velocity * meanTime

			local residuals = {}
			local totalResidual = 0
			for index = firstIndex, lastIndex do
				local sample = samples[index]
				local estimated = positionNow
					+ velocity * (sample.time - now)
				local residual = (sample.position - estimated).Magnitude
				residuals[index] = residual
				totalResidual = totalResidual + residual
			end
			meanResidual = totalResidual / (lastIndex - firstIndex + 1)
			if pass == 1 then
				local values = {}
				for index = firstIndex, lastIndex do
					table.insert(values, residuals[index])
				end
				local scale = math.max(medianNumber(values) or 0, 0.08)
				residualWeights = {}
				for index = firstIndex, lastIndex do
					residualWeights[index] = math.clamp(
						scale * 2.2 / math.max(residuals[index], 0.001),
						0.16,
						1
					)
				end
			end
		end

		return velocity, positionNow, meanResidual,
			samples[lastIndex].time - samples[firstIndex].time
	end

	local function estimateMotion(track, root, humanoid, now)
		local samples = track.samples
		local count = #samples
		if count < 2 then
			local onlySample = samples[count]
			return {
				velocity = Vector3.zero,
				acceleration = Vector3.zero,
				confidence = 0.18,
				behavior = "warming",
				turnScore = 0,
				brakeScore = 0,
				airborne = onlySample and onlySample.airborne or false,
				observationAge = onlySample
					and math.max(0, now - onlySample.time) or nil,
				estimatedRootPosition = onlySample
					and onlySample.position or root.Position,
			}
		end

		local fullVelocity, positionNow, residual, span = weightedLinearFit(
			samples,
			1,
			count,
			now
		)
		if not fullVelocity then return nil end
		local recentFirst = math.max(1, count - 4)
		local recentVelocity = weightedLinearFit(
			samples,
			recentFirst,
			count,
			now
		) or fullVelocity
		local olderLast = math.max(2, count - 3)
		local olderVelocity = weightedLinearFit(
			samples,
			1,
			olderLast,
			now
		) or fullVelocity

		local recentHorizontal = Vector3.new(
			recentVelocity.X,
			0,
			recentVelocity.Z
		)
		local olderHorizontal = Vector3.new(
			olderVelocity.X,
			0,
			olderVelocity.Z
		)
		local directionAgreement = 1
		if recentHorizontal.Magnitude > 1.2 and olderHorizontal.Magnitude > 1.2 then
			directionAgreement = math.clamp(
				recentHorizontal.Unit:Dot(olderHorizontal.Unit),
				-1,
				1
			)
		end
		local turnScore = math.clamp((1 - directionAgreement) / 1.25, 0, 1)
		local brakeScore = olderHorizontal.Magnitude > 3
			and math.clamp(
				(olderHorizontal.Magnitude - recentHorizontal.Magnitude)
					/ olderHorizontal.Magnitude,
				0,
				1
			) or 0

		local velocity = fullVelocity:Lerp(
			recentVelocity,
			turnScore > 0.32 and 0.88 or 0.68
		)
		local horizontal = clampVector(
			Vector3.new(velocity.X, 0, velocity.Z),
			50
		)
		velocity = Vector3.new(
			horizontal.X,
			math.clamp(velocity.Y, -52, 52),
			horizontal.Z
		)

		local acceleration = Vector3.zero
		if count >= 5 and span >= 0.16 then
			local centerDistance = math.max(span * 0.52, 0.08)
			local rawAcceleration = (
				recentVelocity - olderVelocity
			) / centerDistance
			local horizontalAcceleration = clampVector(
				Vector3.new(rawAcceleration.X, 0, rawAcceleration.Z),
				62
			)
			acceleration = Vector3.new(
				horizontalAcceleration.X,
				0,
				horizontalAcceleration.Z
			)
			if acceleration.Magnitude < 2.2 then acceleration = Vector3.zero end
		end

		local floorIsAir = false
		pcall(function()
			floorIsAir = humanoid.FloorMaterial == Enum.Material.Air
		end)
		local airborne = floorIsAir or math.abs(velocity.Y) > 2.4
		if airborne then
			local firstAirborne = count
			while firstAirborne > 1
				and samples[firstAirborne - 1].airborne do
				firstAirborne = firstAirborne - 1
			end
			firstAirborne = math.max(firstAirborne, count - 5)
			if count - firstAirborne >= 2 then
				local ballisticSamples = {}
				for index = firstAirborne, count do
					local sample = samples[index]
					local age = sample.time - now
					table.insert(ballisticSamples, {
						position = sample.position
							+ Vector3.new(
								0,
								0.5 * workspace.Gravity * age * age,
								0
							),
						time = sample.time,
					})
				end
				local ballisticVelocity, ballisticPosition = weightedLinearFit(
					ballisticSamples,
					1,
					#ballisticSamples,
					now
				)
				if ballisticVelocity and ballisticPosition then
					velocity = Vector3.new(
						velocity.X,
						math.clamp(ballisticVelocity.Y, -62, 62),
						velocity.Z
					)
					positionNow = Vector3.new(
						positionNow.X,
						ballisticPosition.Y,
						positionNow.Z
					)
				end
			end
		end
		local confidence = math.clamp((count - 1) / 7, 0.2, 1)
			* math.clamp(span / 0.28, 0.3, 1)
			* (1 - math.clamp(
				residual / math.max(0.35, velocity.Magnitude * 0.055 + 0.18),
				0,
				0.78
			))
			* (1 - turnScore * 0.62)
			* (1 - brakeScore * 0.34)
		confidence = math.clamp(confidence, 0.12, 0.98)

		local behavior = "stable"
		if track.teleportedAt and now - track.teleportedAt < 0.25 then
			behavior = "teleport"
			confidence = math.min(confidence, 0.14)
		elseif directionAgreement < -0.05 then
			behavior = "reversal"
			confidence = math.min(confidence, 0.2)
		elseif turnScore > 0.34 then
			behavior = "turning"
		elseif brakeScore > 0.34 then
			behavior = "braking"
		elseif recentHorizontal.Magnitude < 0.85 and not airborne then
			behavior = "stationary"
			velocity = Vector3.new(0, 0, 0)
			acceleration = Vector3.zero
			confidence = math.max(confidence, 0.86)
		elseif airborne then
			behavior = "airborne"
		end

		local receiveAges = {}
		for index = math.max(1, count - 2), count do
			local receiveAge = samples[index].receiveAge
			if receiveAge then table.insert(receiveAges, receiveAge) end
		end

		local observationAge = math.max(0, now - samples[count].time)
		confidence = confidence
			* (1 - math.clamp((observationAge - 0.035) / 0.24, 0, 0.52))

		return {
			velocity = velocity,
			acceleration = acceleration,
			confidence = confidence,
			behavior = behavior,
			turnScore = turnScore,
			brakeScore = brakeScore,
			airborne = airborne,
			observationAge = math.max(
				observationAge,
				medianNumber(receiveAges) or 0
			),
			estimatedRootPosition = positionNow,
			residual = residual,
		}
	end

	local lastPingSampleAt = 0
	local motionAccumulator = 0
	local motionFrameAverage = 1 / 60
	runtime.track(rs.PostSimulation:Connect(function(deltaTime)
		if not runtime.alive then return end
		local now = os.clock()
		motionFrameAverage = motionFrameAverage
			+ (deltaTime - motionFrameAverage) * 0.06
		motionAccumulator = motionAccumulator + deltaTime

		if now - lastPingSampleAt >= 0.25 then
			lastPingSampleAt = now
			local networkPing = 0
			local dataPing = 0
			pcall(function() networkPing = localplayer:GetNetworkPing() end)
			pcall(function()
				dataPing = statsService.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
			end)
			networkPing = math.clamp(networkPing, 0, 0.35)
			dataPing = math.clamp(dataPing, 0, 0.6)
			if dataPing <= 0 then dataPing = networkPing end
			if smoothedNetworkPing == 0 then
				smoothedNetworkPing = networkPing
				smoothedDataPing = dataPing
			else
				local difference = math.abs(networkPing - smoothedNetworkPing)
				networkPingJitter = networkPingJitter
					+ (difference - networkPingJitter) * 0.18
				smoothedNetworkPing = smoothedNetworkPing
					+ (networkPing - smoothedNetworkPing)
						* (difference > 0.08 and 0.35 or 0.16)
				smoothedDataPing = smoothedDataPing
					+ (dataPing - smoothedDataPing)
					* (math.abs(dataPing - smoothedDataPing) > 0.1 and 0.3 or 0.12)
			end
		end

		local rolesAssigned = cachedMurderer ~= nil
			or cachedSheriff ~= nil or cachedHero ~= nil
		local sampleInterval = not rolesAssigned and 0.15
			or motionFrameAverage > 1 / 38 and 0.075
			or 0.05
		if motionAccumulator < sampleInterval then return end
		motionAccumulator = math.min(
			motionAccumulator - sampleInterval,
			sampleInterval
		)
		for _, player in ipairs(game.Players:GetPlayers()) do
			if player ~= localplayer then
				samplePlayerMotion(player, false, now)
			end
		end
	end))

	local function getEffectivePing()
		local networkPing = smoothedNetworkPing > 0 and smoothedNetworkPing or 0.08
		local dataPing = smoothedDataPing > 0 and smoothedDataPing or networkPing
		return math.clamp(networkPing * 0.62 + dataPing * 0.38, 0.02, 0.45)
	end

	local function getTargetState(player)
		local character = player and player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not root or not humanoid or humanoid.Health <= 0 then return nil end
		local now = os.clock()
		local track = samplePlayerMotion(player, true, now)
		if not track then return nil end
		local estimate = estimateMotion(track, root, humanoid, now)
		if not estimate then return nil end
		estimate.character = character
		estimate.root = root
		estimate.rootPosition = root.Position
		estimate.estimatedRootPosition = estimate.estimatedRootPosition
			or root.Position
		estimate.sampleTime = now
		estimate.track = track
		return estimate
	end

	local function getMotionFactor(state)
		local factor = 0.18 + state.confidence * 0.82
		if state.behavior == "reversal" then
			factor = math.min(factor, 0.16)
		elseif state.behavior == "turning" then
			factor = math.min(factor, 0.46)
		elseif state.behavior == "braking" then
			factor = math.min(factor, 0.62)
		elseif state.behavior == "teleport" then
			factor = math.min(factor, 0.1)
		end
		return math.clamp(factor, 0.12, 1)
	end

	local function getRouteStat(route)
		local stat = aimData.routeStats[route]
		if type(stat) ~= "table" then
			stat = {rtt = 0, samples = 0, successes = 0}
			aimData.routeStats[route] = stat
		end
		stat.rtt = math.clamp(tonumber(stat.rtt) or 0, 0, 0.8)
		stat.samples = math.clamp(tonumber(stat.samples) or 0, 0, 200)
		stat.successes = math.clamp(tonumber(stat.successes) or 0, 0, 200)
		return stat
	end

	local function getLatencyState(route, state)
		local networkRtt = smoothedNetworkPing > 0 and smoothedNetworkPing or 0.08
		local dataRtt = smoothedDataPing > 0 and smoothedDataPing or networkRtt
		local reliableQueue = math.max(0, dataRtt - networkRtt)
		local commandDelay = networkRtt * 0.5 + reliableQueue * 0.3
		local routeStat = getRouteStat(route or "unknown")
		if routeStat.samples >= 2 and routeStat.rtt > 0 then
			commandDelay = commandDelay * 0.7
				+ math.clamp(routeStat.rtt * 0.5, 0.01, 0.22) * 0.3
		end

		local receiveAge = state and state.observationAge
		-- La regresión ya extrapola la muestra replicada hasta "ahora". Aquí solo
		-- queda un margen pequeño por cola/jitter, no la edad completa otra vez.
		local observationDelay = reliableQueue * 0.08
		if receiveAge then
			observationDelay = observationDelay
				+ math.clamp(receiveAge, 0, 0.12)
					* (1 - (state.confidence or 0)) * 0.12
		else
			observationDelay = observationDelay + dataRtt * 0.035
		end

		return {
			networkRtt = networkRtt,
			dataRtt = dataRtt,
			commandDelay = math.clamp(commandDelay, 0.012, 0.22),
			observationDelay = math.clamp(observationDelay, 0, 0.045),
			jitterBuffer = math.min(networkPingJitter, 0.055) * 0.14,
		}
	end

	local function predictTargetDisplacement(state, horizon)
		local factor = getMotionFactor(state)
		local horizontalVelocity = Vector3.new(
			state.velocity.X,
			0,
			state.velocity.Z
		)
		local horizontalAcceleration = state.acceleration
		local accelerationWindow = math.min(horizon, 0.18)
		local horizontalDisplacement = horizontalVelocity * (horizon * factor)
			+ horizontalAcceleration
				* (0.5 * accelerationWindow * accelerationWindow
					* state.confidence * factor)

		local verticalDisplacement = 0
		if state.airborne then
			local verticalConfidence = 0.52 + state.confidence * 0.48
			verticalDisplacement = state.velocity.Y * horizon * verticalConfidence
				- 0.5 * workspace.Gravity * horizon * horizon
			local futureVerticalVelocity = state.velocity.Y
				- workspace.Gravity * horizon
			if futureVerticalVelocity < 0 then
				local estimatedRoot = state.estimatedRootPosition
					or state.rootPosition
				local futureHorizontal = estimatedRoot + horizontalDisplacement
				local rayOrigin = Vector3.new(
					futureHorizontal.X,
					estimatedRoot.Y + math.max(verticalDisplacement, 0) + 2,
					futureHorizontal.Z
				)
				local params = RaycastParams.new()
				params.FilterType = Enum.RaycastFilterType.Exclude
				params.FilterDescendantsInstances = {state.character}
				local ground = workspace:Raycast(
					rayOrigin,
					Vector3.new(
						0,
						-(18 + math.abs(verticalDisplacement)),
						0
					),
					params
				)
				if ground then
					local minimumDisplacement = ground.Position.Y + 2.65
						- estimatedRoot.Y
					verticalDisplacement = math.max(
						verticalDisplacement,
						minimumDisplacement
					)
				end
			end
		elseif math.abs(state.velocity.Y) > 1.4 then
			verticalDisplacement = state.velocity.Y
				* math.min(horizon, 0.08) * state.confidence
		end

		return horizontalDisplacement
			+ Vector3.new(0, verticalDisplacement, 0),
			factor
	end

	local function classifyRadialMotion(origin, targetPosition, velocity)
		local relative = targetPosition - origin
		if relative.Magnitude < 0.01 then return "lateral", 0 end
		local radialSpeed = velocity:Dot(relative.Unit)
		if radialSpeed < -3 then
			return "approaching", radialSpeed
		elseif radialSpeed > 3 then
			return "receding", radialSpeed
		end
		return "lateral", radialSpeed
	end

	local bodyPointDefinitions
	local function isTrajectoryClear(character, origin, targetPosition, radius)
		if not character or not targetPosition then return false end
		local direction = targetPosition - origin
		if direction.Magnitude < 0.01 then return true end
		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		local excluded = {localplayer.Character}
		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("Accessory") or child:IsA("Tool") then
				table.insert(excluded, child)
			end
		end
		params.FilterDescendantsInstances = excluded
		local hit
		if radius and radius > 0 then
			local ok = pcall(function()
				hit = workspace:Spherecast(origin, radius, direction, params)
			end)
			if not ok then hit = workspace:Raycast(origin, direction, params) end
		else
			hit = workspace:Raycast(origin, direction, params)
		end
		if not hit then return true end
		if not hit.Instance:IsDescendantOf(character)
			or not hit.Instance:IsA("BasePart") then
			return false
		end
		for _, definition in ipairs(bodyPointDefinitions or {}) do
			if hit.Instance.Name == definition.name then return true end
		end
		return false
	end

	bodyPointDefinitions = {
		{name = "UpperTorso", priority = 5.4, radius = 0.78},
		{name = "Torso", priority = 5.35, radius = 0.82},
		{name = "LowerTorso", priority = 5.05, radius = 0.74},
		{name = "HumanoidRootPart", priority = 4.75, radius = 0.7},
		{name = "Head", priority = 3.8, radius = 0.52},
	}

	local function chooseVisibleBodyPoint(character, origin, displacement)
		for _, name in ipairs({"UpperTorso", "Torso"}) do
			local part = character:FindFirstChild(name)
			if part and part:IsA("BasePart") and part.CanQuery then
				local predicted = part.Position + displacement
				if isTrajectoryClear(character, origin, predicted)
					and isTrajectoryClear(character, origin, predicted, 0.16) then
					return {
						position = predicted,
						currentPosition = part.Position,
						partName = name,
						radius = math.min(
							0.78,
							math.min(part.Size.X, part.Size.Y) * 0.45
						),
						leadFraction = 1,
					}
				end
			end
		end

		local best
		local bestScore = -math.huge
		for _, definition in ipairs(bodyPointDefinitions) do
			local part = character:FindFirstChild(definition.name)
			if part and part:IsA("BasePart") and part.CanQuery then
				local offsets = {
					Vector3.zero,
					part.CFrame.UpVector * math.min(part.Size.Y * 0.18, 0.3),
					-part.CFrame.UpVector * math.min(part.Size.Y * 0.16, 0.26),
					part.CFrame.RightVector * math.min(part.Size.X * 0.16, 0.24),
					-part.CFrame.RightVector * math.min(part.Size.X * 0.16, 0.24),
				}
				for offsetIndex, offset in ipairs(offsets) do
					local currentPoint = part.Position + offset
					local predicted = currentPoint + displacement
					for _, fraction in ipairs({1, 0.76, 0.48, 0}) do
						local point = currentPoint:Lerp(predicted, fraction)
						if isTrajectoryClear(character, origin, point) then
							local clearance = 0
							if isTrajectoryClear(character, origin, point, 0.12) then
								clearance = clearance + 1
							end
							if isTrajectoryClear(character, origin, point, 0.24) then
								clearance = clearance + 1
							end
							local centerBonus = offsetIndex == 1 and 0.55 or 0
							local score = definition.priority
								+ clearance * 0.72
								+ fraction * 1.35
								+ centerBonus
							if score > bestScore then
								bestScore = score
								best = {
									position = point,
									currentPosition = currentPoint,
									partName = definition.name,
									radius = math.min(
										definition.radius,
										math.min(part.Size.X, part.Size.Y) * 0.45
									),
									leadFraction = fraction,
								}
							end
							break
						end
					end
				end
			end
		end
		return best
	end

	local function getGunRouteCandidates(gun)
		local candidates = {}
		local shootRemote = gun and gun:FindFirstChild("Shoot")
		if shootRemote and shootRemote:IsA("RemoteEvent") then
			table.insert(candidates, {
				name = "Shoot",
				kind = "event",
				remote = shootRemote,
			})
		end

		local knifeLocal = gun and gun:FindFirstChild("KnifeLocal")
		local createBeam = knifeLocal and knifeLocal:FindFirstChild("CreateBeam")
		local remoteFunction = createBeam and createBeam:FindFirstChild("RemoteFunction")
		if remoteFunction and remoteFunction:IsA("RemoteFunction") then
			table.insert(candidates, {
				name = "RemoteFunction",
				kind = "function",
				remote = remoteFunction,
			})
		end

		local knifeServer = gun and gun:FindFirstChild("KnifeServer")
		local legacyShootGun = knifeServer and knifeServer:FindFirstChild("ShootGun")
		if legacyShootGun and legacyShootGun:IsA("RemoteFunction") then
			table.insert(candidates, {
				name = "ShootGun",
				kind = "legacy",
				remote = legacyShootGun,
			})
		end

		return candidates
	end

	local function getPreferredGunRouteName(gun)
		local candidates = getGunRouteCandidates(gun)
		return candidates[1] and candidates[1].name or "unknown"
	end

	local function getAimOriginForRoute(origin, route, commandDelay)
		if route == "Shoot" then return origin, false end
		local character = localplayer.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not root or not humanoid then return origin, false end

		local velocity = Vector3.zero
		pcall(function() velocity = root.AssemblyLinearVelocity end)
		velocity = clampVector(velocity, 58)
		local horizon = math.min(commandDelay, 0.16)
		local displacement = velocity * horizon
		local airborne = false
		pcall(function()
			airborne = humanoid.FloorMaterial == Enum.Material.Air
		end)
		if airborne then
			displacement = displacement
				- Vector3.new(0, 0.5 * workspace.Gravity * horizon * horizon, 0)
			local params = RaycastParams.new()
			params.FilterType = Enum.RaycastFilterType.Exclude
			params.FilterDescendantsInstances = {character}
			local ground = workspace:Raycast(
				root.Position,
				Vector3.new(0, -12, 0),
				params
			)
			if ground then
				local clearance = math.max(
					0,
					root.Position.Y - ground.Position.Y - 2.65
				)
				if displacement.Y < -clearance then
					displacement = Vector3.new(
						displacement.X,
						-clearance,
						displacement.Z
					)
				end
			end
		else
			displacement = Vector3.new(displacement.X, 0, displacement.Z)
		end
		return origin + clampVector(displacement, 4.5), airborne
	end

	local function getGunPredictedPosition(player, origin, movementPrediction, gun)
		local state = getTargetState(player)
		if not state then return nil end
		local route = getPreferredGunRouteName(gun)
		local latency = getLatencyState(route, state)
		local pingScale = math.clamp(tonumber(offsetToPingMult) or 1, 0, 3)
		local manualLead = math.clamp(
			tonumber(movementPrediction) or 2.8,
			0,
			5
		) * 0.003
		local leadTime = math.clamp(
			(latency.commandDelay + latency.observationDelay) * pingScale
				+ latency.jitterBuffer
				+ manualLead,
			0.014,
			0.23
		)
		local aimOrigin, shooterAirborne = getAimOriginForRoute(
			origin,
			route,
			latency.commandDelay * pingScale
		)
		local estimatedRoot = state.estimatedRootPosition
			or state.rootPosition
		local relative = estimatedRoot - aimOrigin
		if relative.Magnitude < 0.01 then return estimatedRoot end

		local context, radialSpeed = classifyRadialMotion(
			aimOrigin,
			estimatedRoot,
			state.velocity
		)
		local radialDirection = relative.Unit
		local tangentialVelocity = state.velocity
			- radialDirection * state.velocity:Dot(radialDirection)
		local tangentialSpeed = tangentialVelocity.Magnitude
		local traceDelay = math.clamp(
			latency.commandDelay * pingScale,
			0.012,
			0.22
		)

		-- En un raycast, acercarse o alejarse por la misma línea no exige
		-- adelantar el ángulo. Separar la componente tangencial evita que el
		-- comportamiento cambie artificialmente al disparar de frente o detrás.
		local fullDisplacement, motionFactor = predictTargetDisplacement(
			state,
			leadTime
		)
		local displacement = fullDisplacement
			- radialDirection * fullDisplacement:Dot(radialDirection)
		displacement = displacement
			+ (estimatedRoot - state.rootPosition)
		local bodyPoint = chooseVisibleBodyPoint(
			state.character,
			aimOrigin,
			displacement
		)
		if not bodyPoint then return nil end

		return bodyPoint.position, {
			weapon = "gun",
			context = context,
			routeHint = route,
			leadTime = leadTime,
			traceDelay = traceDelay,
			ping = getEffectivePing(),
			commandDelay = latency.commandDelay,
			observationDelay = latency.observationDelay,
			distance = relative.Magnitude,
			radialSpeed = radialSpeed,
			tangentialSpeed = tangentialSpeed,
			tangentialVelocity = tangentialVelocity,
			velocity = state.velocity,
			motionFactor = motionFactor,
			confidence = state.confidence,
			behavior = state.behavior,
			turnScore = state.turnScore,
			brakeScore = state.brakeScore,
			rootPosition = state.rootPosition,
			baseAimPosition = bodyPoint.currentPosition,
			predictedPosition = bodyPoint.position,
			aimOrigin = aimOrigin,
			shooterAirborne = shooterAirborne,
			targetAirborne = state.airborne,
			receiveAge = state.observationAge,
			targetPartName = bodyPoint.partName,
			targetRadius = bodyPoint.radius,
			leadFraction = bodyPoint.leadFraction,
			wallAdjusted = bodyPoint.leadFraction < 0.99,
		}
	end

	local function solveInterceptTime(relativePosition, targetVelocity, projectileSpeed)
		local a = targetVelocity:Dot(targetVelocity) - projectileSpeed * projectileSpeed
		local b = 2 * relativePosition:Dot(targetVelocity)
		local c = relativePosition:Dot(relativePosition)
		if math.abs(a) < 0.0001 then
			if math.abs(b) < 0.0001 then
				return relativePosition.Magnitude / projectileSpeed
			end
			local linearTime = -c / b
			return linearTime > 0
				and linearTime or relativePosition.Magnitude / projectileSpeed
		end

		local discriminant = b * b - 4 * a * c
		if discriminant < 0 then
			return relativePosition.Magnitude / projectileSpeed
		end
		local root = math.sqrt(discriminant)
		local first = (-b - root) / (2 * a)
		local second = (-b + root) / (2 * a)
		local best = math.huge
		if first > 0 then best = first end
		if second > 0 and second < best then best = second end
		return best < math.huge
			and best or relativePosition.Magnitude / projectileSpeed
	end

	local function getKnifeBasePoint(character, origin)
		-- El cuchillo compara varios jugadores en cada pulsación. Esta ruta
		-- ligera mantiene el coste bajo en iPhone sin renunciar al torso.
		for _, definition in ipairs(bodyPointDefinitions) do
			local part = character:FindFirstChild(definition.name)
			if part and part:IsA("BasePart") and part.CanQuery
				and isTrajectoryClear(character, origin, part.Position, 0.16) then
				return {
					position = part.Position,
					currentPosition = part.Position,
					partName = definition.name,
					radius = definition.radius,
					leadFraction = 1,
				}
			end
		end
		return nil
	end

	local function getKnifePredictedPosition(player, origin, movementPrediction)
		local state = getTargetState(player)
		if not state then return nil end
		local bodyPoint = getKnifeBasePoint(state.character, origin)
		if not bodyPoint then return nil end
		local estimatedRoot = state.estimatedRootPosition
			or state.rootPosition
		local replicatedCorrection = estimatedRoot - state.rootPosition

		local projectileSpeed = math.clamp(measuredKnifeSpeed, 70, 280)
		local pingScale = math.clamp(tonumber(offsetToPingMult) or 1, 0, 3)
		local latency = getLatencyState("KnifeThrown", state)
		local manualLead = math.clamp(
			tonumber(movementPrediction) or 2.8,
			0,
			5
		) * 0.0025
		local networkLead = math.clamp(
			(latency.commandDelay + latency.observationDelay) * pingScale
				+ manualLead
				+ latency.jitterBuffer,
			0.012,
			0.28
		)
		local motionFactor = getMotionFactor(state)
		local reliableVelocity = state.velocity * motionFactor
		local initialRelative = bodyPoint.currentPosition + replicatedCorrection
			+ reliableVelocity * networkLead - origin
		local travelTime = math.clamp(
			solveInterceptTime(initialRelative, reliableVelocity, projectileSpeed),
			0,
			1.7
		)
		local totalTime = networkLead + travelTime
		local predictedPosition

		for _ = 1, 5 do
			local targetDisplacement = predictTargetDisplacement(state, totalTime)
			predictedPosition = bodyPoint.currentPosition
				+ replicatedCorrection + targetDisplacement
			local physicsModel = aimData.knifePhysics.model
			local modelConfidence = tonumber(
				aimData.knifePhysics.modelConfidence
			) or 0
			if physicsModel == "ballistic"
				and modelConfidence >= 0.62
				and measuredKnifeGravity >= 15 then
				predictedPosition = predictedPosition + Vector3.new(
					0,
					0.5 * measuredKnifeGravity * travelTime * travelTime,
					0
				)
			end
			travelTime = math.clamp(
				(predictedPosition - origin).Magnitude / projectileSpeed,
				0,
				1.7
			)
			totalTime = networkLead + travelTime
		end

		local context, radialSpeed = classifyRadialMotion(
			origin,
			bodyPoint.currentPosition + replicatedCorrection,
			state.velocity
		)
		return predictedPosition, {
			weapon = "knife",
			context = context,
			leadTime = totalTime,
			travelTime = travelTime,
			ping = getEffectivePing(),
			commandDelay = latency.commandDelay,
			observationDelay = latency.observationDelay,
			distance = (bodyPoint.currentPosition - origin).Magnitude,
			radialSpeed = radialSpeed,
			confidence = state.confidence,
			behavior = state.behavior,
			motionFactor = motionFactor,
			projectileSpeed = projectileSpeed,
			projectileGravity = measuredKnifeGravity,
			projectileModel = aimData.knifePhysics.model,
			rootPosition = state.rootPosition,
			baseAimPosition = bodyPoint.currentPosition,
			predictedPosition = predictedPosition,
			targetAirborne = state.airborne,
			receiveAge = state.observationAge,
			targetPartName = bodyPoint.partName,
			targetRadius = bodyPoint.radius,
		}
	end

	local knifeProjectileSeenAt = setmetatable({}, {__mode = "k"})
	for _, object in ipairs(workspace:GetDescendants()) do
		if object.Name == "ThrowingKnife" then
			knifeProjectileSeenAt[object] = 0
		end
	end
	runtime.track(workspace.DescendantAdded:Connect(function(object)
		if object.Name == "ThrowingKnife" then
			knifeProjectileSeenAt[object] = os.clock()
		end
	end))

	local function observeNextKnifePhysics(origin, predictedPosition)
		local connection
		local finished = false
		local testing = setmetatable({}, {__mode = "k"})
		local observerStartedAt = os.clock()
		local expectedDirection = predictedPosition - origin
		expectedDirection = expectedDirection.Magnitude > 0.01
			and expectedDirection.Unit or nil

		connection = runtime.track(workspace.DescendantAdded:Connect(function(object)
			if finished or not runtime.alive then return end
			local projectile = object
			while projectile and projectile ~= workspace
				and projectile.Name ~= "ThrowingKnife" do
				projectile = projectile.Parent
			end
			if not projectile or projectile == workspace or testing[projectile] then return end
			local seenAt = knifeProjectileSeenAt[projectile]
			if not seenAt or seenAt < observerStartedAt - 0.03 then return end
			testing[projectile] = true

			task.spawn(function()
				local deadline = os.clock() + 0.22
				local part
				repeat
					part = projectile:IsA("BasePart") and projectile
						or projectile:IsA("Model") and projectile.PrimaryPart
						or projectile:FindFirstChildWhichIsA("BasePart", true)
					if not part then task.wait() end
				until part or os.clock() >= deadline or not projectile.Parent
					or not runtime.alive
				if finished or not runtime.alive or not part or not projectile.Parent then
					return
				end

				local function getPosition()
					if projectile:IsA("Model") then
						return projectile:GetPivot().Position
					end
					return part.Position
				end

				local previousPosition = getPosition()
				if (previousPosition - origin).Magnitude > 18 then return end
				local previousTime = os.clock()
				local speeds = {}
				local directions = {}
				local velocities = {}
				local velocityTimes = {}
				for _ = 1, 10 do
					rs.Heartbeat:Wait()
					if not runtime.alive or not projectile.Parent then break end
					local position = getPosition()
					local now = os.clock()
					local elapsed = now - previousTime
					if elapsed > 0.004 and elapsed < 0.12 then
						local delta = position - previousPosition
						local velocity = delta / elapsed
						local assemblyVelocity
						pcall(function()
							assemblyVelocity = part.AssemblyLinearVelocity
						end)
						if typeof(assemblyVelocity) == "Vector3"
							and assemblyVelocity.Magnitude >= 45
							and assemblyVelocity.Magnitude <= 320
							and velocity.Magnitude > 0.01
							and velocity.Unit:Dot(assemblyVelocity.Unit) > 0.5 then
							velocity = velocity:Lerp(assemblyVelocity, 0.35)
						end
						local speed = velocity.Magnitude
						if speed >= 45 and speed <= 320 then
							table.insert(speeds, speed)
							table.insert(velocities, velocity)
							table.insert(velocityTimes, now)
							if delta.Magnitude > 0.01 then
								table.insert(directions, delta.Unit)
							end
						end
					end
					previousPosition = position
					previousTime = now
				end
				if finished or #speeds < 4 or #directions < 3 then return end

				local initialDirection = directions[1]
				if expectedDirection and initialDirection:Dot(expectedDirection) < 0.72 then
					return
				end
				local directionAgreement = 0
				for index = 2, #directions do
					directionAgreement = directionAgreement
						+ directions[index - 1]:Dot(directions[index])
				end
				directionAgreement = directionAgreement / (#directions - 1)
				if directionAgreement < 0.76 then return end

				finished = true
				runtime.release(connection)
				local medianSpeed = tonumber(medianNumber(speeds))
				if not medianSpeed then return end
				local recentSpeeds = aimData.knifePhysics.recentSpeeds
				table.insert(recentSpeeds, math.clamp(medianSpeed, 70, 280))
				while #recentSpeeds > 12 do table.remove(recentSpeeds, 1) end
				local robustSpeed = medianNumber(recentSpeeds) or medianSpeed
				local measurements = tonumber(aimData.knifePhysics.measurements) or 0
				local blend = measurements < 2 and 1 or 0.34
				measuredKnifeSpeed = math.clamp(
					measuredKnifeSpeed
						+ (robustSpeed - measuredKnifeSpeed) * blend,
					70,
					280
				)
				aimData.knifePhysics.speed = measuredKnifeSpeed
				aimData.knifePhysics.measurements = measurements + 1
				getgenv().TIESAS_MEASURED_KNIFE_SPEED = measuredKnifeSpeed

				local verticalAccelerations = {}
				for index = 2, #velocities do
					local elapsed = velocityTimes[index] - velocityTimes[index - 1]
					if elapsed > 0.004 then
						local accelerationY = (
							velocities[index].Y - velocities[index - 1].Y
						) / elapsed
						if accelerationY >= -300 and accelerationY <= 300 then
							table.insert(verticalAccelerations, accelerationY)
						end
					end
				end
				if #verticalAccelerations >= 4 then
					local medianAcceleration = medianNumber(verticalAccelerations)
					local negativeCount = 0
					local deviations = {}
					for _, accelerationY in ipairs(verticalAccelerations) do
						if accelerationY < -10 then negativeCount = negativeCount + 1 end
						table.insert(
							deviations,
							math.abs(accelerationY - (medianAcceleration or 0))
						)
					end
					local gravity = medianAcceleration and -medianAcceleration or 0
					local dispersion = medianNumber(deviations) or math.huge
					local ballisticEvidence = gravity >= 15
						and gravity <= 240
						and negativeCount / #verticalAccelerations >= 0.7
						and dispersion <= math.max(28, gravity * 0.45)
					local recentModels = aimData.knifePhysics.recentModels
					if ballisticEvidence then
						table.insert(recentModels, "ballistic")
						local recentGravities = aimData.knifePhysics.recentGravities
						table.insert(recentGravities, gravity)
						while #recentGravities > 8 do
							table.remove(recentGravities, 1)
						end
						local robustGravity = medianNumber(recentGravities) or gravity
						local gravityMeasurements = tonumber(
							aimData.knifePhysics.gravityMeasurements
						) or 0
						measuredKnifeGravity = math.clamp(
							measuredKnifeGravity
								+ (robustGravity - measuredKnifeGravity)
									* (gravityMeasurements < 2 and 0.65 or 0.24),
							0,
							240
						)
						aimData.knifePhysics.gravity = measuredKnifeGravity
						aimData.knifePhysics.gravityMeasurements = gravityMeasurements + 1
					elseif math.abs(medianAcceleration or 0) <= 32
						or dispersion > 65 then
						table.insert(recentModels, "linear")
					end
					while #recentModels > 12 do table.remove(recentModels, 1) end
					local ballisticVotes = 0
					local linearVotes = 0
					for _, model in ipairs(recentModels) do
						if model == "ballistic" then
							ballisticVotes = ballisticVotes + 1
						elseif model == "linear" then
							linearVotes = linearVotes + 1
						end
					end
					aimData.knifePhysics.ballisticVotes = ballisticVotes
					aimData.knifePhysics.linearVotes = linearVotes
					local totalVotes = ballisticVotes + linearVotes
					if totalVotes >= 3 then
						aimData.knifePhysics.model = ballisticVotes > linearVotes
							and "ballistic" or "linear"
						aimData.knifePhysics.modelConfidence = math.clamp(
							math.abs(ballisticVotes - linearVotes)
								/ math.max(totalVotes, 1)
								* math.clamp(totalVotes / 6, 0.5, 1),
							0,
							1
						)
					end
				end
				scheduleAimDataSave()
			end)
		end))

		task.delay(1, function()
			finished = true
			runtime.release(connection)
		end)
	end

	local function findBestKnifeTarget(origin, movementPrediction)
		local bestTarget
		local bestPosition
		local bestMetadata
		local bestScore = math.huge
		for _, player in ipairs(game.Players:GetPlayers()) do
			if player ~= localplayer and player.Character then
				local root = player.Character:FindFirstChild("HumanoidRootPart")
				local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
				if root and humanoid and humanoid.Health > 0 then
					local predictedPosition, metadata = getKnifePredictedPosition(
						player,
						origin,
						movementPrediction
					)
					if predictedPosition and isTrajectoryClear(
						player.Character,
						origin,
						predictedPosition,
						0.24
					) then
						local uncertaintyPenalty = 1
							+ (1 - metadata.confidence) * 0.36
						local score = metadata.distance * uncertaintyPenalty
							+ metadata.travelTime * 9
						if score < bestScore then
							bestScore = score
							bestTarget = player
							bestPosition = predictedPosition
							bestMetadata = metadata
						end
					end
				end
			end
		end
		return bestTarget, bestPosition, bestMetadata
	end

	local function getTrackPositionAt(track, desiredTime)
		local samples = track and track.samples
		if not samples or #samples == 0 then return nil end
		if desiredTime <= samples[1].time then return samples[1].position end
		for index = 2, #samples do
			local newer = samples[index]
			if desiredTime <= newer.time then
				local older = samples[index - 1]
				local span = math.max(newer.time - older.time, 0.001)
				local alpha = math.clamp(
					(desiredTime - older.time) / span,
					0,
					1
				)
				return older.position:Lerp(newer.position, alpha)
			end
		end
		return samples[#samples].position
	end

	local function registerShotOutcome(target, metadata, route, receipt)
		local character = target and target.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not humanoid or not metadata then return end
		local initialHealth = humanoid.Health
		local traceResult = {}

		if metadata.weapon == "gun" then
			local traceDelay = math.clamp(
				metadata.traceDelay or 0.055,
				0.02,
				0.22
			)
			local sentAt = receipt and receipt.sentAt or os.clock()
			local desiredTime = sentAt + traceDelay
			task.delay(math.max(0, desiredTime - os.clock()) + 0.055, function()
				if not runtime.alive or not target
					or target.Character ~= character then return end
				local rootAtArrival = getTrackPositionAt(
					predictionTracks[target],
					desiredTime
				)
				if not rootAtArrival then return end
				local actualPartPosition = metadata.baseAimPosition
					+ (rootAtArrival - metadata.rootPosition)
				local rayOrigin = metadata.aimOrigin or metadata.origin
				local shotVector = metadata.predictedPosition - rayOrigin
				if shotVector.Magnitude < 0.01 then return end
				local shotDirection = shotVector.Unit
				local alongRay = math.max(
					0,
					(actualPartPosition - rayOrigin):Dot(shotDirection)
				)
				local closestPoint = rayOrigin + shotDirection * alongRay
				local missVector = actualPartPosition - closestPoint
				local missDistance = missVector.Magnitude
				local geometricHit = missDistance
					<= (metadata.targetRadius or 0.7) + 0.18
				traceResult.miss = missDistance
				traceResult.geometricHit = geometricHit
				-- V6 guarda esta geometría solo para diagnóstico: no es una
				-- confirmación del servidor y no debe autoajustar el adelanto.
			end)
		end

		local outcomeDelay = metadata.weapon == "knife"
			and math.clamp((metadata.travelTime or 0) + 0.65, 0.8, 2.35)
			or 1.05
		task.delay(outcomeDelay, function()
			if not runtime.alive then return end
			local hit = humanoid.Health <= 0 or humanoid.Parent == nil
			table.insert(aimData.recentShots, {
				weapon = metadata.weapon,
				context = metadata.context,
				route = route,
				hit = hit,
				accepted = not receipt or receipt.accepted ~= false,
				confirmed = receipt and receipt.confirmed or false,
				ping = math.floor((metadata.ping or 0) * 1000 + 0.5),
				distance = math.floor((metadata.distance or 0) + 0.5),
				lead = math.floor((metadata.leadTime or 0) * 1000 + 0.5),
				radial = math.floor((metadata.radialSpeed or 0) * 10 + 0.5) / 10,
				confidence = math.floor((metadata.confidence or 0) * 100 + 0.5),
				behavior = metadata.behavior,
				shooterAirborne = metadata.shooterAirborne or false,
				targetAirborne = metadata.targetAirborne or false,
				receiveAge = metadata.receiveAge
					and math.floor(metadata.receiveAge * 1000 + 0.5) or nil,
				targetPart = metadata.targetPartName,
				wallAdjusted = metadata.wallAdjusted or false,
				geometricHit = traceResult.geometricHit,
				miss = traceResult.miss
					and math.floor(traceResult.miss * 100 + 0.5) / 100 or nil,
				initialHealth = math.floor(initialHealth + 0.5),
				time = os.time(),
			})
			while #aimData.recentShots > 40 do
				table.remove(aimData.recentShots, 1)
			end
			scheduleAimDataSave()
		end)
	end

	local function fireGunAtPosition(gun, origin, predictedPosition)
		for _, candidate in ipairs(getGunRouteCandidates(gun)) do
			if candidate.kind == "function" then
				local sentAt = os.clock()
				local ok, result = pcall(function()
					return candidate.remote:InvokeServer(1, predictedPosition, "AH2")
				end)
				local completedAt = os.clock()
				if ok and result ~= false then
					local stat = getRouteStat(candidate.name)
					local rtt = math.clamp(completedAt - sentAt, 0, 0.8)
					stat.rtt = stat.samples == 0 and rtt
						or stat.rtt + (rtt - stat.rtt) * 0.22
					stat.samples = math.min(200, stat.samples + 1)
					stat.successes = math.min(200, stat.successes + 1)
					scheduleAimDataSave()
					return true, candidate.name, {
						accepted = true,
						confirmed = result ~= nil,
						sentAt = sentAt,
						completedAt = completedAt,
						rtt = rtt,
					}
				end
			elseif candidate.kind == "legacy" then
				local sentAt = os.clock()
				local ok, result = pcall(function()
					return candidate.remote:InvokeServer(0, predictedPosition, "AH")
				end)
				local completedAt = os.clock()
				if ok and result ~= false then
					local stat = getRouteStat(candidate.name)
					local rtt = math.clamp(completedAt - sentAt, 0, 0.8)
					stat.rtt = stat.samples == 0 and rtt
						or stat.rtt + (rtt - stat.rtt) * 0.22
					stat.samples = math.min(200, stat.samples + 1)
					stat.successes = math.min(200, stat.successes + 1)
					scheduleAimDataSave()
					return true, candidate.name, {
						accepted = true,
						confirmed = result ~= nil,
						sentAt = sentAt,
						completedAt = completedAt,
						rtt = rtt,
					}
				end
			elseif candidate.kind == "event" then
				local sentAt = os.clock()
				local ok = pcall(function()
					candidate.remote:FireServer(
						CFrame.new(origin),
						CFrame.new(predictedPosition)
					)
				end)
				if ok then
					return true, candidate.name, {
						accepted = true,
						confirmed = false,
						sentAt = sentAt,
						completedAt = os.clock(),
					}
				end
			end
		end
		return false
	end

	local lastGunShotAt = 0
	local lastKnifeShotAt = 0
	local gunShotInFlight = false

	table.insert(module, {
		Type = "Text",
		Args = {"VISIÓN DE PARTIDA"}
	})
	
	
	table.insert(module, {
		Type = "ButtonGrid",
		Toggleable = true,
		DefaultStates = {"Jugadores", "Arma_caida", "Trampas"},
		Args = {2, {
			Jugadores = function()
				playerESP = not playerESP
				reloadESP()
				if playerESP and not isRoundActive() then
					fu.notification("El ESP aparecerá en cuanto se asignen los roles.")
				end
			end,

			Arma_caida = function()
				gunDropESP = not gunDropESP
				reloadGunESP()
			end,

			Trampas = function()
				trapDetection = not trapDetection
				reloadTrapESP()
			end,
		}}
	})

	task.defer(function()
		reloadAllESP()
		if isRoundActive() then
			fu.notification("Todos los ESP están activados.")
		else
			fu.notification("Todos los ESP están preparados para la próxima ronda.")
		end
	end)

	table.insert(module, {
		Type = "Toggle",
		Args = {"Ocultar mi propio ESP", function(Self, state)
			hideMeEsp = state
			reloadESP()
		end,}
	})
	table.insert(module, {
		Type = "Text",
		Args = {"ACCIÓN CONTEXTUAL"}
	})

	local instakillshoot = false
	local function shootMurderer()
			if not runtime.alive then return end
			if findSheriff() ~= localplayer then
				fu.notification("No eres sheriff ni héroe.")
				return
			end
	
			local murderer = findMurderer()
			if not murderer then
				fu.notification("No se ha encontrado al asesino.")
				return
			end
	
			if not localplayer.Character:FindFirstChild("Gun") then
				local hum = localplayer.Character:FindFirstChild("Humanoid")
				if localplayer.Backpack:FindFirstChild("Gun") then
					hum:EquipTool(localplayer.Backpack:FindFirstChild("Gun"))
				else
					fu.notification("No tienes el arma.")
					return
				end
			end
	
			local murdererCharacter = murderer.Character
			local murdererHRP = murdererCharacter and murdererCharacter:FindFirstChild("HumanoidRootPart")
			if not murdererHRP then
				fu.notification("No se ha podido localizar al asesino.")
				return
			end
	
			local localCharacter = localplayer.Character
			local gun = localCharacter and (
				localCharacter:FindFirstChild("Gun")
				or localCharacter:WaitForChild("Gun", 0.5)
			)
			local originPart = localCharacter and localCharacter:FindFirstChild("RightHand")
				or localCharacter and localCharacter:FindFirstChild("Right Arm")
				or gun and gun:FindFirstChild("Handle")
				or localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
			if not gun or not originPart then
				fu.notification("No se ha podido preparar la pistola.")
				return
			end

			if gunShotInFlight or os.clock() - lastGunShotAt < 1.05 then
				fu.notification("La pistola todavía se está recargando.")
				return
			end

			local predictedPosition, metadata = getGunPredictedPosition(
				murderer,
				originPart.Position,
				shootOffset,
				gun
			)
			if not predictedPosition or not metadata then
				fu.notification("El asesino está detrás de una pared.")
				return
			end

			local fired
			local route
			local receipt
			if instakillshoot then
				metadata.skipLearning = true
				metadata.origin = murdererHRP.Position + Vector3.new(0, 1, 0)
				metadata.aimOrigin = metadata.origin
				metadata.predictedPosition = murdererHRP.Position
				gunShotInFlight = true
				fired, route, receipt = fireGunAtPosition(
					gun,
					metadata.origin,
					metadata.predictedPosition
				)
				gunShotInFlight = false
			else
				metadata.origin = originPart.Position
				gunShotInFlight = true
				fired, route, receipt = fireGunAtPosition(
					gun,
					originPart.Position,
					predictedPosition
				)
				gunShotInFlight = false
			end
			if fired then
				lastGunShotAt = receipt and receipt.sentAt or os.clock()
				registerShotOutcome(murderer, metadata, route, receipt)
			else
				fu.notification("Esta versión de la pistola no es compatible.")
			end

			--local args = {
			--	[1] = 1,
			--	[2] = predictedPosition,
			--	[3] = "AH2"
			--}
	
	
			--localplayer.Character.Gun.KnifeLocal.CreateBeam.RemoteFunction:InvokeServer(unpack(args))
	end
	
	local spawnAtPlayer = false
	local loopThrow = false
	local function knifeThrow(silent)
		if not runtime.alive then return end
		if findMurderer() ~= localplayer then 
			if silent then return end
	
			fu.notification("No eres el asesino.")
			return 
		end
	
		if not localplayer.Character:FindFirstChild("Knife") then
			local hum = localplayer.Character:FindFirstChild("Humanoid")
			if localplayer.Backpack:FindFirstChild("Knife") then
				hum:EquipTool(localplayer.Backpack:FindFirstChild("Knife"))
			else
				if silent then return end
	
				fu.notification("No tienes el cuchillo.")
				return
			end
		end
	
		local localCharacter = localplayer.Character
		local knife = localCharacter and (
			localCharacter:FindFirstChild("Knife")
			or localCharacter:WaitForChild("Knife", 0.5)
		)
		local originPart = localCharacter and localCharacter:FindFirstChild("RightHand")
			or localCharacter and localCharacter:FindFirstChild("Right Arm")
			or knife and knife:FindFirstChild("Handle")
			or localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
		if not knife or not originPart then
			if silent then return end
			fu.notification("No se ha podido preparar el cuchillo.")
			return
		end

		if os.clock() - lastKnifeShotAt < 0.9 then
			if not silent then fu.notification("El cuchillo todavía se está preparando.") end
			return
		end

		local originPosition = originPart.Position
		local NearestPlayer, predictedPosition, metadata = findBestKnifeTarget(
			originPosition,
			shootOffset
		)
		local refreshedOrigin = originPart.Position
		if (refreshedOrigin - originPosition).Magnitude > 0.12 then
			originPosition = refreshedOrigin
			NearestPlayer, predictedPosition, metadata = findBestKnifeTarget(
				originPosition,
				shootOffset
			)
		end

		if not NearestPlayer or not NearestPlayer.Character then
			if silent then return end

			fu.notification("No hay ningún jugador con una trayectoria despejada.")
			return
		end
		local nearestHRP = NearestPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not nearestHRP then
			if silent then return end

			fu.notification("No se ha podido localizar al jugador.")
			return
		end

		if not predictedPosition then
			if silent then return end
			fu.notification("No se ha podido calcular el lanzamiento.")
			return
		end

		local argsThrowRemote = {
			CFrame.new(originPosition),
			CFrame.new(predictedPosition),
		}
	
		if spawnAtPlayer then
			argsThrowRemote[1] = CFrame.new(nearestHRP.Position + (nearestHRP.CFrame.LookVector * 5))
		end
		-- task.spawn(function()
		--     task.wait(2)
		--     -- nearestHRP.Anchored = false
		-- end)
		local events = knife:FindFirstChild("Events")
			or knife:WaitForChild("Events", 0.5)
		local knifeThrown = events and (
			events:FindFirstChild("KnifeThrown")
				or events:WaitForChild("KnifeThrown", 0.5)
		)
		if not knifeThrown or not knifeThrown:IsA("RemoteEvent") then
			if not silent then
				fu.notification("Esta versión del cuchillo no es compatible.")
			end
			return
		end
		observeNextKnifePhysics(originPosition, predictedPosition)
		local sentAt = os.clock()
		local sent = pcall(function()
			knifeThrown:FireServer(unpack(argsThrowRemote))
		end)
		if not sent then
			if not silent then fu.notification("No se ha podido lanzar el cuchillo.") end
			return
		end
		lastKnifeShotAt = sentAt
		metadata.origin = originPosition
		registerShotOutcome(NearestPlayer, metadata, "KnifeThrown", {
			accepted = true,
			confirmed = false,
			sentAt = sentAt,
			completedAt = os.clock(),
		})

		--localplayer.Character:WaitForChild("Knife"):WaitForChild("Throw"):FireServer(unpack(argsThrowRemote))
	end
	
	
	
	
	task.spawn(function()
		while runtime.alive and task.wait(1.5) do
			if loopThrow then
				knifeThrow(true)
			end
		end
	end)
	local shootButtonItem = {
		Type = "Button",
		FloatingDefault = true,
		Args = {"SHOOT", function()
			if not isRoundActive() then
				fu.notification("Necesitas estar en una partida activa para atacar.")
				return
			end

			local character = localplayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if not character or not humanoid or humanoid.Health <= 0 then
				fu.notification("Necesitas estar vivo para atacar.")
				return
			end

			if findSheriff() == localplayer then
				shootMurderer()
			elseif findMurderer() == localplayer then
				knifeThrow()
			else
				fu.notification("SHOOT está disponible cuando seas sheriff, héroe o asesino.")
			end
		end}
	}
	table.insert(module, shootButtonItem)
	
	
	
	table.insert(module, {
		Type = "Toggle",
		Args = {"Lanzamiento automático de cuchillo", function(Self, tog)
			loopThrow = tog
		end}
	})
	-- table.insert(module, {
	-- 	Type = "Toggle",
	-- 	Args = {"Use AI Prediction Engine", function(Self, state)
	-- 		predictionAIEngine = state
	-- 	end,}
	-- })
	
	
	
	table.insert(module, {
		Type = "Input",
		Args = {"Predicción de movimiento", "Aplicar", function(Self, text)
			local value = tonumber(text)
			if not value then fu.notification("Introduce un número válido.") return end
			if value < 0 or value > 5 then
				fu.notification("Usa un valor entre 0 y 5.")
				return
			end
			shootOffset = value
			fu.notification("Predicción actualizada.")
		end,}
	})
	
	table.insert(module, {
		Type = "Input",
		Args = {"Ajuste según el ping", "Aplicar", function(Self, text)
			local value = tonumber(text)
			if not value then fu.notification("Introduce un número válido.") return end
			if value < 0 or value > 3 then
				fu.notification("Usa un valor entre 0 y 3.")
				return
			end
			offsetToPingMult = value
			fu.notification("Ajuste de ping actualizado.")
		end,}
	})
	
	table.insert(module, {
		Type = "Text",
		Args = {"Aim V6 adaptativo. Base automática: 2.8."}
	})

	table.insert(module, {
		Type = "Text",
		Args = {"Salto, ping, replicación y ruta del arma se calculan automáticamente."}
	})

	table.insert(module, {
		Type = "Text",
		Args = {"V6 mide el cuchillo y guarda datos separados para cada juego."}
	})

	if true then
		table.insert(module, {
			Type = "Text",
			Args = {"PERSONALIZACIÓN"}
		})

		table.insert(module, {
			Type = "Range",
			Args = {"Tamaño del menú", 100, 140, 4, function(Self, value)
				local scale = math.clamp(value / 100, 0.65, 1.4)
				getgenv().TIESAS_MENU_SCALE = scale
				getgenv().TIESAS.Menu.UIScale.Scale = scale
			end}
		})

		table.insert(module, {
			Type = "Range",
			Args = {"Altura de los botones", 34, 60, 2, function(Self, value)
				local height = math.clamp(value, 24, 60)
				getgenv().TIESAS_BUTTON_HEIGHT = height
				for _, object in ipairs(getgenv().TIESAS.Menu.Area.Area:GetDescendants()) do
					if object:IsA("UIGridLayout") and object:GetAttribute("TiesasResizableGrid") then
						object.CellSize = UDim2.new(object.CellSize.X.Scale, object.CellSize.X.Offset, 0, height)
					elseif object:IsA("TextButton") and object:GetAttribute("TiesasResizableButton") then
						object.Size = UDim2.new(object.Size.X.Scale, object.Size.X.Offset, 0, height)
					end
				end
			end}
		})

		table.insert(module, {
			Type = "Range",
			Args = {"Tamaño del botón del menú", 60, 110, 2, function(Self, value)
				getgenv().TIESAS_MENU_BUTTON_SIZE = math.clamp(value, 40, 110)
			end}
		})

		table.insert(module, {
			Type = "Text",
			Args = {"Los tamaños se aplican al instante. El tamaño del botón del menú se verá al minimizarlo."}
		})

		repeat task.wait() until getgenv().Modules
		getgenv().Modules[1] = module
		getgenv().TIESAS_MODULES_READY = true
		return
	end
end
local function AWDPHWS_routine() -- Routine: StarterGui.TIESAS.Menu.CloseArea.CloseOpen
    local script = Instance.new("LocalScript")
    script.Name = "CloseOpen"
    script.Parent = Converted["_CloseArea"]
    local req = require
    local require = function(obj)
        local routine = routine_module_scripts[obj]
        if routine then
            return routine()
        end
        return req(obj)
    end


	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	
	local menu = script.Parent.Parent
	local Spring = require(menu.Parent.Spring)
	local DraggableObject = require(menu.Parent.FUNCTIONS).DraggableObject
	local Bezier = require(menu.Parent.Bezier)
	
	-- Tween the TextLabel transparency
	--TweenService:Create(script.Parent.TextLabel, TweenInfo.new(20, Enum.EasingStyle.Linear), {
	--	TextTransparency = 1,
	--	BackgroundTransparency = 1
	--}):Play()
	
	local closed = false
	local springing = false
	local lastSpringActivity = os.clock()
	
	local closing
	
	local lastPos = UDim2.fromScale(0.5, 0.5)
	local closedLastPos = UDim2.fromScale(0.5, 0.1)
	
	-- Initialize springs for menu position and size
	local MenuPosXScale = Spring.new(0.7, 30, 160, menu.Position.X.Scale, 0, menu.Position.X.Scale)
	local MenuPosYScale = Spring.new(0.7, 45, 190, 0.05, 0, 0.05)
	local MenuPosXOffset = Spring.new(0.7, 30, 160, 0, 0)
	local MenuPosYOffset = Spring.new(0.7, 45, 190, 0, 0)
	local MenuSizeXOffset = Spring.new(1, 25, 120, menu.Size.X.Offset, 0, menu.Size.X.Offset)
	local MenuSizeYOffset = Spring.new(1, 25, 120, menu.Size.Y.Offset, 0, menu.Size.Y.Offset)
	
	local MenuRotation = Spring.new(1, 18, 100, menu.Rotation, 0, menu.Rotation)
	
	
	-- Functions to update spring goals and offsets
	local function setSpringPosGoal(udim2)
		springing = true
		lastSpringActivity = os.clock()
		MenuPosXScale:SetGoal(udim2.X.Scale)
		MenuPosYScale:SetGoal(udim2.Y.Scale)
		MenuPosXOffset:SetGoal(udim2.X.Offset)
		MenuPosYOffset:SetGoal(udim2.Y.Offset)
	end
	
	local function setSpringSizeGoal(udim2)
		springing = true
		lastSpringActivity = os.clock()
		MenuSizeXOffset:SetGoal(udim2.X.Offset)
		MenuSizeYOffset:SetGoal(udim2.Y.Offset)
	end
	
	-- Render step to update menu position and size based on spring values
	appRuntime.track(RunService.RenderStepped:Connect(function()
		if not appRuntime.alive or not menu.Parent then return end
		if springing then
			menu.Position = UDim2.new(MenuPosXScale.Offset, MenuPosXOffset.Offset, MenuPosYScale.Offset, MenuPosYOffset.Offset)
			menu.Size = UDim2.fromOffset(MenuSizeXOffset.Offset, MenuSizeYOffset.Offset)
			menu.Rotation = MenuRotation.Offset
			MenuRotation:SetGoal(0)
			if os.clock() - lastSpringActivity > 0.45
				and math.abs(MenuPosXScale.Offset - MenuPosXScale.Goal) < 0.0005
				and math.abs(MenuPosYScale.Offset - MenuPosYScale.Goal) < 0.0005
				and math.abs(MenuPosXOffset.Offset - MenuPosXOffset.Goal) < 0.25
				and math.abs(MenuPosYOffset.Offset - MenuPosYOffset.Goal) < 0.25
				and math.abs(MenuSizeXOffset.Offset - MenuSizeXOffset.Goal) < 0.25
				and math.abs(MenuSizeYOffset.Offset - MenuSizeYOffset.Goal) < 0.25 then
				springing = false
			end
		end
	end))
	
	-- Initialize draggable menu
	local MenuDrag = DraggableObject.new(script.Parent, menu, false, true)
	MenuDrag:Enable()
	
	local OpenerMenuDrag = DraggableObject.new(script.Parent.Parent.CanvasGroup.Opener, menu, false, true)
	OpenerMenuDrag:Enable()
	local OpenerDraggable = true
	
	textHidden = false
	
	
	-- Dragging behavior
	local deltaFrom = menu.Position
	MenuDrag.Dragged = function(pos)
		--if not textHidden then
		--	textHidden = true
		--	TweenService:Create(script.Parent.TextLabel, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
		--		TextTransparency = 1,
		--		BackgroundTransparency = 1
		--	}):Play()
		--end
		local delta = pos - deltaFrom
		deltaFrom = pos
		MenuRotation:SetGoal(delta.X.Offset * 0.5)
		setSpringPosGoal(pos)
		TweenService:Create(menu.UIScale, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			Scale = 0.95
		}):Play()
	end
	
	OpenerMenuDrag.Dragged = function(pos)
		if OpenerDraggable then
			closedLastPos = pos
			setSpringPosGoal(pos)
		end
	end
	
	script.Parent.MouseButton1Click:Connect(function()
		if not textHidden then
			textHidden = true
			TweenService:Create(script.Parent.TextLabel, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				TextTransparency = 1,
				BackgroundTransparency = 1
			}):Play()
		end
		TweenService:Create(menu, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			AnchorPoint = Vector2.new(0.5, 0.5)
		}):Play()
		springing = true
		setSpringPosGoal(closedLastPos)
		local buttonSize = getgenv().TIESAS_MENU_BUTTON_SIZE or 60
		setSpringSizeGoal(UDim2.fromOffset(buttonSize, buttonSize))
		--script.Parent.ZIndex = script.Parent.ZIndex - 2
		if not menu.Area:FindFirstChildWhichIsA("UICorner") then
			Instance.new("UICorner", menu.Area)
		end
		menu.Area:FindFirstChildWhichIsA("UICorner").CornerRadius = UDim.new(0, 16)
		task.spawn(function() task.wait(0.05) menu.List.Visible = false end)
		menu.CanvasGroup.Visible = true
		OpenerDraggable = true
		if closing then closing:Cancel() end
		TweenService:Create(menu.CanvasGroup, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			GroupTransparency = 0
		}):Play()
	end)
	
	MenuDrag.DragEnded = function(vel)
		TweenService:Create(
			menu.UIScale,
			TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
			{ Scale = 1 }
		):Play()
	
		if math.abs(vel.Y) > 10 then
			local thrownPosition = menu.Position
	
			if not textHidden then
				textHidden = true
				TweenService:Create(
					script.Parent.TextLabel,
					TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
					{
						TextTransparency = 1,
						BackgroundTransparency = 1
					}
				):Play()
			end
	
			TweenService:Create(
				menu,
				TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
				{ AnchorPoint = Vector2.new(0.5, 0.5) }
			):Play()
			
			local farPos = Vector3.new(thrownPosition.X.Offset + vel.X * 10, thrownPosition.Y.Offset + vel.Y * 10, 0)
	
			springing = true
			
			local bezierCurve = Bezier.new(
				Vector3.new(thrownPosition.X.Offset, thrownPosition.Y.Offset, 0),
				farPos,
				Vector3.new(closedLastPos.X.Offset, closedLastPos.Y.Offset, 0)
			)
			local points = bezierCurve:GetPath(0.5)
	
			--setSpringPosGoal(UDim2.new(closedLastPos.X.Scale, farPos.X, closedLastPos.Y.Scale, farPos.Y))
			setSpringPosGoal(UDim2.new(closedLastPos.X.Scale, points[math.ceil(#points/2)].X, closedLastPos.Y.Scale, points[math.ceil(#points/2)].Y))
			setSpringSizeGoal(UDim2.fromOffset(60 - vel.Y * 2, 60 - vel.Y * 2))
	
			task.wait(0.1)
	
			--task.spawn(function()
			--	for _, point in bezierCurve:GetPath(0.08) do
			--		setSpringPosGoal(UDim2.new(closedLastPos.X.Scale, point.X, closedLastPos.Y.Scale, point.Y))
			--		task.wait()
			--	end
			--end)
	
			local buttonSize = getgenv().TIESAS_MENU_BUTTON_SIZE or 60
			setSpringSizeGoal(UDim2.fromOffset(buttonSize, buttonSize))
			setSpringPosGoal(UDim2.new(closedLastPos.X.Scale, closedLastPos.X.Offset, closedLastPos.Y.Scale, closedLastPos.Y.Offset))
			menu.Area.UICorner.CornerRadius = UDim.new(0, 16)
			task.delay(0.25, function() menu.List.Visible = false end)
			menu.CanvasGroup.Visible = true
	
			OpenerDraggable = true
	
			if closing then closing:Cancel() end
	
			TweenService:Create(
				menu.CanvasGroup,
				TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
				{ GroupTransparency = 0 }
			):Play()
		else
			lastPos = menu.Position
		end
	end
	
	
	-- Opener button behavior
	local function sign(n) if n>0 then return 1 elseif n<0 then return -1 else return 0 end end
	local function openMenu()
		TweenService:Create(menu, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			AnchorPoint = Vector2.new(0.5, 0)
		}):Play()
	
		local bezierCurve = Bezier.new(
			Vector3.new(closedLastPos.X.Offset, closedLastPos.Y.Offset, 0),
			Vector3.new(
				(closedLastPos.X.Offset + lastPos.X.Offset) / 2,
				lastPos.Y.Offset + (math.abs(lastPos.Y.Offset - closedLastPos.Y.Offset) * 2.5 * -math.sign(closedLastPos.Y.Offset - lastPos.Y.Offset)),
				0
			),
			Vector3.new(lastPos.X.Offset, lastPos.Y.Offset, 0)
		)
	
		task.spawn(function()
			for _, point in bezierCurve:GetPath(0.2) do
				setSpringPosGoal(UDim2.new(closedLastPos.X.Scale, point.X, closedLastPos.Y.Scale, point.Y))
				task.wait() task.wait() -- 2 heartbeats uwu
			end
		end)
		--setSpringPosGoal(lastPos)
		setSpringSizeGoal(UDim2.fromOffset(441, 268))
		OpenerDraggable = false
		--script.Parent.ZIndex = script.Parent.ZIndex + 2
		menu.Area.UICorner.CornerRadius = UDim.new(0, 0)
		menu.List.Visible = true
		closing = TweenService:Create(menu.CanvasGroup, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			GroupTransparency = 1
		})
		closing:Play()
		closing.Completed:Once(function(state)
			menu.CanvasGroup.Visible = false
		end)
	end
	menu.CanvasGroup.Opener.MouseButton1Click:Connect(openMenu)
	appRuntime.track(UserInputService.InputBegan:Connect(function(inp, proc)
		if proc then return end
	
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) and inp.KeyCode == Enum.KeyCode.Y then
			openMenu()
		end
	end))
	
	
	
	script.Parent.AllowForSpring.Event:Wait()
	springing = true
end
local function KUFNO_routine() -- Routine: StarterGui.TIESAS.FloatingButtonSetting.ControlBarContainer.ControlBar.Visibility.LocalScript
    local script = Instance.new("LocalScript")
    script.Name = "LocalScript"
    script.Parent = Converted["_Visibility"]
    local req = require
    local require = function(obj)
        local routine = routine_module_scripts[obj]
        if routine then
            return routine()
        end
        return req(obj)
    end


	script.Parent.MouseButton1Click:Connect(function()
		getgenv().TIESASFUNCTIONS.ftToggleVisibility()
	end)
end
local function XLYNZG_routine() -- Routine: StarterGui.TIESAS.FloatingButtonSetting.ControlBarContainer.ControlBar.Lock.LocalScript
    local script = Instance.new("LocalScript")
    script.Name = "LocalScript"
    script.Parent = Converted["_Lock1"]
    local req = require
    local require = function(obj)
        local routine = routine_module_scripts[obj]
        if routine then
            return routine()
        end
        return req(obj)
    end


	script.Parent.MouseButton1Click:Connect(function()
		getgenv().TIESASFUNCTIONS.ftToggleLock()
	end)
end
local function XAPKH_routine() -- Routine: StarterGui.TIESAS.FloatingButtonSetting.ControlBarContainer.ControlBar.Exit.LocalScript
    local script = Instance.new("LocalScript")
    script.Name = "LocalScript"
    script.Parent = Converted["_Exit"]
    local req = require
    local require = function(obj)
        local routine = routine_module_scripts[obj]
        if routine then
            return routine()
        end
        return req(obj)
    end


	script.Parent.MouseButton1Click:Connect(function()
		getgenv().TIESASFUNCTIONS.closeFinetuneFB()
	end)
end

coroutine.wrap(DSZIHQM_routine)()
coroutine.wrap(XXZOB_routine)()
coroutine.wrap(AWDPHWS_routine)()
coroutine.wrap(KUFNO_routine)()
coroutine.wrap(XLYNZG_routine)()
coroutine.wrap(XAPKH_routine)()
