local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

pcall(function()
	if CoreGui:FindFirstChild("X-WACK_STORE_V3") then
		CoreGui["X-WACK_STORE_V3"]:Destroy()
	end
end)

local function MakeDraggable(frame, handle)
	local dragging, dragInput, dragStart, startPos
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- สร้าง ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "X-WACK_STORE - สำหรับผู้พัฒนาสคริปต์"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local CurrentThemeColor = Color3.fromRGB(0, 210, 255)

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 13, 18)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = false
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Neon Glow & Border
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Thickness = 1.8
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local UIGradient = Instance.new("UIGradient", UIStroke)
UIGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, CurrentThemeColor),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 128)),
	ColorSequenceKeypoint.new(1, CurrentThemeColor)
})

-- Animation ขอบไฟวิ่ง
task.spawn(function()
	local rot = 0
	while task.wait() do
		rot = (rot + 2) % 360
		UIGradient.Rotation = rot
	end
end)

-- Title Bar (แถบด้านบน)
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 42)
TitleBar.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
TitleBar.BorderSizePixel = 0
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Size = UDim2.new(0, 200, 1, 0)
TitleText.Position = UDim2.new(0, 14, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "X-WACK STORE <font color=\"#00D2FF\">V3</font>"
TitleText.RichText = true
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 15
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- FPS Counter
local FpsLabel = Instance.new("TextLabel", TitleBar)
FpsLabel.Size = UDim2.new(0, 100, 1, 0)
FpsLabel.Position = UDim2.new(1, -150, 0, 0)
FpsLabel.BackgroundTransparency = 1
FpsLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
FpsLabel.Font = Enum.Font.GothamMedium
FpsLabel.TextSize = 12
FpsLabel.TextXAlignment = Enum.TextXAlignment.Right

local frameCount = 0
local lastTime = tick()
RunService.RenderStepped:Connect(function()
	frameCount = frameCount + 1
	if tick() - lastTime >= 1 then
		FpsLabel.Text = "FPS: " .. frameCount
		frameCount = 0
		lastTime = tick()
	end
end)

-- Close Button
local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.fromOffset(26, 26)
CloseBtn.Position = UDim2.new(1, -34, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

CloseBtn.MouseButton1Click:Connect(function()
	TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.fromOffset(0, 0)}):Play()
	task.wait(0.2)
	ScreenGui:Destroy()
end)

-- Profile Section (ด้านซ้าย)
local ProfileFrame = Instance.new("Frame", MainFrame)
ProfileFrame.Size = UDim2.new(0, 140, 1, -50)
ProfileFrame.Position = UDim2.new(0, 8, 0, 46)
ProfileFrame.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
Instance.new("UICorner", ProfileFrame).CornerRadius = UDim.new(0, 10)

local AvatarImg = Instance.new("ImageLabel", ProfileFrame)
AvatarImg.Size = UDim2.fromOffset(50, 50)
AvatarImg.Position = UDim2.new(0.5, -25, 0, 12)
AvatarImg.BackgroundTransparency = 1
AvatarImg.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
Instance.new("UICorner", AvatarImg).CornerRadius = UDim.new(1, 0)

local UserLabel = Instance.new("TextLabel", ProfileFrame)
UserLabel.Size = UDim2.new(1, -10, 0, 20)
UserLabel.Position = UDim2.new(0, 5, 0, 68)
UserLabel.BackgroundTransparency = 1
UserLabel.Text = LocalPlayer.DisplayName
UserLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
UserLabel.Font = Enum.Font.GothamBold
UserLabel.TextSize = 12
UserLabel.TextTruncate = Enum.TextTruncate.AtEnd

local RankLabel = Instance.new("TextLabel", ProfileFrame)
RankLabel.Size = UDim2.new(1, -10, 0, 16)
RankLabel.Position = UDim2.new(0, 5, 0, 86)
RankLabel.BackgroundTransparency = 1
RankLabel.Text = "@" .. LocalPlayer.Name
RankLabel.TextColor3 = CurrentThemeColor
RankLabel.Font = Enum.Font.GothamMedium
RankLabel.TextSize = 10
RankLabel.TextTruncate = Enum.TextTruncate.AtEnd

-- Tab Selector inside Profile Frame
local TabHolder = Instance.new("Frame", ProfileFrame)
TabHolder.Size = UDim2.new(1, -12, 0, 180)
TabHolder.Position = UDim2.new(0, 6, 0, 115)
TabHolder.BackgroundTransparency = 1

local TabListLayout = Instance.new("UIListLayout", TabHolder)
TabListLayout.Padding = UDim.new(0, 6)

-- Content Frame (ด้านขวา)
local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, -162, 1, -54)
ContentFrame.Position = UDim2.new(0, 154, 0, 46)
ContentFrame.BackgroundTransparency = 1

local ScriptTab = Instance.new("ScrollingFrame", ContentFrame)
ScriptTab.Size = UDim2.new(1, 0, 1, 0)
ScriptTab.BackgroundTransparency = 1
ScriptTab.ScrollBarThickness = 3
ScriptTab.ScrollBarImageColor3 = CurrentThemeColor
ScriptTab.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptTab.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScriptTab.Visible = true

local ScriptLayout = Instance.new("UIListLayout", ScriptTab)
ScriptLayout.Padding = UDim.new(0, 8)

local SettingsTab = Instance.new("ScrollingFrame", ContentFrame)
SettingsTab.Size = UDim2.new(1, 0, 1, 0)
SettingsTab.BackgroundTransparency = 1
SettingsTab.ScrollBarThickness = 3
SettingsTab.ScrollBarImageColor3 = CurrentThemeColor
SettingsTab.CanvasSize = UDim2.new(0, 0, 0, 0)
SettingsTab.AutomaticCanvasSize = Enum.AutomaticSize.Y
SettingsTab.Visible = false

local SettingsLayout = Instance.new("UIListLayout", SettingsTab)
SettingsLayout.Padding = UDim.new(0, 8)

-- Tab Switch Logic
local function CreateTabBtn(text, icon, targetTab)
	local Btn = Instance.new("TextButton", TabHolder)
	Btn.Size = UDim2.new(1, 0, 0, 32)
	Btn.BackgroundColor3 = Color3.fromRGB(22, 25, 35)
	Btn.Text = "  " .. icon .. "  " .. text
	Btn.TextColor3 = Color3.fromRGB(180, 185, 200)
	Btn.Font = Enum.Font.GothamMedium
	Btn.TextSize = 11
	Btn.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

	Btn.MouseButton1Click:Connect(function()
		ScriptTab.Visible = false
		SettingsTab.Visible = false
		targetTab.Visible = true
	end)
	return Btn
end

CreateTabBtn("สคริปต์หลัก", "⚡", ScriptTab)
CreateTabBtn("ตั้งค่า UI", "⚙️", SettingsTab)

-- ฟังก์ชันสร้างปุ่มสคริปต์ + ปุ่ม Tooltip
local function AddScriptButton(name, description, callback)
	local Container = Instance.new("Frame", ScriptTab)
	Container.Size = UDim2.new(1, -6, 0, 38)
	Container.BackgroundColor3 = Color3.fromRGB(20, 23, 32)
	Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)

	local Stroke = Instance.new("UIStroke", Container)
	Stroke.Thickness = 1
	Stroke.Color = Color3.fromRGB(40, 45, 60)

	local ExecBtn = Instance.new("TextButton", Container)
	ExecBtn.Size = UDim2.new(1, -40, 1, 0)
	ExecBtn.BackgroundTransparency = 1
	ExecBtn.Text = "   ▶  " .. name
	ExecBtn.TextColor3 = Color3.fromRGB(240, 240, 245)
	ExecBtn.Font = Enum.Font.GothamBold
	ExecBtn.TextSize = 12
	ExecBtn.TextXAlignment = Enum.TextXAlignment.Left

	ExecBtn.MouseButton1Click:Connect(function()
		TweenService:Create(Container, TweenInfo.new(0.1), {BackgroundColor3 = CurrentThemeColor}):Play()
		task.wait(0.1)
		TweenService:Create(Container, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 23, 32)}):Play()
		pcall(callback)
	end)

	-- Info / Description Button
	local InfoBtn = Instance.new("TextButton", Container)
	InfoBtn.Size = UDim2.fromOffset(26, 26)
	InfoBtn.Position = UDim2.new(1, -32, 0.5, -13)
	InfoBtn.BackgroundColor3 = Color3.fromRGB(28, 32, 45)
	InfoBtn.Text = "ⓘ"
	InfoBtn.TextColor3 = CurrentThemeColor
	InfoBtn.Font = Enum.Font.GothamBold
	InfoBtn.TextSize = 12
	Instance.new("UICorner", InfoBtn).CornerRadius = UDim.new(0, 6)

	-- Tooltip Frame
	local Tooltip = Instance.new("Frame", ScreenGui)
	Tooltip.Size = UDim2.new(0, 200, 0, 40)
	Tooltip.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	Tooltip.Visible = false
	Tooltip.ZIndex = 10
	Instance.new("UICorner", Tooltip).CornerRadius = UDim.new(0, 6)
	local TooltipStroke = Instance.new("UIStroke", Tooltip)
	TooltipStroke.Color = CurrentThemeColor
	TooltipStroke.Thickness = 1

	local TooltipText = Instance.new("TextLabel", Tooltip)
	TooltipText.Size = UDim2.new(1, -12, 1, -12)
	TooltipText.Position = UDim2.fromOffset(6, 6)
	TooltipText.BackgroundTransparency = 1
	TooltipText.Text = description
	TooltipText.TextColor3 = Color3.fromRGB(220, 220, 220)
	TooltipText.Font = Enum.Font.GothamMedium
	TooltipText.TextSize = 10
	TooltipText.TextWrapped = true

	InfoBtn.MouseButton1Click:Connect(function()
		Tooltip.Visible = not Tooltip.Visible
		if Tooltip.Visible then
			local mousePos = UserInputService:GetMouseLocation()
			Tooltip.Position = UDim2.fromOffset(mousePos.X + 15, mousePos.Y - 15)
		end
	end)
end

-- -------------------------------------------------------------
-- เพิ่มสคริปต์หลักทั้ง 6 ตัว
-- -------------------------------------------------------------
AddScriptButton("Infinite Yield", "สำหรับหาเครื่องมือต่างๆ และสั่งการคำสั่งแอดมินทั่วไป", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

AddScriptButton("sspy", "ดักการสื่อสารเซิฟเวอร์ (RemoteSpy) สำหรับวิเคราะห์สคริปต์", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
end)

AddScriptButton("Dex", "ดูข้อมูลและโครงสร้างทั้งหมดของเซิฟเวอร์ (Explorer)", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
end)

AddScriptButton("แป้นพิมพ์ (Keyboard)", "คีย์บอร์ดบนหน้าจอ สำหรับอุปกรณ์ที่ไม่มีคีย์ลัดเหมือนคอม", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Xxtan31/Ata/main/deltakeyboardcrack.txt"))()
end)

AddScriptButton("Quirky CMD", "หาช่องโหว่เกม และยิงคำสั่งแอดมินได้ (ใช้ได้บางแมพเท่านั้น)", function()
	loadstring(game:HttpGet("https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"))()
end)

AddScriptButton("เพิ่มความลื่น (FPS Boost)", "ปรับกราฟิกของเกมลงเพื่อเพิ่มค่า FPS ให้เล่นลื่นขึ้น", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/Boots-fps/Boots-fps.lua"))()
end)

-- -------------------------------------------------------------
-- หน้าตั้งค่า UI (Settings)
-- -------------------------------------------------------------
local function CreateSettingSection(title)
	local Label = Instance.new("TextLabel", SettingsTab)
	Label.Size = UDim2.new(1, 0, 0, 20)
	Label.BackgroundTransparency = 1
	Label.Text = title
	Label.TextColor3 = CurrentThemeColor
	Label.Font = Enum.Font.GothamBold
	Label.TextSize = 11
	Label.TextXAlignment = Enum.TextXAlignment.Left
end

-- ปรับขนาด UI (UI Scale Customizer)
CreateSettingSection("ขนาดเมนู (UI Size)")

local SizeBtnContainer = Instance.new("Frame", SettingsTab)
SizeBtnContainer.Size = UDim2.new(1, -6, 0, 36)
SizeBtnContainer.BackgroundTransparency = 1

local SizeLayout = Instance.new("UIListLayout", SizeBtnContainer)
SizeLayout.FillDirection = Enum.FillDirection.Horizontal
SizeLayout.Padding = UDim.new(0, 8)

local function CreateSizeBtn(label, sizeVec)
	local Btn = Instance.new("TextButton", SizeBtnContainer)
	Btn.Size = UDim2.new(0.31, 0, 1, 0)
	Btn.BackgroundColor3 = Color3.fromRGB(24, 28, 38)
	Btn.Text = label
	Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	Btn.Font = Enum.Font.GothamMedium
	Btn.TextSize = 11
	Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

	Btn.MouseButton1Click:Connect(function()
		TweenService:Create(MainFrame, TweenInfo.new(0.2), {Size = sizeVec}):Play()
	end)
end

CreateSizeBtn("เล็ก", UDim2.new(0, 460, 0, 310))
CreateSizeBtn("ปกติ", UDim2.new(0, 520, 0, 360))
CreateSizeBtn("ใหญ่ (คอม)", UDim2.new(0, 620, 0, 420))

-- ปรับเปลี่ยนโทนสี (Color Themes)
CreateSettingSection("เปลี่ยนสีธีม (Theme Color)")

local ColorContainer = Instance.new("Frame", SettingsTab)
ColorContainer.Size = UDim2.new(1, -6, 0, 36)
ColorContainer.BackgroundTransparency = 1

local ColorLayout = Instance.new("UIListLayout", ColorContainer)
ColorLayout.FillDirection = Enum.FillDirection.Horizontal
ColorLayout.Padding = UDim.new(0, 8)

local function CreateThemeBtn(color)
	local Btn = Instance.new("TextButton", ColorContainer)
	Btn.Size = UDim2.fromOffset(28, 28)
	Btn.BackgroundColor3 = color
	Btn.Text = ""
	Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)

	Btn.MouseButton1Click:Connect(function()
		CurrentThemeColor = color
		RankLabel.TextColor3 = color
		ScriptTab.ScrollBarImageColor3 = color
		SettingsTab.ScrollBarImageColor3 = color
		UIGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, color),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, color)
		})
	end)
end

CreateThemeBtn(Color3.fromRGB(0, 210, 255))   -- Cyan / Blue
CreateThemeBtn(Color3.fromRGB(255, 0, 128))  -- Neon Pink
CreateThemeBtn(Color3.fromRGB(0, 255, 128))  -- Emerald Green
CreateThemeBtn(Color3.fromRGB(255, 180, 0))  -- Golden Yellow
CreateThemeBtn(Color3.fromRGB(170, 0, 255))  -- Purple Void

-- ปุ่ม Toggle Open/Close UI (Floating Button)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.fromOffset(40, 40)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -20)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
ToggleBtn.Text = "X"
ToggleBtn.TextColor3 = CurrentThemeColor
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 16
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = CurrentThemeColor
ToggleStroke.Thickness = 1.5

ToggleBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
	ToggleBtn.Text = MainFrame.Visible and "X" or "W"
end)

MakeDraggable(MainFrame, TitleBar)
MakeDraggable(ToggleBtn, ToggleBtn)

-- แจ้งเตือนเมื่อโหลดเสร็จ
game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "X-WACK STORE V3",
	Text = "โหลดระบบเรียบร้อยแล้ว!",
	Duration = 4,
})
