local GuiModule = {}

local Players = game:GetService("Players")
local player = Players.LocalPlayer

function GuiModule:CreateUI(toggleCallback, quickToggleText, quickToggleCallback)
	local gui = Instance.new("ScreenGui")
	gui.Name = "CompoundVHub"
	gui.ResetOnSpawn = false
	gui.Parent = player:WaitForChild("PlayerGui")

	-- Botón "V" para abrir/cerrar GUI (arriba del botón de salto)
	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.new(0, 40, 0, 40)
	toggle.Position = UDim2.new(0.5, -20, 1, -120)
	toggle.BackgroundTransparency = 1
	toggle.Text = "V"
	toggle.TextColor3 = Color3.fromRGB(255, 0, 0)
	toggle.TextScaled = true
	toggle.Font = Enum.Font.Arcade
	toggle.ZIndex = 3
	toggle.Parent = gui

	-- Botón de activación rápida (justo arriba del botón de salto)
	local quickToggle = Instance.new("TextButton")
	quickToggle.Size = UDim2.new(0, 80, 0, 30)
	quickToggle.Position = UDim2.new(0.5, -40, 1, -160) -- unos 40px arriba del botón "V"
	quickToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	quickToggle.TextColor3 = Color3.new(1,1,1)
	quickToggle.TextScaled = true
	quickToggle.Font = Enum.Font.SourceSansBold
	quickToggle.Text = quickToggleText or "Toggle"
	quickToggle.ZIndex = 3
	quickToggle.Parent = gui

	quickToggle.MouseButton1Click:Connect(function()
		if quickToggleCallback then
			quickToggleCallback()
		end
	end)

	-- Main Frame
	local main = Instance.new("Frame")
	main.Size = UDim2.new(0, 600, 0, 400)
	main.Position = UDim2.new(0.5, -300, 0.5, -200)
	main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	main.BorderSizePixel = 0
	main.Visible = false
	main.Active = true
	main.Draggable = true
	main.Parent = gui

	-- Left Panel
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

	-- Secciones
	local sections = {
		Combat = function()
			toggleCallback("Combat")
		end,
		Visual = function()
			toggleCallback("Visual")
		end,
		Misc = function()
			toggleCallback("Misc")
		end
	}

	local i = 0
	for name, callback in pairs(sections) do
		local btn = Instance.new("TextButton", leftPanel)
		btn.Size = UDim2.new(1, 0, 0, 50)
		btn.Position = UDim2.new(0, 0, 0, 100 + i * 50)
		btn.Text = name
		btn.Font = Enum.Font.SourceSansBold
		btn.TextScaled = true
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
		btn.MouseButton1Click:Connect(callback)
		i += 1
	end

	-- Discord Label
	local discord = Instance.new("TextLabel", main)
	discord.Text = "discord: Burntrap10"
	discord.Font = Enum.Font.SourceSansBold
	discord.TextColor3 = Color3.fromRGB(0, 0, 255)
	discord.TextStrokeTransparency = 0
	discord.TextXAlignment = Enum.TextXAlignment.Left
	discord.TextScaled = true
	discord.Size = UDim2.new(0, 300, 0, 25)
	discord.Position = UDim2.new(0, 10, 1, -30)
	discord.BackgroundTransparency = 1

	-- Toggle visibility de la interfaz
	toggle.MouseButton1Click:Connect(function()
		main.Visible = not main.Visible
	end)

	return {
		Main = main,
		ToggleButton = toggle,
		QuickToggleButton = quickToggle,
		Sections = sections
	}
end

return GuiModule
