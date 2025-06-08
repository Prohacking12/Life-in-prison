local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Visual = {
    ESPEnabled = false,
    XRayEnabled = false,
    FullbrightEnabled = false,
    Billboards = {}
}

function Visual.enableFullbright()
    Lighting.Brightness = 2
    Lighting.ClockTime = 12
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
end

function Visual.enableXRay()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Transparency < 1 then
            v.LocalTransparencyModifier = 0.7
        end
    end
end

function Visual.updateESP()
    for _, b in pairs(Visual.Billboards) do b:Destroy() end
    table.clear(Visual.Billboards)

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local billboard = Instance.new("BillboardGui", player.Character.Head)
            billboard.Size = UDim2.new(0, 100, 0, 40)
            billboard.AlwaysOnTop = true
            billboard.StudsOffset = Vector3.new(0, 2, 0)
            local text = Instance.new("TextLabel", billboard)
            text.Size = UDim2.new(1, 0, 1, 0)
            text.BackgroundTransparency = 1
            text.TextColor3 = Color3.fromRGB(255, 50, 50)
            text.Font = Enum.Font.GothamBold
            text.TextSize = 14
            local hp = player.Character:FindFirstChild("Humanoid")
            text.Text = player.Name .. (hp and (" | " .. math.floor(hp.Health)) or "")
            Visual.Billboards[#Visual.Billboards+1] = billboard
        end
    end
end

function Visual.init()
    RunService.RenderStepped:Connect(function()
        if Visual.FullbrightEnabled then Visual.enableFullbright() end
        if Visual.XRayEnabled then Visual.enableXRay() end
        if Visual.ESPEnabled then Visual.updateESP() end
    end)
end

return Visual