local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local DiscordLink = "https://discord.gg/WjQZPX8PKD"

if PlayerGui:FindFirstChild("RUNLUA_UPDATE_UI") then
	PlayerGui.RUNLUA_UPDATE_UI:Destroy()
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "RUNLUA_UPDATE_UI"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.fromScale(1, 1)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 1
Overlay.BorderSizePixel = 0
Overlay.Parent = Gui

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(335, 205)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(12, 14, 19)
Main.BorderSizePixel = 0
Main.Active = true
Main.ClipsDescendants = true
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(55, 135, 255)
Stroke.Thickness = 1.4
Stroke.Transparency = 0.25
Stroke.Parent = Main

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 24, 35)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 10, 15))
})
Gradient.Rotation = 35
Gradient.Parent = Main

local Glow = Instance.new("Frame")
Glow.Size = UDim2.fromOffset(180, 180)
Glow.Position = UDim2.new(1, -100, 0, -80)
Glow.BackgroundColor3 = Color3.fromRGB(0, 110, 255)
Glow.BackgroundTransparency = 0.85
Glow.BorderSizePixel = 0
Glow.Parent = Main

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(1, 0)
GlowCorner.Parent = Glow

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1, 0, 0, 52)
Top.BackgroundTransparency = 1
Top.Active = true
Top.Parent = Main

local Logo = Instance.new("Frame")
Logo.Size = UDim2.fromOffset(34, 34)
Logo.Position = UDim2.fromOffset(15, 10)
Logo.BackgroundColor3 = Color3.fromRGB(22, 94, 255)
Logo.BorderSizePixel = 0
Logo.Parent = Top

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 10)
LogoCorner.Parent = Logo

local LogoStroke = Instance.new("UIStroke")
LogoStroke.Color = Color3.fromRGB(105, 165, 255)
LogoStroke.Thickness = 1
LogoStroke.Transparency = 0.35
LogoStroke.Parent = Logo

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.fromScale(1, 1)
LogoText.BackgroundTransparency = 1
LogoText.Text = "R"
LogoText.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoText.TextSize = 19
LogoText.Font = Enum.Font.GothamBold
LogoText.Parent = Logo

local Brand = Instance.new("TextLabel")
Brand.Size = UDim2.new(1, -110, 0, 22)
Brand.Position = UDim2.fromOffset(59, 8)
Brand.BackgroundTransparency = 1
Brand.Text = "RUNLUA HUB"
Brand.TextColor3 = Color3.fromRGB(255, 255, 255)
Brand.TextSize = 16
Brand.Font = Enum.Font.GothamBold
Brand.TextXAlignment = Enum.TextXAlignment.Left
Brand.Parent = Top

local SubBrand = Instance.new("TextLabel")
SubBrand.Size = UDim2.new(1, -110, 0, 16)
SubBrand.Position = UDim2.fromOffset(59, 29)
SubBrand.BackgroundTransparency = 1
SubBrand.Text = "SCRIPT UPDATE"
SubBrand.TextColor3 = Color3.fromRGB(95, 165, 255)
SubBrand.TextSize = 10
SubBrand.Font = Enum.Font.GothamMedium
SubBrand.TextXAlignment = Enum.TextXAlignment.Left
SubBrand.Parent = Top

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(30, 30)
Close.Position = UDim2.new(1, -41, 0, 11)
Close.BackgroundColor3 = Color3.fromRGB(28, 31, 40)
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(200, 208, 225)
Close.TextSize = 21
Close.Font = Enum.Font.GothamMedium
Close.AutoButtonColor = false
Close.BorderSizePixel = 0
Close.Parent = Top

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 9)
CloseCorner.Parent = Close

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, -30, 0, 1)
Divider.Position = UDim2.fromOffset(15, 52)
Divider.BackgroundColor3 = Color3.fromRGB(60, 70, 90)
Divider.BackgroundTransparency = 0.3
Divider.BorderSizePixel = 0
Divider.Parent = Main

local UpdateTitle = Instance.new("TextLabel")
UpdateTitle.Size = UDim2.new(1, -30, 0, 28)
UpdateTitle.Position = UDim2.fromOffset(15, 67)
UpdateTitle.BackgroundTransparency = 1
UpdateTitle.Text = "สคริปต์อัพเดทอีกครั้ง!"
UpdateTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
UpdateTitle.TextSize = 19
UpdateTitle.Font = Enum.Font.GothamBold
UpdateTitle.TextXAlignment = Enum.TextXAlignment.Left
UpdateTitle.Parent = Main

local Description = Instance.new("TextLabel")
Description.Size = UDim2.new(1, -30, 0, 42)
Description.Position = UDim2.fromOffset(15, 99)
Description.BackgroundTransparency = 1
Description.Text = "เข้าดิสคอร์ด RUNLUA HUB\nเพื่อรับสคริปต์เวอร์ชันล่าสุด"
Description.TextColor3 = Color3.fromRGB(205, 215, 235)
Description.TextSize = 13
Description.Font = Enum.Font.GothamMedium
Description.TextXAlignment = Enum.TextXAlignment.Left
Description.TextYAlignment = Enum.TextYAlignment.Top
Description.Parent = Main

local CopyButton = Instance.new("TextButton")
CopyButton.Size = UDim2.new(1, -30, 0, 42)
CopyButton.Position = UDim2.new(0, 15, 1, -57)
CopyButton.BackgroundColor3 = Color3.fromRGB(30, 103, 255)
CopyButton.Text = "คัดลอกลิงก์ Discord"
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
CopyButton.TextStrokeTransparency = 0.75
CopyButton.TextSize = 14
CopyButton.Font = Enum.Font.GothamBold
CopyButton.AutoButtonColor = false
CopyButton.BorderSizePixel = 0
CopyButton.Parent = Main

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 11)
CopyCorner.Parent = CopyButton

local CopyStroke = Instance.new("UIStroke")
CopyStroke.Color = Color3.fromRGB(115, 175, 255)
CopyStroke.Thickness = 1
CopyStroke.Transparency = 0.35
CopyStroke.Parent = CopyButton

local CopyGradient = Instance.new("UIGradient")
CopyGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 105, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 55, 225))
})
CopyGradient.Rotation = 0
CopyGradient.Parent = CopyButton

local dragging = false
local dragStart
local startPos
local dragInput

Top.InputBegan:Connect(function(input)
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

Top.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input == dragInput then
		local delta = input.Position - dragStart

		Main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

local closing = false

local function CloseUI()
	if closing then
		return
	end

	closing = true

	TweenService:Create(
		Main,
		TweenInfo.new(
			0.2,
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.In
		),
		{
			Size = UDim2.fromOffset(300, 175),
			BackgroundTransparency = 1
		}
	):Play()

	TweenService:Create(
		Overlay,
		TweenInfo.new(0.2),
		{
			BackgroundTransparency = 1
		}
	):Play()

	task.wait(0.2)

	if Gui then
		Gui:Destroy()
	end
end

Close.MouseEnter:Connect(function()
	TweenService:Create(
		Close,
		TweenInfo.new(0.15),
		{
			BackgroundColor3 = Color3.fromRGB(75, 30, 38),
			TextColor3 = Color3.fromRGB(255, 110, 120)
		}
	):Play()
end)

Close.MouseLeave:Connect(function()
	TweenService:Create(
		Close,
		TweenInfo.new(0.15),
		{
			BackgroundColor3 = Color3.fromRGB(28, 31, 40),
			TextColor3 = Color3.fromRGB(200, 208, 225)
		}
	):Play()
end)

Close.MouseButton1Click:Connect(CloseUI)

CopyButton.MouseEnter:Connect(function()
	TweenService:Create(
		CopyStroke,
		TweenInfo.new(0.15),
		{
			Transparency = 0
		}
	):Play()
end)

CopyButton.MouseLeave:Connect(function()
	TweenService:Create(
		CopyStroke,
		TweenInfo.new(0.15),
		{
			Transparency = 0.35
		}
	):Play()
end)

local copying = false

CopyButton.MouseButton1Click:Connect(function()
	if copying then
		return
	end

	copying = true

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

	if success then
		CopyButton.Text = "✓  คัดลอกลิงก์แล้ว"
		CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

		CopyGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(16, 150, 85)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 105, 62))
		})

		CopyStroke.Color = Color3.fromRGB(100, 255, 165)
		CopyStroke.Transparency = 0.15

		pcall(function()
			StarterGui:SetCore("SendNotification", {
				Title = "RUNLUA HUB",
				Text = "คัดลอกลิงก์ Discord แล้ว",
				Duration = 3
			})
		end)
	else
		CopyButton.Text = "คัดลอกไม่สำเร็จ"
		CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

		CopyGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(210, 55, 65)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 30, 45))
		})

		CopyStroke.Color = Color3.fromRGB(255, 120, 130)
	end

	task.delay(1.5, function()
		if CopyButton and CopyButton.Parent then
			CopyButton.Text = "คัดลอกลิงก์ Discord"
			CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

			CopyGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 105, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 55, 225))
			})

			CopyStroke.Color = Color3.fromRGB(115, 175, 255)
			CopyStroke.Transparency = 0.35

			copying = false
		end
	end)
end)

local OriginalSize = Main.Size

Main.Size = UDim2.fromOffset(285, 160)
Main.BackgroundTransparency = 1

TweenService:Create(
	Overlay,
	TweenInfo.new(0.25),
	{
		BackgroundTransparency = 0.55
	}
):Play()

TweenService:Create(
	Main,
	TweenInfo.new(
		0.45,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out
	),
	{
		Size = OriginalSize,
		BackgroundTransparency = 0
	}
):Play()
