local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local Aimlock = false
local FOVPercent = 20

-- =========================
-- FOV CIRCLE (Drawing Lib)
-- =========================

local Circle = Drawing.new("Circle")
Circle.Thickness = 2
Circle.NumSides = 60 -- ปรับลดลงเล็กน้อยเพื่อให้ลื่นขึ้นบนมือถือ
Circle.Filled = false
Circle.Transparency = 1 -- ปรับให้ชัดเจนที่สุด
Circle.Color = Color3.fromRGB(0, 170, 255)
Circle.Visible = false

local function UpdateCircle()
    local vp = Camera.ViewportSize
    if vp.X == 0 or vp.Y == 0 then return end -- ป้องกัน Error ช่วงเริ่มเกม

    -- คำนวณรัศมีให้สมดุลกับขนาดหน้าจอมือถือ
    -- ใช้ math.min เพื่อให้วงกลมไม่ใหญ่เกินหน้าจอในเครื่องที่จอแคบ
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
                -- ตรวจสอบว่าศัตรูอยู่ในวงกลม FOV หรือไม่
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
    Circle.Visible = Aimlock -- บังคับค่า Visible ให้ตรงกับสถานะ Aimlock เสมอ

    if Aimlock then
        local target = GetTarget()
        if target then
            -- ล็อคเป้าหมาย (Camera CFrame)
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target.Position)
        end
    end
end)

-- =========================
-- GUI SETUP
-- =========================

local Gui = Instance.new("ScreenGui")
Gui.Name = "AimlockGUI_MobileFix"
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false
Gui.Parent = CoreGui

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.fromOffset(260, 190)
Main.Position = UDim2.fromScale(0.1, 0.3) -- เลื่อนตำแหน่งเริ่มให้ห่างจากขอบจอเล็กน้อย
Main.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
Main.Active = true
Main.Draggable = true -- เปิดการลากพื้นฐานเพื่อให้รองรับ Mobile ง่ายขึ้น
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 170, 255)
Stroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,35)
Title.BackgroundTransparency = 1
Title.Text = "⚡ MOBILE AIMLOCK FIX"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

-- =========================
-- TOGGLE BUTTON
-- =========================

local Toggle = Instance.new("TextButton", Main)
Toggle.Size = UDim2.new(1,-20,0,45)
Toggle.Position = UDim2.new(0,10,0,45)
Toggle.Text = "▶ เปิดใช้งาน"
Toggle.Font = Enum.Font.GothamSemibold
Toggle.TextSize = 16
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,10)

Toggle.MouseButton1Click:Connect(function()
    Aimlock = not Aimlock
    Toggle.Text = Aimlock and "■ ปิดการทำงาน" or "▶ เปิดใช้งาน"
    Toggle.BackgroundColor3 = Aimlock and Color3.fromRGB(0,170,255) or Color3.fromRGB(0,100,200)
    Circle.Visible = Aimlock
end)

-- =========================
-- SLIDER SYSTEM
-- =========================

local FovText = Instance.new("TextLabel", Main)
FovText.Position = UDim2.new(0,10,0,105)
FovText.Size = UDim2.new(1,-20,0,20)
FovText.BackgroundTransparency = 1
FovText.Text = "FOV SIZE : " .. FOVPercent .. "%"
FovText.TextColor3 = Color3.fromRGB(180,220,255)
FovText.Font = Enum.Font.Gotham
FovText.TextSize = 14
FovText.TextXAlignment = Enum.TextXAlignment.Left

local Bar = Instance.new("Frame", Main)
Bar.Position = UDim2.new(0,10,0,130)
Bar.Size = UDim2.new(1,-20,0,14)
Bar.BackgroundColor3 = Color3.fromRGB(40,60,90)
Instance.new("UICorner", Bar).CornerRadius = UDim.new(0,8)

local Fill = Instance.new("Frame", Bar)
Fill.Size = UDim2.new(FOVPercent/100, 0, 1, 0)
Fill.BackgroundColor3 = Color3.fromRGB(0,170,255)
Instance.new("UICorner", Fill).CornerRadius = UDim.new(0,8)

local sliding = false

local function UpdateSlider(inputX)
    local relativeX = inputX - Bar.AbsolutePosition.X
    local pct = math.clamp(relativeX / Bar.AbsoluteSize.X, 0, 1)

    FOVPercent = math.floor(pct * 100)
    Fill.Size = UDim2.new(pct, 0, 1, 0)
    FovText.Text = "FOV SIZE : " .. FOVPercent .. "%"
    UpdateCircle()
end

-- สำหรับ Mobile Touch + PC Mouse
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

print("Aimlock Mobile Fix Loaded!")
