local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- แจ้งเตือน
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "🛡️ God Mode",
        Text = "อมตะแล้ว",
        Duration = 3
    })
end)

local function Immortal(char)
    local humanoid = char:WaitForChild("Humanoid")
    
    humanoid.MaxHealth = 9e9         
    humanoid.Health = 9e9
    humanoid.BreakJointsOnDeath = false
    humanoid.RequiresNeck = false
    
    humanoid.HealthChanged:Connect(function(health)
        if health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end)
end

if player.Character then
    Immortal(player.Character)
end
player.CharacterAdded:Connect(Immortal)

print("✅ God Mode เปิดแล้ว")
