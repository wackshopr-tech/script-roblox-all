local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local enabled = false
local dragging = false
local dragInput, dragStart, startPos

local spawnTime = {}
local SPAWN_DELAY = 6

local function trackCharacter(plr)
    plr.CharacterAdded:Connect(function()
        spawnTime[plr] = tick()
    end)
end

for _, plr in pairs(Players:GetPlayers()) do
    trackCharacter(plr)
end

Players.PlayerAdded:Connect(trackCharacter)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BringGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- ปรับขนาดให้เล็กลง และย้ายไปมุมขวาบน
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 150, 0, 90) -- ขนาดเล็กลง
main.Position = UDim2.new(1, -20, 0, 20) -- มุมขวาบน (ห่างจากขอบ 20 pixel)
main.AnchorPoint = Vector2.new(1, 0) -- จุดยึดคือมุมขวาบน
main.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
main.BorderSizePixel = 0
main.Parent = screenGui
main.Active = true

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(150, 150, 150)
stroke.Thickness = 1.5

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1, 0, 0, 25)
title.BackgroundTransparency = 1
title.Text = "Bring System"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 12

local toggle = Instance.new("TextButton")
toggle.Parent = main
toggle.Size = UDim2.new(0.85, 0, 0, 30)
toggle.Position = UDim2.new(0.075, 0, 0.35, 0)
toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggle.Text = "OFF"
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 14
toggle.BorderSizePixel = 0

Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 6)

local keybind = Instance.new("TextLabel")
keybind.Parent = main
keybind.Size = UDim2.new(1, 0, 0, 15)
keybind.Position = UDim2.new(0, 0, 1, -18)
keybind.BackgroundTransparency = 1
keybind.Text = "Keybind: T"
keybind.TextColor3 = Color3.fromRGB(180, 180, 180)
keybind.Font = Enum.Font.Gotham
keybind.TextSize = 10

local function getLookVector()
    return player.Character and player.Character.PrimaryPart and player.Character.PrimaryPart.CFrame.LookVector or Vector3.new(0, 0, -1)
end

local function bringPlayers()
    if not player.Character or not player.Character.PrimaryPart then return end
    local pos = player.Character.PrimaryPart.Position + getLookVector() * 5
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player and other.Character and other.Character.PrimaryPart then
            local hum = other.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local lastSpawn = spawnTime[other]
                if lastSpawn and tick() - lastSpawn < SPAWN_DELAY then
                    continue
                end
                other.Character:SetPrimaryPartCFrame(CFrame.new(pos))
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    if enabled then
        bringPlayers()
    end
end)

local function toggleState()
    enabled = not enabled
    if enabled then
        toggle.Text = "ON"
        toggle.BackgroundColor3 = Color3.fromRGB(0, 180, 100) -- สีเขียวเมื่อเปิด
    else
        toggle.Text = "OFF"
        toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end
end

toggle.MouseButton1Click:Connect(toggleState)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.T then
        toggleState()
    end
end)

-- Dragging System (ยังคงไว้เผื่ออยากย้ายที่)
main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

main.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
