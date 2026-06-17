-- modules/core.lua
local Core = {}

Core.Player = game.Players.LocalPlayer
Core.Character = Core.Player.Character or Core.Player.CharacterAdded:Wait()
Core.HumanoidRootPart = Core.Character:WaitForChild("HumanoidRootPart")

-- Tween Service
Core.TweenService = game:GetService("TweenService")
Core.TeleportService = game:GetService("TeleportService")
Core.HttpService = game:GetService("HttpService")

function Core:TweenTo(pos, speed)
    local distance = (Core.HumanoidRootPart.Position - pos.Position).Magnitude
    local tweenInfo = TweenInfo.new(distance / (speed or 200), Enum.EasingStyle.Linear)
    Core.TweenService:Create(Core.HumanoidRootPart, tweenInfo, {CFrame = pos}):Play()
end

function Core:Notify(title, content, duration)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = duration or 5,
        Image = 4483362458
    })
end

return Core
