local Services = require(script.Parent.Services)
local Utils = require(script.Parent.Utils)
local CombatFeatures = require(script.Parent.CombatFeatures)
local VisualFeatures = require(script.Parent.VisualFeatures)

local UI = {}

function UI.createMainGUI()
    local gui = Instance.new("ScreenGui", Services.LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = "GunpowderScriptUI"
    gui.ResetOnSpawn = false
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, Services.Config.PanelWidth, 0, Services.Config.PanelHeight)
    frame.Position = UDim2.new(0.5, -Services.Config.PanelWidth/2, 0.5, -Services.Config.PanelHeight/2)
    frame.BackgroundColor3 = Services.Config.Colors.background
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Visible = Services.Config.PanelVisible
    frame.ClipsDescendants = true
    local header = Instance.new("TextLabel", frame)
    header.Size = UDim2.new(1, 0, 0, 50)
    header.BackgroundColor3 = Services.Config.Colors.header
    header.TextColor3 = Services.Config.Colors.text
    header.Font = Enum.Font.GothamBold
    header.Text = "💥 GUNPOWDER SCRIPT"
    header.TextSize = 18
    header.TextXAlignment = Enum.TextXAlignment.Center
    local tabContainer = Instance.new("Frame", frame)
    tabContainer.Size = UDim2.new(1, 0, 0, Services.Config.TabHeight)
    tabContainer.Position = UDim2.new(0, 0, 0, 50)
    tabContainer.BackgroundTransparency = 1
    local combatTab = Instance.new("TextButton", tabContainer)
    combatTab.Size = UDim2.new(0.5, 0, 1, 0)
    combatTab.Position = UDim2.new(0, 0, 0, 0)
    combatTab.BackgroundColor3 = Services.Config.Colors.tabActive
    combatTab.TextColor3 = Services.Config.Colors.text
    combatTab.Font = Enum.Font.GothamBold
    combatTab.Text = "COMBATE"
    combatTab.TextSize = 14
    combatTab.BorderSizePixel = 0
    local visualTab = Instance.new("TextButton", tabContainer)
    visualTab.Size = UDim2.new(0.5, 0, 1, 0)
    visualTab.Position = UDim2.new(0.5, 0, 0, 0)
    visualTab.BackgroundColor3 = Services.Config.Colors.tabInactive
    visualTab.TextColor3 = Services.Config.Colors.text
    visualTab.Font = Enum.Font.GothamBold
    visualTab.Text = "VISUAL"
    visualTab.TextSize = 14
    visualTab.BorderSizePixel = 0
    local tabContent = Instance.new("Frame", frame)
    tabContent.Size = UDim2.new(1, 0, 1, -(50 + Services.Config.TabHeight))
    tabContent.Position = UDim2.new(0, 0, 0, 50 + Services.Config.TabHeight)
    tabContent.BackgroundTransparency = 1
    local combatContainer = Instance.new("ScrollingFrame", tabContent)
    combatContainer.Size = UDim2.new(1, 0, 1, 0)
    combatContainer.BackgroundTransparency = 1
    combatContainer.ScrollBarThickness = 5
    combatContainer.Visible = true
    combatContainer.Name = "CombatContainer"
    local combatLayout = Instance.new("UIListLayout", combatContainer)
    combatLayout.Padding = UDim.new(0, 10)
    combatLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        combatContainer.CanvasSize = UDim2.new(0, 0, 0, combatLayout.AbsoluteContentSize.Y + 10)
    end)
    local visualContainer = Instance.new("ScrollingFrame", tabContent)
    visualContainer.Size = UDim2.new(1, 0, 1, 0)
    visualContainer.BackgroundTransparency = 1
    visualContainer.ScrollBarThickness = 5
    visualContainer.Visible = false
    visualContainer.Name = "VisualContainer"
    local visualLayout = Instance.new("UIListLayout", visualContainer)
    visualLayout.Padding = UDim.new(0, 10)
    visualLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        visualContainer.CanvasSize = UDim2.new(0, 0, 0, visualLayout.AbsoluteContentSize.Y + 10)
    end)
    local aimbotBtn = Utils.createButton(combatContainer, "AIMBOT: OFF", 1)
    local targetBtn = Utils.createButton(combatContainer, "OBJETIVO: AUTOMÁTICO", 2)
    local distanceBtn = Utils.createButton(combatContainer, "DISTANCIA: "..Services.Config.MaxDistance, 3)
    local smoothBtn = Utils.createButton(combatContainer, "SUAVIDAD: "..Services.Config.Smoothness, 4)
    local discordBtn = Utils.createButton(combatContainer, "COPIAR DISCORD", 5)
    discordBtn.BackgroundColor3 = Services.Config.Colors.discordButton
    local espBtn = Utils.createButton(visualContainer, "ESP: OFF", 1)
    local fullbrightBtn = Utils.createButton(visualContainer, "FULLBRIGHT: OFF", 2)
    local xrayBtn = Utils.createButton(visualContainer, "XRAY: OFF", 3)
    local espSettingsBtn = Utils.createButton(visualContainer, "CONFIGURACIÓN ESP", 4)
    local toggleBtn = Instance.new("TextButton", gui)
    toggleBtn.Size = UDim2.new(0, 150, 0, 40)
    toggleBtn.Position = UDim2.new(0, 10, 1, -50)
    toggleBtn.BackgroundColor3 = Services.Config.Colors.header
    toggleBtn.TextColor3 = Services.Config.Colors.text
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Text = "ABRIR MENÚ"
    toggleBtn.TextSize = 16
    toggleBtn.AutoButtonColor = false
    toggleBtn.BorderSizePixel = 0
    return {
        Gui = gui,
        Frame = frame,
        Header = header,
        CombatTab = combatTab,
        VisualTab = visualTab,
        CombatContainer = combatContainer,
        VisualContainer = visualContainer,
        AimbotBtn = aimbotBtn,
        TargetBtn = targetBtn,
        DistanceBtn = distanceBtn,
        SmoothBtn = smoothBtn,
        DiscordBtn = discordBtn,
        EspBtn = espBtn,
        FullbrightBtn = fullbrightBtn,
        XrayBtn = xrayBtn,
        EspSettingsBtn = espSettingsBtn,
        ToggleBtn = toggleBtn
    }
end

function UI.initButtonEvents(uiElements)
    uiElements.AimbotBtn.MouseButton1Click:Connect(function()
        Services.Config.AimbotEnabled = not Services.Config.AimbotEnabled
        uiElements.AimbotBtn.Text = "AIMBOT: " .. (Services.Config.AimbotEnabled and "ON" or "OFF")
        uiElements.AimbotBtn.BackgroundColor3 = Services.Config.AimbotEnabled and Services.Config.Colors.buttonActive or Services.Config.Colors.button
    end)
    uiElements.TargetBtn.MouseButton1Click:Connect(function()
        Services.Config.CurrentTargetMode = Services.Config.CurrentTargetMode % #Services.Config.TargetModes + 1
        uiElements.TargetBtn.Text = "OBJETIVO: " .. Services.Config.TargetModes[Services.Config.CurrentTargetMode]
    end)
    uiElements.DistanceBtn.MouseButton1Click:Connect(function()
        Services.Config.MaxDistance = Services.Config.MaxDistance == 120 and 200 or Services.Config.MaxDistance == 200 and 300 or 120
        uiElements.DistanceBtn.Text = "DISTANCIA: "..Services.Config.MaxDistance
    end)
    uiElements.SmoothBtn.MouseButton1Click:Connect(function()
        Services.Config.Smoothness = Services.Config.Smoothness == 0.5 and 0.8 or Services.Config.Smoothness == 0.8 and 0.2 or 0.5
        uiElements.SmoothBtn.Text = "SUAVIDAD: "..Services.Config.Smoothness
    end)
    uiElements.EspBtn.MouseButton1Click:Connect(function()
        Services.Config.EspEnabled = not Services.Config.EspEnabled
        uiElements.EspBtn.Text = "ESP: " .. (Services.Config.EspEnabled and "ON" or "OFF")
        uiElements.EspBtn.BackgroundColor3 = Services.Config.EspEnabled and Services.Config.Colors.buttonActive or Services.Config.Colors.button
        VisualFeatures.toggleEsp(Services.Config.EspEnabled)
    end)
    uiElements.FullbrightBtn.MouseButton1Click:Connect(function()
        Services.Config.FullbrightEnabled = not Services.Config.FullbrightEnabled
        uiElements.FullbrightBtn.Text = "FULLBRIGHT: " .. (Services.Config.FullbrightEnabled and "ON" or "OFF")
        uiElements.FullbrightBtn.BackgroundColor3 = Services.Config.FullbrightEnabled and Services.Config.Colors.buttonActive or Services.Config.Colors.button
        VisualFeatures.toggleFullbright(Services.Config.FullbrightEnabled)
    end)
    uiElements.XrayBtn.MouseButton1Click:Connect(function()
        Services.Config.XrayEnabled = not Services.Config.XrayEnabled
        uiElements.XrayBtn.Text = "XRAY: " .. (Services.Config.XrayEnabled and "ON" or "OFF")
        uiElements.XrayBtn.BackgroundColor3 = Services.Config.XrayEnabled and Services.Config.Colors.buttonActive or Services.Config.Colors.button
        VisualFeatures.toggleXray(Services.Config.XrayEnabled)
    end)
    uiElements.EspSettingsBtn.MouseButton1Click:Connect(function()
        local settingsFrame = Instance.new("Frame", uiElements.Gui)
        settingsFrame.Size = UDim2.new(0, 250, 0, 250)
        settingsFrame.Position = UDim2.new(0.5, -125, 0.5, -125)
        settingsFrame.BackgroundColor3 = Services.Config.Colors.background
        settingsFrame.BorderSizePixel = 0
        settingsFrame.ZIndex = 10
        local title = Instance.new("TextLabel", settingsFrame)
        title.Size = UDim2.new(1, 0, 0, 40)
        title.BackgroundColor3 = Services.Config.Colors.header
        title.TextColor3 = Services.Config.Colors.text
        title.Font = Enum.Font.GothamBold
        title.Text = "CONFIGURACIÓN ESP"
        title.TextSize = 18
        title.TextXAlignment = Enum.TextXAlignment.Center
        local closeBtn = Instance.new("TextButton", settingsFrame)
        closeBtn.Size = UDim2.new(0, 30, 0, 30)
        closeBtn.Position = UDim2.new(1, -30, 0, 0)
        closeBtn.BackgroundColor3 = Services.Config.Colors.closeButton
        closeBtn.TextColor3 = Services.Config.Colors.text
        closeBtn.Font = Enum.Font.GothamBold
        closeBtn.Text = "X"
        closeBtn.TextSize = 16
        closeBtn.MouseButton1Click:Connect(function() settingsFrame:Destroy() end)
        local container = Instance.new("ScrollingFrame", settingsFrame)
        container.Size = UDim2.new(1, 0, 1, -40)
        container.Position = UDim2.new(0, 0, 0, 40)
        container.BackgroundTransparency = 1
        container.ScrollBarThickness = 5
        local layout = Instance.new("UIListLayout", container)
        layout.Padding = UDim.new(0, 10)
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            container.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
        end)
        local function createSetting(text, property, order)
            local frame = Instance.new("Frame", container)
            frame.Size = UDim2.new(1, -20, 0, 30)
            frame.Position = UDim2.new(0, 10, 0, 0)
            frame.BackgroundTransparency = 1
            frame.LayoutOrder = order
            local label = Instance.new("TextLabel", frame)
            label.Size = UDim2.new(0.6, 0, 1, 0)
            label.Text = text
            label.TextColor3 = Services.Config.Colors.text
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.BackgroundTransparency = 1
            local toggle = Instance.new("TextButton", frame)
            toggle.Size = UDim2.new(0.4, 0, 1, 0)
            toggle.Position = UDim2.new(0.6, 0, 0, 0)
            toggle.Text = Services.Config.EspSettings[property] and "ON" or "OFF"
            toggle.TextColor3 = Services.Config.Colors.text
            toggle.Font = Enum.Font.GothamBold
            toggle.TextSize = 14
            toggle.BackgroundColor3 = Services.Config.EspSettings[property] and Services.Config.Colors.buttonActive or Services.Config.Colors.button
            toggle.MouseButton1Click:Connect(function()
                Services.Config.EspSettings[property] = not Services.Config.EspSettings[property]
                toggle.Text = Services.Config.EspSettings[property] and "ON" or "OFF"
                toggle.BackgroundColor3 = Services.Config.EspSettings[property] and Services.Config.Colors.buttonActive or Services.Config.Colors.button
            end)
        end
        createSetting("Mostrar caja", "box", 1)
        createSetting("Mostrar nombre", "name", 2)
        createSetting("Mostrar salud", "health", 3)
        createSetting("Color por equipo", "teamColor", 4)
        createSetting("Contorno de texto", "textOutline", 5)
    end)
    uiElements.DiscordBtn.MouseButton1Click:Connect(function()
        Utils.copyToClipboard(Services.Config.DiscordLink)
        uiElements.DiscordBtn.Text = "¡COPIADO!"
        task.wait(1.5)
        uiElements.DiscordBtn.Text = "COPIAR DISCORD"
    end)
    uiElements.ToggleBtn.MouseButton1Click:Connect(function()
        Services.Config.PanelVisible = not Services.Config.PanelVisible
        uiElements.Frame.Visible = Services.Config.PanelVisible
        uiElements.ToggleBtn.Text = Services.Config.PanelVisible and "CERRAR MENÚ" or "ABRIR MENÚ"
    end)
    uiElements.CombatTab.MouseButton1Click:Connect(function()
        Services.Config.CurrentTab = "combat"
        uiElements.CombatContainer.Visible = true
        uiElements.VisualContainer.Visible = false
        uiElements.CombatTab.BackgroundColor3 = Services.Config.Colors.tabActive
        uiElements.VisualTab.BackgroundColor3 = Services.Config.Colors.tabInactive
    end)
    uiElements.VisualTab.MouseButton1Click:Connect(function()
        Services.Config.CurrentTab = "visual"
        uiElements.CombatContainer.Visible = false
        uiElements.VisualContainer.Visible = true
        uiElements.CombatTab.BackgroundColor3 = Services.Config.Colors.tabInactive
        uiElements.VisualTab.BackgroundColor3 = Services.Config.Colors.tabActive
    end)
end

function UI.createMobileQuickButton(uiElements)
    if Services.IsMobile then
        local quickBtn = Instance.new("TextButton", uiElements.Gui)
        quickBtn.Size = UDim2.new(0, 70, 0, 70)
        quickBtn.Position = UDim2.new(1, -80, 1, -160)
        quickBtn.BackgroundColor3 = Services.Config.Colors.header
        quickBtn.TextColor3 = Services.Config.Colors.text
        quickBtn.Text = "AIM"
        quickBtn.Font = Enum.Font.GothamBold
        quickBtn.TextSize = 16
        quickBtn.AutoButtonColor = false
        quickBtn.BorderSizePixel = 0
        quickBtn.MouseButton1Click:Connect(function()
            Services.Config.AimbotEnabled = not Services.Config.AimbotEnabled
            quickBtn.Text = Services.Config.AimbotEnabled and "ON" or "OFF"
            quickBtn.BackgroundColor3 = Services.Config.AimbotEnabled and Services.Config.Colors.buttonActive or Services.Config.Colors.header
            uiElements.AimbotBtn.Text = "AIMBOT: " .. (Services.Config.AimbotEnabled and "ON" or "OFF")
            uiElements.AimbotBtn.BackgroundColor3 = Services.Config.AimbotEnabled and Services.Config.Colors.buttonActive or Services.Config.Colors.button
        end)
    end
end

return UI
