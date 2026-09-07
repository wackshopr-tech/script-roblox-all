local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local DiscordLink = "https://discord.gg/WjQZPX8PKD"

pcall(function()
    CoreGui.RUNLUA_UPDATE_UI:Destroy()
end)

pcall(function()
    Lighting.RUNLUA_UPDATE_BLUR:Destroy()
end)

local Gui = Instance.new("ScreenGui")
Gui.Name = "RUNLUA_UPDATE_UI"
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = CoreGui

local Blur = Instance.new("BlurEffect")
Blur.Name = "RUNLUA_UPDATE_BLUR"
Blur.Size = 0
Blur.Parent = Lighting

local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.fromScale(1, 1)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 1
Overlay.BorderSizePixel = 0
Overlay.Parent = Gui

local Main = Instance.new("Frame")
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.Size = UDim2.fromOffset(0, 0)
Main.BackgroundColor3 = Color3.fromRGB(18, 19, 25)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Overlay

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(105, 112, 255)
Stroke.Transparency = 0.45
Stroke.Thickness = 1.2
Stroke.Parent = Main

local TopGlow = Instance.new("Frame")
TopGlow.Size = UDim2.new(1, 0, 0, 3)
TopGlow.BackgroundColor3 = Color3.fromRGB(105, 112, 255)
TopGlow.BorderSizePixel = 0
TopGlow.Parent = Main

local TopGradient = Instance.new("UIGradient")
TopGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(94, 82, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(112, 135, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(94, 82, 255))
})
TopGradient.Parent = TopGlow

local Header = Instance.new("Frame")
Header.Position = UDim2.fromOffset(15, 14)
Header.Size = UDim2.new(1, -30, 0, 40)
Header.BackgroundTransparency = 1
Header.Parent = Main

local Logo = Instance.new("Frame")
Logo.Size = UDim2.fromOffset(38, 38)
Logo.BackgroundColor3 = Color3.fromRGB(91, 100, 255)
Logo.BorderSizePixel = 0
Logo.Parent = Header

Instance.new("UICorner", Logo).CornerRadius = UDim.new(0, 10)

local LogoGradient = Instance.new("UIGradient")
LogoGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(116, 91, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(68, 135, 255))
})
LogoGradient.Rotation = 45
LogoGradient.Parent = Logo

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.fromScale(1, 1)
LogoText.BackgroundTransparency = 1
LogoText.Text = "R"
LogoText.Font = Enum.Font.GothamBold
LogoText.TextSize = 20
LogoText.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoText.Parent = Logo

local Brand = Instance.new("TextLabel")
Brand.Position = UDim2.fromOffset(49, 0)
Brand.Size = UDim2.new(1, -49, 0, 21)
Brand.BackgroundTransparency = 1
Brand.Text = "RUNLUA HUB"
Brand.Font = Enum.Font.GothamBold
Brand.TextSize = 16
Brand.TextColor3 = Color3.fromRGB(250, 250, 255)
Brand.TextXAlignment = Enum.TextXAlignment.Left
Brand.Parent = Header

local Status = Instance.new("TextLabel")
Status.Position = UDim2.fromOffset(49, 21)
Status.Size = UDim2.new(1, -49, 0, 16)
Status.BackgroundTransparency = 1
Status.Text = "●  มีอัปเดตใหม่"
Status.Font = Enum.Font.GothamMedium
Status.TextSize = 11
Status.TextColor3 = Color3.fromRGB(122, 135, 255)
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.Parent = Header

local Divider = Instance.new("Frame")
Divider.Position = UDim2.fromOffset(15, 64)
Divider.Size = UDim2.new(1, -30, 0, 1)
Divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Divider.BackgroundTransparency = 0.91
Divider.BorderSizePixel = 0
Divider.Parent = Main

local Title = Instance.new("TextLabel")
Title.Position = UDim2.fromOffset(17, 78)
Title.Size = UDim2.new(1, -34, 0, 25)
Title.BackgroundTransparency = 1
Title.Text = "สคริปต์มีการอัพเดท!"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 19
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

local Description = Instance.new("TextLabel")
Description.Position = UDim2.fromOffset(17, 108)
Description.Size = UDim2.new(1, -34, 0, 42)
Description.BackgroundTransparency = 1
Description.Text = "สคริปต์ตัวนี้เป็นเวอร์ชันเก่า\nรับตัวใหม่ได้ที่ Discord ของ RUNLUA HUB"
Description.Font = Enum.Font.Gotham
Description.TextSize = 12
Description.TextColor3 = Color3.fromRGB(205, 207, 218)
Description.TextXAlignment = Enum.TextXAlignment.Left
Description.TextYAlignment = Enum.TextYAlignment.Top
Description.Parent = Main

local LinkBox = Instance.new("Frame")
LinkBox.Position = UDim2.fromOffset(17, 158)
LinkBox.Size = UDim2.new(1, -34, 0, 38)
LinkBox.BackgroundColor3 = Color3.fromRGB(27, 29, 38)
LinkBox.BorderSizePixel = 0
LinkBox.Parent = Main

Instance.new("UICorner", LinkBox).CornerRadius = UDim.new(0, 9)

local LinkStroke = Instance.new("UIStroke")
LinkStroke.Color = Color3.fromRGB(255, 255, 255)
LinkStroke.Transparency = 0.9
LinkStroke.Parent = LinkBox

local Link = Instance.new("TextLabel")
Link.Position = UDim2.fromOffset(11, 0)
Link.Size = UDim2.new(1, -22, 1, 0)
Link.BackgroundTransparency = 1
Link.Text = DiscordLink
Link.Font = Enum.Font.GothamMedium
Link.TextSize = 11
Link.TextColor3 = Color3.fromRGB(180, 187, 255)
Link.TextXAlignment = Enum.TextXAlignment.Left
Link.Parent = LinkBox

local Copy = Instance.new("TextButton")
Copy.Position = UDim2.fromOffset(17, 207)
Copy.Size = UDim2.new(1, -34, 0, 42)
Copy.BackgroundColor3 = Color3.fromRGB(88, 98, 255)
Copy.BorderSizePixel = 0
Copy.AutoButtonColor = false
Copy.Text = "คัดลอกลิงก์ Discord"
Copy.Font = Enum.Font.GothamBold
Copy.TextSize = 13
Copy.TextColor3 = Color3.fromRGB(255, 255, 255)
Copy.Parent = Main

Instance.new("UICorner", Copy).CornerRadius = UDim.new(0, 10)

local ButtonGradient = Instance.new("UIGradient")
ButtonGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(103, 86, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(68, 130, 255))
})
ButtonGradient.Rotation = 20
ButtonGradient.Parent = Copy

local Footer = Instance.new("TextLabel")
Footer.Position = UDim2.fromOffset(17, 258)
Footer.Size = UDim2.new(1, -34, 0, 14)
Footer.BackgroundTransparency = 1
Footer.Text = "RUNLUA HUB  •  UPDATE SYSTEM"
Footer.Font = Enum.Font.GothamMedium
Footer.TextSize = 8
Footer.TextColor3 = Color3.fromRGB(100, 103, 120)
Footer.Parent = Main

Copy.MouseButton1Click:Connect(function()
    local success = false

    if setclipboard then
        success = pcall(function()
            setclipboard(DiscordLink)
        end)
    elseif toclipboard then
        success = pcall(function()
            toclipboard(DiscordLink)
        end)
    end

    Copy.Text = success and "คัดลอกแล้ว ✓" or DiscordLink

    TweenService:Create(
        Copy,
        TweenInfo.new(0.12, Enum.EasingStyle.Quad),
        {Size = UDim2.new(1, -28, 0, 44), Position = UDim2.fromOffset(14, 206)}
    ):Play()

    task.wait(0.12)

    TweenService:Create(
        Copy,
        TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(1, -34, 0, 42), Position = UDim2.fromOffset(17, 207)}
    ):Play()

    task.delay(1.8, function()
        if Copy.Parent then
            Copy.Text = "คัดลอกลิงก์ Discord"
        end
    end)
end)

TweenService:Create(
    Overlay,
    TweenInfo.new(0.3, Enum.EasingStyle.Quad),
    {BackgroundTransparency = 0.48}
):Play()

TweenService:Create(
    Blur,
    TweenInfo.new(0.35, Enum.EasingStyle.Quad),
    {Size = 10}
):Play()

TweenService:Create(
    Main,
    TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {Size = UDim2.fromOffset(320, 286)}
):Play()

task.spawn(function()
    while Gui.Parent do
        TweenService:Create(
            Stroke,
            TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Transparency = 0.7}
        ):Play()

        task.wait(1.5)

        TweenService:Create(
            Stroke,
            TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            {Transparency = 0.35}
        ):Play()

        task.wait(1.5)
    end
end)
