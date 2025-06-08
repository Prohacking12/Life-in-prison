local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Aimbot = {
    Enabled = false,
    Smoothness = 0.5,
    MaxDistance = 120,
    MaxAngle = 60,
    TargetMode = 1,
    LastTarget = nil,
}

local function getEnemyTeams()
    local mode = Aimbot.TargetMode
    local team = LocalPlayer.Team and LocalPlayer.Team.Name or ""
    if mode == 2 then return {"Police"} end
    if mode == 3 then return {"Prisoners", "Criminals"} end
    if team == "Police" then return {"Prisoners", "Criminals"} end
    return {"Police"}
end

function Aimbot.getTarget()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end

    local closest, shortestDistance = nil, Aimbot.MaxDistance
    local myPos = myChar.HumanoidRootPart.Position
    local enemies = getEnemyTeams()

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and (player.Team and table.find(enemies, player.Team.Name)) then
            local char = player.Character
            if char and char:FindFirstChild("Head") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                local head = char.Head
                local distance = (myPos - head.Position).Magnitude
                if distance < shortestDistance then
                    local dir = (head.Position - Camera.CFrame.Position).Unit
                    local angle = math.deg(math.acos(Camera.CFrame.LookVector:Dot(dir)))
                    if angle < Aimbot.MaxAngle then
                        local rayParams = RaycastParams.new()
                        rayParams.FilterDescendantsInstances = {myChar}
                        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                        local ray = Workspace:Raycast(Camera.CFrame.Position, dir * Aimbot.MaxDistance, rayParams)
                        if not ray or ray.Instance:IsDescendantOf(char) then
                            closest = head
                            shortestDistance = distance
                        end
                    end
                end
            end
        end
    end

    return closest
end

function Aimbot.init()
    RunService.RenderStepped:Connect(function()
        if not Aimbot.Enabled then 
            Aimbot.LastTarget = nil
            return
        end
        
        local target = Aimbot.getTarget()
        if target then
            local camCF = Camera.CFrame
            local targetCF = CFrame.new(Camera.CFrame.Position, target.Position)
            Camera.CFrame = camCF:Lerp(targetCF, 1 - Aimbot.Smoothness)
            Aimbot.LastTarget = target
        else
            Aimbot.LastTarget = nil
        end
    end)
end

return Aimbot