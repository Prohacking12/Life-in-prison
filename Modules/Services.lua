local Config = require(script.Parent.Config)

return {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    Teams = game:GetService("Teams"),
    Workspace = game:GetService("Workspace"),
    UserInputService = game:GetService("UserInputService"),
    Lighting = game:GetService("Lighting"),
    LocalPlayer = game:GetService("Players").LocalPlayer,
    Camera = workspace.CurrentCamera,
    IsMobile = game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").KeyboardEnabled,
    Config = Config
}