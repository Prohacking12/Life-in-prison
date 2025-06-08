local Services = require(script.Parent.Services)
local Utils = require(script.Parent.Utils)

local CombatFeatures = {
    LastTarget = nil
}

function CombatFeatures.getTarget()
    local myChar = Services.LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    local closest, shortestDistance = nil, Services.Config.MaxDistance
    local myPos = myChar.HumanoidRootPart.Position
    local enemies = Utils.getEnemyTeams()
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player ~= Services.LocalPlayer and (player.Team and table.find(enemies, player.Team.Name)) then
            local char = player.Character
            if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                local head = char:FindFirstChild("Head")
                if head then
                    local distance = (myPos - head.Position).Magnitude
                    if distance < shortestDistance then
                        local direction = (head.Position - Services.Camera.CFrame.Position).Unit
                        local angle = math.deg(math.acos(Services.Camera.CFrame.LookVector:Dot(direction)))
                        if angle < Services.Config.MaxAngle then
                            local raycastParams = RaycastParams.new()
                            raycastParams.FilterDescendantsInstances = {myChar}
                            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                            local ray = Services.Workspace:Raycast(Services.Camera.CFrame.Position, direction * Services.Config.MaxDistance, raycastParams)
                            if not ray or ray.Instance:IsDescendantOf(char) then
                                closest = head
                                shortestDistance = distance
                            end
                        end
                    end
                end
            end
        end
    end
    return closest
end

function CombatFeatures.initAimbot()
    Services.RunService.RenderStepped:Connect(function()
        if not Services.Config.AimbotEnabled then 
            CombatFeatures.LastTarget = nil
            return 
        end
        local target = CombatFeatures.getTarget()
        if target then
            if CombatFeatures.LastTarget and Services.Config.Smoothness > 0 then
                local currentCFrame = Services.Camera.CFrame
                local targetCFrame = CFrame.new(Services.Camera.CFrame.Position, target.Position)
                Services.Camera.CFrame = currentCFrame:Lerp(targetCFrame, 1 - Services.Config.Smoothness)
            else
                Services.Camera.CFrame = CFrame.new(Services.Camera.CFrame.Position, target.Position)
            end
            CombatFeatures.LastTarget = target
        else
            CombatFeatures.LastTarget = nil
        end
    end)
end

return CombatFeatures