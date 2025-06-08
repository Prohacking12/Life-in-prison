local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "GunpowderScriptUI"

local button = Instance.new("TextButton", ScreenGui)
button.Size = UDim2.new(0, 100, 0, 40)
button.Position = UDim2.new(0.5, -50, 0.85, 0)
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Text = "Aimbot: OFF"
button.Font = Enum.Font.GothamBold
button.TextSize = 14

local gui = {}

function gui.init(aimbot, visual)
    button.MouseButton1Click:Connect(function()
        aimbot.Enabled = not aimbot.Enabled
        button.Text = aimbot.Enabled and "Aimbot: ON" or "Aimbot: OFF"
        button.BackgroundColor3 = aimbot.Enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)
    end)
end

return gui
