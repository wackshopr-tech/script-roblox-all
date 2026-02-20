local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local SetClipboard = setclipboard or toclipboard or print

pcall(function()
    if CoreGui:FindFirstChild("WackShopPremium") then
        CoreGui.WackShopPremium:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WackShopPremium"
ScreenGui.Parent = CoreGui

local function Notify(text)
    local NotifFrame = Instance.new("Frame", ScreenGui)
    NotifFrame.Size = UDim2.new(0, 300, 0, 50)
    NotifFrame.Position = UDim2.new(0.5, -150, 1, 50)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    NotifFrame.BorderSizePixel = 0
    Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 10)
    
    local Msg = Instance.new("TextLabel", NotifFrame)
    Msg.Size = UDim2.new(1, 0, 1, 0)
    Msg.BackgroundTransparency = 1
    Msg.Text = text
    Msg.TextColor3 = Color3.fromRGB(0, 255, 150)
    Msg.Font = Enum.Font.GothamBold
    Msg.TextSize = 14

    TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -150, 0.85, 0)}):Play()
    task.wait(2.5)
    TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Position = UDim2.new(0.5, -150, 1, 50)}):Play()
    task.delay(0.5, function() NotifFrame:Destroy() end)
end

SetClipboard("https://discord.gg/X6dsp3KxVF")
Notify("✅ คัดลอกลิงก์ดิสคอร์ดเจ้าของสคริปต์สำเร็จ!")

local Main = Instance.new("Frame", ScreenGui)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.Size = UDim2.fromOffset(450, 280)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)

local UIStroke = Instance.new("UIStroke", Main)
UIStroke.Thickness = 3
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local UIGradient = Instance.new("UIGradient", UIStroke)
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
})

task.spawn(function()
    local counter = 0
    while task.wait() do
        counter = counter + 0.01
        UIGradient.Offset = Vector2.new(math.sin(counter), 0)
    end
end)

local Title = Instance.new("TextLabel", Main)
Title.Position = UDim2.fromOffset(0, 20)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "WACK SHOP ภาษาไทย"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 26

local Subtitle = Instance.new("TextLabel", Main)
Subtitle.Position = UDim2.fromOffset(0, 60)
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "เลือกเวอร์ชั่นของ GUI ที่คุณต้องการใช้งาน"
Subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 14

local function createButton(text, y, color)
    local b = Instance.new("TextButton", Main)
    b.Position = UDim2.new(0.5, -175, 0, y)
    b.Size = UDim2.new(0, 350, 0, 60)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 18
    b.TextColor3 = Color3.new(1, 1, 1)
    b.AutoButtonColor = false
    
    local corner = Instance.new("UICorner", b)
    corner.CornerRadius = UDim.new(0, 12)
    
    local stroke = Instance.new("UIStroke", b)
    stroke.Thickness = 1.5
    stroke.Color = color
    stroke.Transparency = 0.5

    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(40, 40, 60), Size = UDim2.new(0, 360, 0, 65), Position = UDim2.new(0.5, -180, 0, y-2.5)}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(30, 30, 45), Size = UDim2.new(0, 350, 0, 60), Position = UDim2.new(0.5, -175, 0, y)}):Play()
    end)
    
    return b
end

local oldBtn = createButton("⭐ GUI เก่า ฟังชั่นเดิม ", 110, Color3.fromRGB(255, 150, 0))
local newBtn = createButton("🔥 GUI ใหม่ ฟังชั่นเยอะ", 185, Color3.fromRGB(0, 200, 255))

local function runScript(url)
    ScreenGui:Destroy()
    loadstring(game:HttpGet(url))()
end

oldBtn.MouseButton1Click:Connect(function()
    runScript("https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/Gui-Old.lua")
end)

newBtn.MouseButton1Click:Connect(function()
    runScript("https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/Gui-New.lua")
end)
