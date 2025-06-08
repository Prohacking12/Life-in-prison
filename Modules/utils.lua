local Utils = {}

function Utils.copyDiscordOnce()
    pcall(function()
        setclipboard("https://discord.gg/evbUW33jdg")
    end)
end

return Utils