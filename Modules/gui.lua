local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local GuiModule = {}

local states = {
    Aimbot = false,
    ESP = false,
    Fullbright = false,
    XRay = false,
    SmoothAim = false,
    KillAura = false,
    FastHeal = false,
    TargetModeIndex = 1,
    TeamIndex = 1,
}

local targetModes = {"Closest", "LockOn", "Mouse"}
local teams = {"Prisoners", "Police", "Criminals"}

local function setButtonState(btn, state)
    btn.TextColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    btn.Text = btn.Name .. ": " .. (state and "ON" or "OFF")
end

local function setTextButton(btn, text)
    btn.Text = text
end

function GuiModule.CreateGui(Callbacks)
    local gui = Instance.new("ScreenGui")
    gui.Name = "CompoundVHub"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    -- Botón "V" para abrir/cerrar GUI
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 40, 0, 40)
    toggleBtn.Position = UDim2.new(0, 10, 0.5, -20)
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Text = "V"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
    toggleBtn.TextScaled = true
    toggleBtn.Font = Enum.Font.Arcade
    toggleBtn.ZIndex = 5
    toggleBtn.Parent = gui

    -- Panel principal
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 600, 0, 400)
    main.Position = UDim2.new(0.5, -300, 0.5, -200)
    main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    main.BorderSizePixel = 0
    main.Visible = false
    main.Active = true
    main.ZIndex = 4
    main.Parent = gui

    -- Arrastrar panel
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- Panel izquierdo menú
    local leftPanel = Instance.new("Frame")
    leftPanel.Size = UDim2.new(0, 200, 1, 0)
    leftPanel.Position = UDim2.new(0, 0, 0, 0)
    leftPanel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    leftPanel.Parent = main

    local sections = {"Combat", "Visual", "Configuration"}
    local buttons = {}
    local activeSection = "Combat"

    for i, sec in ipairs(sections) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 50)
        btn.Position = UDim2.new(0, 0, 0, 50 * (i - 1))
        btn.Text = sec
        btn.Font = Enum.Font.SourceSansBold
        btn.TextScaled = true
        btn.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Parent = leftPanel
        buttons[sec] = btn
    end

    local contentPanel = Instance.new("Frame")
    contentPanel.Size = UDim2.new(1, -200, 1, 0)
    contentPanel.Position = UDim2.new(0, 200, 0, 0)
    contentPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    contentPanel.Parent = main

    local containers = {}
    for _, sec in ipairs(sections) do
        local cont = Instance.new("ScrollingFrame")
        cont.Size = UDim2.new(1, 0, 1, 0)
        cont.BackgroundTransparency = 1
        cont.ScrollBarThickness = 6
        cont.Visible = false
        cont.Parent = contentPanel
        containers[sec] = cont
    end

    containers[activeSection].Visible = true
    buttons[activeSection].BackgroundColor3 = Color3.fromRGB(150, 0, 0)

    for sec, btn in pairs(buttons) do
        btn.MouseButton1Click:Connect(function()
            if sec ~= activeSection then
                containers[activeSection].Visible = false
                buttons[activeSection].BackgroundColor3 = Color3.fromRGB(90, 90, 90)

                activeSection = sec

                containers[activeSection].Visible = true
                buttons[activeSection].BackgroundColor3 = Color3.fromRGB(150, 0, 0)
            end
        end)
    end

    local function createToggleButton(parent, name, initialState, onToggle)
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Size = UDim2.new(1, -20, 0, 40)
        btn.Position = UDim2.new(0, 10, 0, 0)
        btn.Font = Enum.Font.SourceSansBold
        btn.TextScaled = true
        btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        btn.TextColor3 = initialState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        btn.Text = name .. ": " .. (initialState and "ON" or "OFF")
        btn.Parent = parent

        btn.MouseButton1Click:Connect(function()
            local newState = not states[name]
            states[name] = newState
            setButtonState(btn, newState)
            if onToggle then onToggle(newState) end
        end)

        return btn
    end

    local function createTextButton(parent, name, text, onClick)
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Size = UDim2.new(1, -20, 0, 40)
        btn.Font = Enum.Font.SourceSansBold
        btn.TextScaled = true
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Text = text
        btn.Position = UDim2.new(0, 10, 0, 0)
        btn.Parent = parent

        if onClick then
            btn.MouseButton1Click:Connect(onClick)
        end

        return btn
    end

    -- Combat tab content
    do
        local parent = containers["Combat"]
        local y = 10
        local spacing = 50

        local function addBtn(name, stateName)
            local btn = createToggleButton(parent, name, states[stateName], function(state)
                if Callbacks and Callbacks["Toggle" .. name] then
                    Callbacks["Toggle" .. name](state)
                end
            end)
            btn.Position = UDim2.new(0, 10, 0, y)
            y = y + spacing
            return btn
        end

        addBtn("Aimbot", "Aimbot")
        addBtn("KillAura", "KillAura")
        addBtn("FastHeal", "FastHeal")

        -- Selector objetivo
        local targetModeBtn = createTextButton(parent, "TargetMode", "Target Mode: " .. targetModes[states.TargetModeIndex], function()
            states.TargetModeIndex = states.TargetModeIndex % #targetModes + 1
            targetModeBtn.Text = "Target Mode: " .. targetModes[states.TargetModeIndex]
            if Callbacks and Callbacks.OnTargetModeChanged then
                Callbacks.OnTargetModeChanged(targetModes[states.TargetModeIndex])
            end
        end)
        targetModeBtn.Position = UDim2.new(0, 10, 0, y)
        y = y + spacing

        -- Selector equipo
        local teamBtn = createTextButton(parent, "TeamSelector", "Team: " .. teams[states.TeamIndex], function()
            states.TeamIndex = states.TeamIndex % #teams + 1
            teamBtn.Text = "Team: " .. teams[states.TeamIndex]
            if Callbacks and Callbacks.OnTeamChanged then
                Callbacks.OnTeamChanged(teams[states.TeamIndex])
            end
        end)
        teamBtn.Position = UDim2.new(0, 10, 0, y)
        y = y + spacing
    end

    -- Visual tab content
    do
        local parent = containers["Visual"]
        local y = 10
        local spacing = 50

        local function addBtn(name, stateName)
            local btn = createToggleButton(parent, name, states[stateName], function(state)
                if Callbacks and Callbacks["Toggle" .. name] then
                    Callbacks["Toggle" .. name](state)
                end
            end)
            btn.Position = UDim2.new(0, 10, 0, y)
            y = y + spacing
            return btn
        end

        addBtn("ESP", "ESP")
        addBtn("Fullbright", "Fullbright")
        addBtn("XRay", "XRay")
        addBtn("SmoothAim", "SmoothAim")
    end

    -- Configuration tab content
    do
        local parent = containers["Configuration"]
        local y = 10
        local spacing = 50

        -- Aquí puedes agregar botones o sliders de configuración extra si quieres
        local infoLabel = Instance.new("TextLabel")
        infoLabel.Size = UDim2.new(1, -20, 0, 100)
        infoLabel.Position = UDim2.new(0, 10, 0, y)
        infoLabel.BackgroundTransparency = 1
        infoLabel.TextColor3 = Color3.new(1,1,1)
        infoLabel.TextWrapped = true
        infoLabel.Text = "CompoundVHub - Versión 1.0\nDesarrollado por ChatGPT\n\nModular y listo para integrar."
        infoLabel.Font = Enum.Font.SourceSansItalic
        infoLabel.TextScaled = true
        infoLabel.Parent = parent
    end

    toggleBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
    end)

    return gui, states
end

return GuiModule
