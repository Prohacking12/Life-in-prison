local Visual = {}

local espEnabled = false
local fullbrightEnabled = false
local xrayEnabled = false

function Visual.ToggleESP(state)
    espEnabled = not espEnabled
    if type(state) == "boolean" then espEnabled = state end
    print("[Visual] ESP:", espEnabled and "ON" or "OFF")
    -- Aquí va código para activar/desactivar ESP real
    return espEnabled
end

function Visual.ToggleFullbright(state)
    fullbrightEnabled = not fullbrightEnabled
    if type(state) == "boolean" then fullbrightEnabled = state end
    print("[Visual] Fullbright:", fullbrightEnabled and "ON" or "OFF")
    -- Aquí código Fullbright
    return fullbrightEnabled
end

function Visual.ToggleXRay(state)
    xrayEnabled = not xrayEnabled
    if type(state) == "boolean" then xrayEnabled = state end
    print("[Visual] XRay:", xrayEnabled and "ON" or "OFF")
    -- Aquí código XRay
    return xrayEnabled
end

function Visual.IsESPEnabled()
    return espEnabled
end

function Visual.IsFullbrightEnabled()
    return fullbrightEnabled
end

function Visual.IsXRayEnabled()
    return xrayEnabled
end

return Visual
