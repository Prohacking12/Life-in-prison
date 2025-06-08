local Services = require(script.Parent.Services)

local Utils = {}

function Utils.copyToClipboard(text)
    pcall(function() setclipboard(text) end)
end

function Utils.getEnemyTeams()
    if Services.Config.CurrentTargetMode == 2 then return {"Police"} end
    if Services.Config.CurrentTargetMode == 3 then return {"Prisoners", "Criminals"} end
    local team = Services.LocalPlayer.Team and Services.LocalPlayer.Team.Name or ""
    if team == "Police" then return {"Prisoners", "Criminals"} end
    if team == "Prisoners" or team == "Criminals" then return {"Police"} end
    return {}
end

function Utils.createButton(parent, text, order)
    local button = Instance.new("TextButton", parent)
    button.Size = UDim2.new(1, -10, 0, Services.Config.ButtonHeight)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.BackgroundColor3 = Services.Config.Colors.button
    button.TextColor3 = Services.Config.Colors.text
    button.Font = Enum.Font.GothamBold
    button.Text = text
    button.TextSize = 16
    button.AutoButtonColor = false
    button.BorderSizePixel = 0
    button.LayoutOrder = order
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.35)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Services.Config.Colors.button
    end)
    return button
end

return Utils