local GuiModule = {}

-- Helper para crear botones toggle
local function CreateToggleButton(text, parent, onToggle, initialState)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 120, 0, 40)
    button.BackgroundColor3 = initialState and Color3.fromRGB(30,200,30) or Color3.fromRGB(200,30,30)
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.SourceSansBold
    button.TextScaled = true
    button.Text = text .. (initialState and ": ON" or ": OFF")
    button.Parent = parent

    local state = initialState or false

    button.MouseButton1Click:Connect(function()
        local result = onToggle()
        if type(result) == "boolean" then
            state = result
        else
            state = not state
        end
        button.BackgroundColor3 = state and Color3.fromRGB(30,200,30) or Color3.fromRGB(200,30,30)
        button.Text = text .. (state and ": ON" or ": OFF")
    end)

    local function Update(newState)
        state = newState
        button.BackgroundColor3 = state and Color3.fromRGB(30,200,30) or Color3.fromRGB(200,30,30)
        button.Text = text .. (state and ": ON" or ": OFF")
    end

    return button, Update
end

-- Botón selector que cicla opciones
local function CreateCycleButton(text, options, parent, onCycle, initialIndex)
    local index = initialIndex or 1
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 140, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(70,70,70)
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.SourceSansBold
    button.TextScaled = true
    button.Text = text .. ": " .. options[index]
    button.Parent = parent

    button.MouseButton1Click:Connect(function()
        index = index + 1
        if index > #options then index = 1 end
        button.Text = text .. ": " .. options[index]
        if onCycle then
            onCycle(options[index])
        end
    end)

    local function Update(newIndex)
        if newIndex and options[newIndex] then
            index = newIndex
            button.Text = text .. ": " .. options[index]
        end
    end

    return button, Update
end

function GuiModule:CreateGUI(callbacks, initialState)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CompoundVHub"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")

    local openButton = Instance.new("TextButton")
    openButton.Name = "OpenButton"
    openButton.Size = UDim2.new(0, 40, 0, 40)
    openButton.Position = UDim2.new(0, 0, 0.5, -20)
    openButton.AnchorPoint = Vector2.new(0,0.5)
    openButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
    openButton.TextColor3 = Color3.new(1,1,1)
    openButton.Font = Enum.Font.SourceSansBold
    openButton.Text = "V"
    openButton.Parent = screenGui

    local panel = Instance.new("Frame")
    panel.Name = "MainPanel"
    panel.Size = UDim2.new(0, 300, 0, 400)
    panel.Position = UDim2.new(0, 40, 0.5, -200)
    panel.AnchorPoint = Vector2.new(0,0.5)
    panel.BackgroundColor3 = Color3.fromRGB(30,30,30)
    panel.Visible = false
    panel.Parent = screenGui

    local dragging = false
    local dragInput
    local dragStart
    local startPos

    panel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = panel.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    panel.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    openButton.MouseButton1Click:Connect(function()
        panel.Visible = not panel.Visible
    end)

    local combatTab = Instance.new("Frame")
    combatTab.Name = "CombatTab"
    combatTab.Size = UDim2.new(1, 0, 1, 0)
    combatTab.BackgroundTransparency = 1
    combatTab.Parent = panel

    local aimbotBtn, updateAimbotBtn = CreateToggleButton("Aimbot", combatTab, callbacks.ToggleAimbot, initialState.aimbot)
    aimbotBtn.Position = UDim2.new(0, 10, 0, 10)

    local espBtn, updateESPBtn = CreateToggleButton("ESP", combatTab, callbacks.ToggleESP, initialState.esp)
    espBtn.Position = UDim2.new(0, 10, 0, 60)

    local fullbrightBtn, updateFullbrightBtn = CreateToggleButton("Fullbright", combatTab, callbacks.ToggleFullbright, initialState.fullbright)
    fullbrightBtn.Position = UDim2.new(0, 10, 0, 110)

    local xrayBtn, updateXRayBtn = CreateToggleButton("XRay", combatTab, callbacks.ToggleXRay, initialState.xray)
    xrayBtn.Position = UDim2.new(0, 10, 0, 160)

    local targetBtn, updateTargetBtn = CreateCycleButton("Target", {"Closest", "LockOn", "Mouse"}, combatTab, callbacks.CycleTarget, initialState.currentTargetIndex)
    targetBtn.Position = UDim2.new(0, 10, 0, 210)

    -- Guardar referencias para actualizar botones desde fuera
    self._updateAimbotBtn = updateAimbotBtn
    self._updateESPBtn = updateESPBtn
    self._updateFullbrightBtn = updateFullbrightBtn
    self._updateXRayBtn = updateXRayBtn
    self._updateTargetBtn = updateTargetBtn

    -- Función para actualizar el botón Aimbot desde fuera (ej: botón rápido)
    function GuiModule.UpdateAimbotButton(newState)
        if GuiModule._updateAimbotBtn then
            GuiModule._updateAimbotBtn(newState)
        end
    end

    return GuiModule
end

return GuiModule
