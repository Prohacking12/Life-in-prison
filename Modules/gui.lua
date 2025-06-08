local GuiModule = {}

local Players = game:GetService("Players")
local player = Players.LocalPlayer

function GuiModule:CreateGUI(callbacks)
	local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
	gui.Name = "CompoundVHub"
	gui.ResetOnSpawn = false
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	-- Toggle "V" Button (centro izquierdo)
	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.new(0, 40, 0, 40)
	toggle.Position = UDim2.new(0, 10, 0.5, -20)
	toggle.BackgroundTransparency = 1
	toggle.Text = "V"
	toggle.TextColor3 = Color3.fromRGB(255, 0, 0)
	toggle.TextScaled = true
	toggle.Font = Enum.Font.Arcade
	toggle.Parent = gui
	toggle.ZIndex = 3

	-- Main GUI Frame
	local main = Instance.new("Frame")
	main.Size = UDim2.new(0, 600, 0, 400)
	main.Position = UDim2.new(0.5, -300, 0.5, -200)
	main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	main.BorderSizePixel = 0
	main.Visible = false
	main.Active = true
	main.Draggable = true
	main.Parent = gui

	toggle.MouseButton1Click:Connect(function()
		main.Visible = not main.Visible
	end)

	-- Left Panel (menú)
	local leftPanel = Instance.new("Frame", main)
	leftPanel.Size = UDim2.new(0, 200, 1, 0)
	leftPanel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	leftPanel.Position = UDim2.new(0, 0, 0, 0)

	-- Logo
	local logo = Instance.new("TextLabel", leftPanel)
	logo.Size = UDim2.new(1, 0, 0, 100)
	logo.Position = UDim2.new(0, 0, 0, 0)
	logo.Text = "COMPOUND V\nHUB"
	logo.TextColor3 = Color3.fromRGB(255, 0, 0)
	logo.Font = Enum.Font.SpecialElite
	logo.TextScaled = true
	logo.BackgroundTransparency = 1

	-- Right Panel
	local rightPanel = Instance.new("Frame", main)
	rightPanel.Position = UDim2.new(0, 200, 0, 0)
	rightPanel.Size = UDim2.new(1, -200, 1, 0)
	rightPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

	-- Botón Rápido Aimbot
	local aimQuick = Instance.new("TextButton", gui)
	aimQuick.Size = UDim2.new(0, 90, 0, 30)
	aimQuick.Position = UDim2.new(1, -100, 1, -100) -- Justo arriba del botón de salto
	aimQuick.AnchorPoint = Vector2.new(0, 1)
	aimQuick.Text = "aim:off"
	aimQuick.Font = Enum.Font.SourceSansBold
	aimQuick.TextScaled = true
	aimQuick.TextColor3 = Color3.fromRGB(255, 255, 255)
	aimQuick.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
	aimQuick.BorderSizePixel = 0

	local aimEnabled = false
	aimQuick.MouseButton1Click:Connect(function()
		aimEnabled = not aimEnabled
		aimQuick.Text = aimEnabled and "aim:on" or "aim:off"
		aimQuick.BackgroundColor3 = aimEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 0)
		if callbacks and callbacks.ToggleAimbot then
			callbacks.ToggleAimbot(aimEnabled)
		end
	end)

	-- Secciones y botones
	local sections = {
		Combat = {
			{"Toggle Aimbot", function()
				aimEnabled = not aimEnabled
				aimQuick.Text = aimEnabled and "aim:on" or "aim:off"
				if callbacks and callbacks.ToggleAimbot then
					callbacks.ToggleAimbot(aimEnabled)
				end
			end},
			{"Lock-On", function()
				if callbacks and callbacks.ToggleLock then
					callbacks.ToggleLock()
				end
			end},
			{"Aimbot Suavidad", function()
				if callbacks and callbacks.CycleSmoothness then
					callbacks.CycleSmoothness()
				end
			end},
		},
		Visual = {
			{"ESP", function()
				if callbacks and callbacks.ToggleESP then
					callbacks.ToggleESP()
				end
			end},
			{"X-Ray", function()
				if callbacks and callbacks.ToggleXRay then
					callbacks.ToggleXRay()
				end
			end},
			{"Fullbright", function()
				if callbacks and callbacks.ToggleFullbright then
					callbacks.ToggleFullbright()
				end
			end},
		},
		Config = {
			{"Prisoners", function()
				if callbacks and callbacks.SwitchTeam then
					callbacks.SwitchTeam("Prisoners")
				end
			end},
			{"Police", function()
				if callbacks and callbacks.SwitchTeam then
					callbacks.SwitchTeam("Police")
				end
			end},
			{"Criminals", function()
				if callbacks and callbacks.SwitchTeam then
					callbacks.SwitchTeam("Criminals")
				end
			end},
		}
	}

	local sectionButtons = {"Combat", "Visual", "Config"}
	local sectionFrames = {}

	for i, sectionName in ipairs(sectionButtons) do
		local btn = Instance.new("TextButton", leftPanel)
		btn.Size = UDim2.new(1, 0, 0, 50)
		btn.Position = UDim2.new(0, 0, 0, 100 + (i - 1) * 50)
		btn.Text = sectionName
		btn.Font = Enum.Font.SourceSansBold
		btn.TextScaled = true
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.BackgroundColor3 = Color3.fromRGB(90, 90, 90)

		-- Create section content
		local frame = Instance.new("Frame", rightPanel)
		frame.Size = UDim2.new(1, 0, 1, 0)
		frame.Position = UDim2.new(0, 0, 0, 0)
		frame.Visible = (i == 1) -- only Combat visible by default
		sectionFrames[sectionName] = frame

		local yOffset = 10
		for _, entry in ipairs(sections[sectionName]) do
			local b = Instance.new("TextButton", frame)
			b.Size = UDim2.new(0, 200, 0, 40)
			b.Position = UDim2.new(0, 10, 0, yOffset)
			b.Text = entry[1]
			b.Font = Enum.Font.SourceSans
			b.TextScaled = true
			b.TextColor3 = Color3.fromRGB(255, 255, 255)
			b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			b.MouseButton1Click:Connect(entry[2])
			yOffset = yOffset + 50
		end

		btn.MouseButton1Click:Connect(function()
			for name, f in pairs(sectionFrames) do
				f.Visible = (name == sectionName)
			end
		end)
	end

	-- Discord Info
	local discord = Instance.new("TextLabel", main)
	discord.Text = "discord: Burntrap10"
	discord.Font = Enum.Font.SourceSansBold
	discord.TextColor3 = Color3.fromRGB(0, 0, 255)
	discord.TextScaled = true
	discord.TextXAlignment = Enum.TextXAlignment.Left
	discord.Size = UDim2.new(0, 300, 0, 25)
	discord.Position = UDim2.new(0, 10, 1, -30)
	discord.BackgroundTransparency = 1

	return gui
end

return GuiModule
