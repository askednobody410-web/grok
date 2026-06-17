-- modules/sea.lua
local Sea = {}
local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/askednobody410-web/hey/main/modules/core.lua"))()

Sea.AutoSail = false
Sea.SelectedBoat = "Guardian"

function Sea:ToggleAutoSail(state)
    Sea.AutoSail = state
    if state then
        Core:Notify("Sea Event", "Auto Sail started", 4)
        -- Boat logic from your dumps can go here
    else
        Core:Notify("Sea Event", "Auto Sail stopped", 3)
    end
end

return Sea
