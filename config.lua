-- config.lua
local Config = {}

Config.Settings = {
    -- General
    AutoSave = true,
    Notifications = true,
    
    -- Farm
    AutoFarm = false,
    SelectedWeapon = "Melee",
    FarmDistance = 10,
    
    -- Fruit
    FruitESP = false,
    AutoCollectFruit = false,
    NotifyRareFruit = true,
    
    -- Server
    LowPlayerThreshold = 5,
    AutoServerHop = false,
    
    -- Sea Event
    AutoSailBoat = false,
    SelectedBoat = "Guardian",
    AutoFarmSeaBeast = false,
    
    -- Misc
    Fullbright = false,
    WalkOnWater = false,
    NoClip = false,
}

-- Save/Load functions
function Config:Save()
    -- Will be implemented with Rayfield config saving
    print("Config saved")
end

function Config:Load()
    print("Config loaded")
end

return Config
