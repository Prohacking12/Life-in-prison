local Services = require(script.Parent.Services)
local Utils = require(script.Parent.Utils)

local VisualFeatures = {
    EspCache = {},
    EspConnections = {},
    OriginalTransparency = {},
    XrayParts = {},
    OriginalLighting = {
        Brightness = Services.Lighting.Brightness,
        Ambient = Services.Lighting.Ambient,
        OutdoorAmbient = Services.Lighting.OutdoorAmbient
    }
}

function VisualFeatures.toggleEsp(enable)
    Services.Config.EspEnabled = enable
    if enable then
        for _, player in ipairs(Services.Players:GetPlayers()) do
            if player ~= Services.LocalPlayer then
                local character = player.Character or player.CharacterAdded:Wait()
                local humanoid = character:WaitForChild("Humanoid")
                local espGroup = Instance.new("Folder")
                espGroup.Name = player.Name .. "_ESP"
                espGroup.Parent = Services.LocalPlayer.PlayerGui
                local box = Instance.new("BoxHandleAdornment", espGroup)
                box.Name = "Box"
                box.Adornee = character:WaitForChild("HumanoidRootPart")
                box.AlwaysOnTop = true
                box.ZIndex = 10
                box.Size = Vector3.new(2, 3, 1)
                box.Transparency = 0.7
                box.Color3 = player.Team == Services.LocalPlayer.Team and Services.Config.Colors.espTeam or Services.Config.Colors.espEnemy
                VisualFeatures.EspCache[player] = espGroup
            end
        end
    else
        for player, _ in pairs(VisualFeatures.EspCache) do
            if VisualFeatures.EspCache[player] then
                VisualFeatures.EspCache[player]:Destroy()
                VisualFeatures.EspCache[player] = nil
            end
        end
    end
end

function VisualFeatures.toggleFullbright(enable)
    Services.Config.FullbrightEnabled = enable
    if enable then
        Services.Lighting.Brightness = 2
        Services.Lighting.Ambient = Color3.new(1, 1, 1)
        Services.Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    else
        Services.Lighting.Brightness = VisualFeatures.OriginalLighting.Brightness
        Services.Lighting.Ambient = VisualFeatures.OriginalLighting.Ambient
        Services.Lighting.OutdoorAmbient = VisualFeatures.OriginalLighting.OutdoorAmbient
    end
end

function VisualFeatures.toggleXray(enable)
    Services.Config.XrayEnabled = enable
    if enable then
        for _, part in ipairs(Services.Workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency < 0.5 then
                VisualFeatures.OriginalTransparency[part] = part.Transparency
                part.Transparency = 0.5
                if not part:FindFirstAncestorOfClass("Model") or not part:FindFirstAncestorOfClass("Model"):FindFirstChildOfClass("Humanoid") then
                    part.Color = Services.Config.Colors.xray
                    VisualFeatures.XrayParts[part] = true
                end
            end
        end
    else
        for part, transparency in pairs(VisualFeatures.OriginalTransparency) do
            if part:IsA("BasePart") then
                part.Transparency = transparency
                if VisualFeatures.XrayParts[part] then
                    part.Color = Color3.new(1, 1, 1)
                    VisualFeatures.XrayParts[part] = nil
                end
            end
        end
        VisualFeatures.OriginalTransparency = {}
        VisualFeatures.XrayParts = {}
    end
end

return VisualFeatures