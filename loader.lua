-- HEY Hub Loader (Modular)
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

print("HEY Hub Loader Started")

-- Load Config
local Config = loadstring(game:HttpGet("https://raw.githubusercontent.com/askednobody410-web/hey/main/config.lua"))()

-- Load Modules
local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/askednobody410-web/hey/main/modules/core.lua"))()
local Fruit = loadstring(game:HttpGet("https://raw.githubusercontent.com/askednobody410-web/hey/main/modules/fruit.lua"))()
local ServerHop = loadstring(game:HttpGet("https://raw.githubusercontent.com/askednobody410-web/hey/main/modules/serverhop.lua"))()
local Sea = loadstring(game:HttpGet("https://raw.githubusercontent.com/askednobody410-web/hey/main/modules/sea.lua"))()
local Misc = loadstring(game:HttpGet("https://raw.githubusercontent.com/askednobody410-web/hey/main/modules/misc.lua"))()

print("All modules loaded successfully")
