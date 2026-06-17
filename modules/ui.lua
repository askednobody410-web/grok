-- modules/ui.lua
local UI = {}

function UI:Create(Window)
    local MainTab = Window:CreateTab("Main", 4483362458)
    local FruitTab = Window:CreateTab("Fruit", 4483362458)
    local ServerTab = Window:CreateTab("Server", 4483362458)
    local SeaTab = Window:CreateTab("Sea", 4483362458)
    local MiscTab = Window:CreateTab("Misc", 4483362458)

    -- Main Tab
    MainTab:CreateParagraph({Title = "HEY Hub", Content = "Modular Blox Fruits Hub 2026"})

    MainTab:CreateButton({
        Name = "Rejoin",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId)
        end
    })

    -- Fruit Tab (basic)
    FruitTab:CreateToggle({
        Name = "Fruit ESP",
        CurrentValue = false,
        Callback = function(v)
            print("Fruit ESP:", v)
        end
    })

    -- Add more tabs later

    return {MainTab = MainTab, FruitTab = FruitTab, ServerTab = ServerTab, SeaTab = SeaTab, MiscTab = MiscTab}
end

return UI
