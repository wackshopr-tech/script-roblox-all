local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ตรวจสอบการรองรับ GUI Parent (CoreGui สำหรับ Executor / PlayerGui สำหรับทดสอบ)
local GuiParent = (gethui and gethui()) or game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local Aimlock = false
local FOVPercent = 20

-- =========================
-- FOV CIRCLE (Drawing Lib)
-- =========================

local Circle = Drawing.new("Circle")
Circle.Thickness = 1.5
Circle.NumSides = 45 -- ปรับเพื่อประหยัดทรัพยากรบนมือถือ
Circle.Filled = false
Circle.Transparency = 0.8
Circle.Color = Color3.fromRGB(0, 170, 255)
Circle.Visible = false

local function UpdateCircle()
    local vp = Camera.ViewportSize
    if vp.X == 0 or vp.Y == 0 then return end
    
    local baseRes = math.min(vp.X, vp.Y)
    Circle.Radius = (baseRes / 2) * (FOVPercent / 100)
    Circle.Position = Vector2.new(vp.X / 2, vp.Y / 2)
end

-- =========================
-- TARGET FINDING
-- =========================

local function GetTarget()
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local closest, dist = nil, math.huge

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            local head = p.Character.Head
            local pos, onScreen = Camera:WorldToViewportPoint(head.Position)

            if onScreen then
                local mag = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                if mag <= Circle.Radius and mag < dist then
                    closest = head
                    dist = mag
                end
            end
        end
    end
    return closest
end

-- =========================
-- MAIN LOOP
-- =========================

RunService.RenderStepped:Connect(function()
    UpdateCircle()
    Circle.Visible = Aimlock

    if Aimlock then
        local target = GetTarget()
        if target then
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target.Position)
        end
    end
end)

-- =========================
-- COMPACT MOBILE GUI
-- =========================

local Gui = Instance.new("ScreenGui")
Gui.Name = "MobileAimlock_Mini"
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false
Gui.Parent = GuiParent

-- Main Frame (ปรับขนาดลงเหลือ 170x120)
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.fromOffset(170, 120)
Main.Position = UDim2.fromScale(0.05, 0.2)
Main.BackgroundColor3 = Color3.fromRGB(15, 18, 28)
Main.Active = true
Main.Draggable = true

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(0, 170, 255)
MainStroke.Thickness = 1.5

-- Header / Title Bar
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -30, 0, 28)
Title.Position = UDim2.new(0, 8, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ AIMLOCK"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left

-- ปุ่ม พับ/กาง หน้าจอ (Minimize Button)
local MiniBtn = Instance.new("TextButton", Main)
MiniBtn.Size = UDim2.new(0, 22, 0, 22)
MiniBtn.Position = UDim2.new(1, -26, 0, 3)
MiniBtn.Text = "-"
MiniBtn.Font = Enum.Font.GothamBold
MiniBtn.TextSize = 14
MiniBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MiniBtn.BackgroundColor3 = Color3.fromRGB(25, 32, 48)
Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(0, 6)

local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, 0, 1, -28)
Container.Position = UDim2.new(0, 0, 0, 28)
Container.BackgroundTransparency = 1

local isMinimized = false
MiniBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    Container.Visible = not isMinimized
    Main.Size = isMinimized and UDim2.fromOffset(170, 28) or UDim2.fromOffset(170, 120)
    MiniBtn.Text = isMinimized and "+" or "-"
end)

-- Toggle Button
local Toggle = Instance.new("TextButton", Container)
Toggle.Size = UDim2.new(1, -16, 0, 32)
Toggle.Position = UDim2.new(0, 8, 0, 4)
Toggle.Text = "OFF"
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 13
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 8)

Toggle.MouseButton1Click:Connect(function()
    Aimlock = not Aimlock
    Toggle.Text = Aimlock and "ON" or "OFF"
    Toggle.BackgroundColor3 = Aimlock and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(40, 45, 60)
    Circle.Visible = Aimlock
end)

-- FOV Label
local FovText = Instance.new("TextLabel", Container)
FovText.Size = UDim2.new(1, -16, 0, 16)
FovText.Position = UDim2.new(0, 8, 0, 42)
FovText.BackgroundTransparency = 1
FovText.Text = "FOV: " .. FOVPercent .. "%"
FovText.TextColor3 = Color3.fromRGB(180, 210, 245)
FovText.Font = Enum.Font.Gotham
FovText.TextSize = 11
FovText.TextXAlignment = Enum.TextXAlignment.Left

-- FOV Slider Bar
local Bar = Instance.new("Frame", Container)
Bar.Size = UDim2.new(1, -16, 0, 12)
Bar.Position = UDim2.new(0, 8, 0, 62)
Bar.BackgroundColor3 = Color3.fromRGB(30, 40, 60)
Instance.new("UICorner", Bar).CornerRadius = UDim.new(0, 6)

local Fill = Instance.new("Frame", Bar)
Fill.Size = UDim2.new(FOVPercent / 100, 0, 1, 0)
Fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Instance.new("UICorner", Fill).CornerRadius = UDim.new(0, 6)

-- Touch Input Handling สำหรับ Slider
local sliding = false

local function UpdateSlider(inputX)
    local relativeX = inputX - Bar.AbsolutePosition.X
    local pct = math.clamp(relativeX / Bar.AbsoluteSize.X, 0, 1)

    FOVPercent = math.floor(pct * 100)
    Fill.Size = UDim2.new(pct, 0, 1, 0)
    FovText.Text = "FOV: " .. FOVPercent .. "%"
    UpdateCircle()
end

Bar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliding = true
        UpdateSlider(input.Position.X)
    end
end)

UIS.InputChanged:Connect(function(input)
    if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        UpdateSlider(input.Position.X)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliding = false
    end
end)
