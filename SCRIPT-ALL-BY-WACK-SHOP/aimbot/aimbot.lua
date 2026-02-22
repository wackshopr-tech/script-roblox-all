local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local Aimlock = false
local FOVPercent = 20

-- =========================
-- FOV CIRCLE
-- =========================

local Circle = Drawing.new("Circle")
Circle.Thickness = 2
Circle.NumSides = 100
Circle.Filled = false
Circle.Transparency = 0.9
Circle.Color = Color3.fromRGB(0, 170, 255)
Circle.Visible = false

local function UpdateCircle()
    local vp = Camera.ViewportSize
    Circle.Radius = math.min(vp.X, vp.Y) * (FOVPercent / 100) / 2
    Circle.Position = Vector2.new(vp.X / 2, vp.Y / 2)
end

-- =========================
-- TARGET FIND
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

RunService.RenderStepped:Connect(function()
    UpdateCircle()

    if Aimlock then
        local t = GetTarget()
        if t then
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, t.Position)
        end
    end
end)

-- =========================
-- GUI
-- =========================

local Gui = Instance.new("ScreenGui")
Gui.Name = "AimlockGUI"
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false
Gui.DisplayOrder = 999999
Gui.Parent = CoreGui

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.fromOffset(260, 190)
Main.Position = UDim2.fromScale(0.05, 0.35)
Main.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
Main.BorderSizePixel = 0
Main.Active = true
Main.Selectable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 170, 255)
Stroke.Thickness = 1.5

-- =========================
-- DRAG (PC + MOBILE)
-- =========================

do
    local dragging = false
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPos = Main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- =========================
-- TITLE
-- =========================

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,35)
Title.BackgroundTransparency = 1
Title.Text = "⚡ WACK AIMLOCK"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

-- =========================
-- TOGGLE
-- =========================

local Toggle = Instance.new("TextButton", Main)
Toggle.Size = UDim2.new(1,-20,0,36)
Toggle.Position = UDim2.new(0,10,0,45)
Toggle.Text = "▶ เปิด Aimlock"
Toggle.Font = Enum.Font.GothamSemibold
Toggle.TextSize = 14
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
Toggle.BorderSizePixel = 0
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,10)

Toggle.MouseButton1Click:Connect(function()
    Aimlock = not Aimlock
    Toggle.Text = Aimlock and "■ ปิด Aimlock" or "▶ เปิด Aimlock"
    Toggle.BackgroundColor3 = Aimlock and Color3.fromRGB(0,170,255) or Color3.fromRGB(0,100,200)
    Circle.Visible = Aimlock
end)

-- =========================
-- FOV TEXT
-- =========================

local FovText = Instance.new("TextLabel", Main)
FovText.Position = UDim2.new(0,10,0,95)
FovText.Size = UDim2.new(1,-20,0,20)
FovText.BackgroundTransparency = 1
FovText.Text = "FOV : "..FOVPercent.."%"
FovText.TextColor3 = Color3.fromRGB(180,220,255)
FovText.Font = Enum.Font.Gotham
FovText.TextSize = 13
FovText.TextXAlignment = Enum.TextXAlignment.Left

-- =========================
-- SLIDER (PC + MOBILE)
-- =========================

local Bar = Instance.new("Frame", Main)
Bar.Position = UDim2.new(0,10,0,120)
Bar.Size = UDim2.new(1,-20,0,12)
Bar.BackgroundColor3 = Color3.fromRGB(40,60,90)
Bar.BorderSizePixel = 0
Instance.new("UICorner", Bar).CornerRadius = UDim.new(0,8)

local Fill = Instance.new("Frame", Bar)
Fill.Size = UDim2.new(FOVPercent/100,0,1,0)
Fill.BackgroundColor3 = Color3.fromRGB(0,170,255)
Fill.BorderSizePixel = 0
Instance.new("UICorner", Fill).CornerRadius = UDim.new(0,8)

local sliding = false

local function UpdateSlider(inputX)
    local relativeX = inputX - Bar.AbsolutePosition.X
    local pct = math.clamp(relativeX / Bar.AbsoluteSize.X, 0, 1)

    FOVPercent = math.floor(pct * 100 + 0.5)
    Fill.Size = UDim2.new(pct, 0, 1, 0)
    FovText.Text = "FOV : " .. FOVPercent .. "%"
    UpdateCircle()
end

Bar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        sliding = true
        UpdateSlider(input.Position.X)
    end
end)

UIS.InputChanged:Connect(function(input)
    if sliding and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        UpdateSlider(input.Position.X)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        sliding = false
    end
end)

print("Aimlock Loaded Successfully (Mobile Supported)")
