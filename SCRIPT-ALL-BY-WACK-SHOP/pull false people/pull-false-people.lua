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

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 200, 0, 120)
main.Position = UDim2.new(0.4, 0, 0.35, 0)
main.BackgroundColor3 = Color3.fromRGB(60,60,60)
main.BorderSizePixel = 0
main.Parent = screenGui
main.Active = true

Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(220,220,220)
stroke.Thickness = 1.5

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "ระบบดึงผู้เล่น"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14

local toggle = Instance.new("TextButton")
toggle.Parent = main
toggle.Size = UDim2.new(0.8,0,0,40)
toggle.Position = UDim2.new(0.1,0,0.38,0)
toggle.BackgroundColor3 = Color3.fromRGB(80,80,80)
toggle.Text = "ปิด"
toggle.TextColor3 = Color3.fromRGB(255,255,255)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 16
toggle.BorderSizePixel = 0

Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,10)

local tstroke = Instance.new("UIStroke", toggle)
tstroke.Color = Color3.fromRGB(200,200,200)
tstroke.Thickness = 1

local keybind = Instance.new("TextLabel")
keybind.Parent = main
keybind.Size = UDim2.new(1,0,0,20)
keybind.Position = UDim2.new(0,0,1,-20)
keybind.BackgroundTransparency = 1
keybind.Text = "กด T เพื่อเปิด/ปิด"
keybind.TextColor3 = Color3.fromRGB(230,230,230)
keybind.Font = Enum.Font.Gotham
keybind.TextSize = 12

local function getLookVector()
    return player.Character and player.Character.PrimaryPart and player.Character.PrimaryPart.CFrame.LookVector or Vector3.new(0,0,-1)
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
        toggle.Text = "เปิด"
        toggle.BackgroundColor3 = Color3.fromRGB(120,120,120)
    else
        toggle.Text = "ปิด"
        toggle.BackgroundColor3 = Color3.fromRGB(80,80,80)
    end
end

toggle.MouseButton1Click:Connect(toggleState)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.T then
        toggleState()
    end
end)

main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 
    or input.UserInputType == Enum.UserInputType.Touch then
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
    if input.UserInputType == Enum.UserInputType.MouseMovement 
    or input.UserInputType == Enum.UserInputType.Touch then
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
