local Aimbot = {}

-- Estado inicial
local enabled = false
local targetMode = "Closest"
local smoothing = 0 -- 0 = sin suavizado, >0 con suavizado

function Aimbot.SetEnabled(state)
    enabled = state
    print("[Aimbot] Estado:", enabled and "ON" or "OFF")
end

function Aimbot.IsEnabled()
    return enabled
end

function Aimbot.SetTargetMode(mode)
    if mode == "Closest" or mode == "LockOn" or mode == "Mouse" then
        targetMode = mode
        print("[Aimbot] Modo objetivo:", targetMode)
    else
        warn("[Aimbot] Modo objetivo inválido:", mode)
    end
end

function Aimbot.GetTargetMode()
    return targetMode
end

function Aimbot.SetSmoothing(value)
    smoothing = tonumber(value) or 0
    print("[Aimbot] Suavidad establecida a:", smoothing)
end

function Aimbot.GetSmoothing()
    return smoothing
end

-- Función para apuntar (simplificada, depende de implementación en el juego)
function Aimbot.AimAt(target)
    if not enabled then return end
    -- Aquí deberías implementar apuntado real
    -- Ejemplo: cambiar cámara hacia target con suavizado
end

return Aimbot
