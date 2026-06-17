-- modules/serverhop.lua
local ServerHop = {}
local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/askednobody410-web/hey/main/modules/core.lua"))()

function ServerHop:SmartHop()
    Core:Notify("Server Hop", "Looking for low player servers...", 4)
    
    local placeId = game.PlaceId
    local HttpService = game:GetService("HttpService")
    
    local success, response = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?limit=100"))
    end)
    
    if success and response.data then
        local bestServer = nil
        for _, server in pairs(response.data) do
            if server.playing and server.playing <= 5 and server.id ~= game.JobId then
                bestServer = server
                break
            end
        end
        if bestServer then
            Core:Notify("Server Hop", "Found server with " .. bestServer.playing .. " players", 5)
            game:GetService("TeleportService"):TeleportToPlaceInstance(placeId, bestServer.id)
        else
            Core:Notify("Server Hop", "No low player servers found", 4)
        end
    else
        Core:Notify("Server Hop", "Failed to fetch servers", 4)
    end
end

return ServerHop
