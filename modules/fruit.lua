-- modules/fruit.lua
local Fruit = {}
local Core = loadstring(game:HttpGet("https://raw.githubusercontent.com/askednobody410-web/hey/main/modules/core.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera

local player = Players.LocalPlayer
local rootPart = nil
local running = true
local espObjects = {}
local fruitRegistry = {}

local fruitRarity = {
    ["Rocket Fruit"] = 1, ["Spin Fruit"] = 1, ["Blade Fruit"] = 1, ["Spring Fruit"] = 1,
    ["Bomb Fruit"] = 1, ["Smoke Fruit"] = 1, ["Spike Fruit"] = 1, ["Flame Fruit"] = 1,
    ["Ice Fruit"] = 2, ["Sand Fruit"] = 2, ["Dark Fruit"] = 2, ["Eagle Fruit"] = 2,
    ["Diamond Fruit"] = 2, ["Light Fruit"] = 2, ["Rubber Fruit"] = 2, ["Ghost Fruit"] = 2,
    ["Magma Fruit"] = 2, ["Quake Fruit"] = 2, ["Love Fruit"] = 3, ["Creation Fruit"] = 3,
    ["Spider Fruit"] = 3, ["Sound Fruit"] = 3, ["Phoenix Fruit"] = 3, ["Buddha Fruit"] = 4,
    ["Portal Fruit"] = 4, ["Lightning Fruit"] = 4, ["Pain Fruit"] = 4, ["Blizzard Fruit"] = 4,
    ["Gravity Fruit"] = 5, ["Mammoth Fruit"] = 5, ["T-Rex Fruit"] = 5, ["Dough Fruit"] = 5,
    ["Shadow Fruit"] = 5, ["Venom Fruit"] = 5, ["Gas Fruit"] = 6, ["Spirit Fruit"] = 6,
    ["Tiger Fruit"] = 6, ["Yeti Fruit"] = 6, ["Kitsune Fruit"] = 6, ["Control Fruit"] = 6,
    ["Dragon Fruit"] = 6,
}

local fruitNames = {}
for name in pairs(fruitRarity) do fruitNames[name] = true end

local ESP_TAG = "FruitESP_Tagged"

local function getColor(r)
    if r == 6 then return Color3.fromRGB(255, 30, 30)
    elseif r == 5 then return Color3.fromRGB(180, 0, 255)
    elseif r == 4 then return Color3.fromRGB(50, 100, 255)
    elseif r == 3 then return Color3.fromRGB(255, 215, 0)
    elseif r == 2 then return Color3.fromRGB(0, 210, 80)
    else return Color3.fromRGB(160, 160, 160) end
end

local function createESP(inst)
    if espObjects[inst] then return end
    local r = fruitRarity[inst.Name] or 1
    local c = getColor(r)

    local line = Drawing.new("Line")
    line.Thickness = 1
    line.Color = c
    line.Transparency = 1
    line.Visible = false

    local box = Drawing.new("Square")
    box.Thickness = 1
    box.Color = c
    box.Filled = false
    box.Transparency = 1
    box.Visible = false

    local label = Drawing.new("Text")
    label.Size = 13
    label.Center = true
    label.Outline = true
    label.Color = c
    label.Text = inst.Name
    label.Transparency = 1
    label.Visible = false

    local distText = Drawing.new("Text")
    distText.Size = 12
    distText.Center = true
    distText.Outline = true
    distText.Color = Color3.fromRGB(220, 220, 220)
    distText.Transparency = 1
    distText.Visible = false

    espObjects[inst] = {line = line, box = box, label = label, distText = distText}
end

local function removeESP(inst)
    local d = espObjects[inst]
    if not d then return end
    espObjects[inst] = nil
    fruitRegistry[inst] = nil
    pcall(function() d.line:Remove() end)
    pcall(function() d.box:Remove() end)
    pcall(function() d.label:Remove() end)
    pcall(function() d.distText:Remove() end)
end

Fruit.ESPEnabled = false

function Fruit:ToggleESP(state)
    Fruit.ESPEnabled = state
    if state then
        Core:Notify("Fruit ESP", "Enabled", 4)
    else
        Core:Notify("Fruit ESP", "Disabled", 3)
        for inst in pairs(espObjects) do
            removeESP(inst)
        end
    end
end

-- Your full ESP logic
local function updateRoot()
    pcall(function()
        local c = player.Character
        if c then rootPart = c:FindFirstChild("HumanoidRootPart") end
    end)
end

local function register(inst)
    if not inst or inst.Parent ~= Workspace then return end
    if not (inst:IsA("Tool") or inst:IsA("Model")) then return end
    local root = inst
    if fruitRegistry[root] then return end
    if not (fruitNames[root.Name] or root.Name:lower():find("fruit")) then return end
    fruitRegistry[root] = true
    createESP(root)
end

RunService.RenderStepped:Connect(function()
    if not Fruit.ESPEnabled or not rootPart then
        updateRoot()
        return
    end

    local rp = rootPart.Position
    local originSP = Camera:WorldToViewportPoint(rp)
    local origin = Vector2.new(originSP.X, originSP.Y)

    for inst, d in pairs(espObjects) do
        if not inst or not inst.Parent then
            removeESP(inst)
            continue
        end

        local pos = inst:FindFirstChild("Handle") and inst.Handle.Position or inst.PrimaryPart and inst.PrimaryPart.Position
        if not pos then continue end

        local sp, onScreen = Camera:WorldToViewportPoint(pos)
        if not onScreen or sp.Z < 0 then
            d.line.Visible = false
            d.box.Visible = false
            d.label.Visible = false
            d.distText.Visible = false
            continue
        end

        local dist = (pos - rp).Magnitude
        local scale = math.clamp(1000 / math.max(dist, 1), 10, 120)
        local halfW = scale * 0.6
        local halfH = scale * 0.9

        d.line.From = origin
        d.line.To = Vector2.new(sp.X, sp.Y)
        d.line.Visible = true

        d.box.Size = Vector2.new(halfW * 2, halfH * 2)
        d.box.Position = Vector2.new(sp.X - halfW, sp.Y - halfH)
        d.box.Visible = true

        d.label.Position = Vector2.new(sp.X, sp.Y - halfH - 16)
        d.label.Visible = true

        d.distText.Text = math.floor(dist) .. "m"
        d.distText.Position = Vector2.new(sp.X, sp.Y + halfH + 4)
        d.distText.Visible = true
    end
end)

Workspace.DescendantAdded:Connect(function(inst)
    if Fruit.ESPEnabled then
        task.defer(register, inst)
    end
end)

player.CharacterAdded:Connect(function(c)
    task.wait(0.5)
    rootPart = c:WaitForChild("HumanoidRootPart")
end)

updateRoot()

return Fruit
