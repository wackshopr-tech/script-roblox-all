local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local MapID = tostring(game.PlaceId)

-- ลบ UI เก่าหากมีอยู่
pcall(function()
	if CoreGui:FindFirstChild("X-WACK_STORE") then
		CoreGui["X-WACK_STORE"]:Destroy()
	end
end)

local Library = {}

-- [[ ฟังก์ชันทำให้ Frame ลากได้ ]]
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

-- [[ สร้างหน้าต่างหลัก ]]
function Library:NewWindow(title)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "X-WACK_STORE"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = CoreGui

	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 520, 0, 350)
	MainFrame.Position = UDim2.new(0.5, -260, 0.5, -175)
	MainFrame.BackgroundColor3 = Color3.fromRGB(16, 17, 24)
	MainFrame.BorderSizePixel = 0
	MainFrame.Parent = ScreenGui

	Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

	-- Glow Edge Animation
	local GlowFrame = Instance.new("Frame", MainFrame)
	GlowFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	GlowFrame.Position = UDim2.fromScale(0.5, 0.5)
	GlowFrame.Size = UDim2.new(1, 8, 1, 8)
	GlowFrame.BackgroundTransparency = 1
	GlowFrame.ZIndex = 0
	Instance.new("UICorner", GlowFrame).CornerRadius = UDim.new(0, 12)

	local GlowStroke = Instance.new("UIStroke", GlowFrame)
	GlowStroke.Thickness = 3
	GlowStroke.Transparency = 0.7

	local Stroke = Instance.new("UIStroke", MainFrame)
	Stroke.Thickness = 1.2
	Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

	local UIGradient = Instance.new("UIGradient", Stroke)
	UIGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 210, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 130)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 210, 255))
	})

	task.spawn(function()
		local rot = 0
		while task.wait() do
			rot = (rot + 1.2) % 360
			UIGradient.Rotation = rot
			GlowStroke.Color = Color3.fromHSV((rot / 360), 0.75, 1)
		end
	end)

	-- Title Bar
	local TitleBar = Instance.new("Frame", MainFrame)
	TitleBar.Size = UDim2.new(1, 0, 0, 40)
	TitleBar.BackgroundColor3 = Color3.fromRGB(22, 24, 34)
	TitleBar.BorderSizePixel = 0
	Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

	-- บังขอบเหลี่ยมด้านล่างของ TitleBar ให้เข้ากับ MainFrame
	local TitleBottomCover = Instance.new("Frame", TitleBar)
	TitleBottomCover.Size = UDim2.new(1, 0, 0, 10)
	TitleBottomCover.Position = UDim2.new(0, 0, 1, -10)
	TitleBottomCover.BackgroundColor3 = Color3.fromRGB(22, 24, 34)
	TitleBottomCover.BorderSizePixel = 0

	local TitleLabel = Instance.new("TextLabel", TitleBar)
	TitleLabel.Size = UDim2.new(1, -70, 1, 0)
	TitleLabel.Position = UDim2.new(0, 16, 0, 0)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text = title
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextSize = 13
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

	local CloseBtn = Instance.new("TextButton", TitleBar)
	CloseBtn.Size = UDim2.fromOffset(22, 22)
	CloseBtn.Position = UDim2.new(1, -32, 0.5, -11)
	CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 55, 85)
	CloseBtn.Text = "✕"
	CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseBtn.Font = Enum.Font.GothamBold
	CloseBtn.TextSize = 10
	CloseBtn.AutoButtonColor = false
	Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
	Instance.new("UIAspectRatioConstraint", CloseBtn)

	CloseBtn.MouseButton1Click:Connect(function()
		TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1}):Play()
		task.wait(0.25)
		ScreenGui:Destroy()
	end)

	-- Sidebar
	local Sidebar = Instance.new("Frame", MainFrame)
	Sidebar.Size = UDim2.new(0, 140, 1, -52)
	Sidebar.Position = UDim2.new(0, 6, 0, 46)
	Sidebar.BackgroundColor3 = Color3.fromRGB(12, 13, 18)
	Sidebar.BorderSizePixel = 0
	Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

	local SidebarList = Instance.new("ScrollingFrame", Sidebar)
	SidebarList.Size = UDim2.new(1, -8, 1, -12)
	SidebarList.Position = UDim2.new(0, 4, 0, 6)
	SidebarList.BackgroundTransparency = 1
	SidebarList.ScrollBarThickness = 0
	SidebarList.AutomaticCanvasSize = Enum.AutomaticSize.Y

	local SidebarLayout = Instance.new("UIListLayout", SidebarList)
	SidebarLayout.Padding = UDim.new(0, 6)

	-- Content Area
	local ContentFrame = Instance.new("Frame", MainFrame)
	ContentFrame.Size = UDim2.new(1, -158, 1, -52)
	ContentFrame.Position = UDim2.new(0, 152, 0, 46)
	ContentFrame.BackgroundTransparency = 1

	-- Toggle Button (Floating Button)
	local ToggleBtn = Instance.new("TextButton", ScreenGui)
	ToggleBtn.Size = UDim2.new(0, 42, 0, 42)
	ToggleBtn.Position = UDim2.new(0, 25, 0.5, -21)
	ToggleBtn.BackgroundColor3 = Color3.fromRGB(22, 24, 34)
	ToggleBtn.Text = "W"
	ToggleBtn.TextColor3 = Color3.fromRGB(0, 210, 255)
	ToggleBtn.Font = Enum.Font.GothamBold
	ToggleBtn.TextSize = 16
	ToggleBtn.AutoButtonColor = false
	Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
	Instance.new("UIAspectRatioConstraint", ToggleBtn)

	local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
	ToggleStroke.Color = Color3.fromRGB(0, 210, 255)
	ToggleStroke.Thickness = 1.2

	ToggleBtn.MouseButton1Click:Connect(function()
		MainFrame.Visible = not MainFrame.Visible
		ToggleBtn.Text = MainFrame.Visible and "✕" or "W"
		ToggleBtn.TextColor3 = MainFrame.Visible and Color3.fromRGB(255, 0, 130) or Color3.fromRGB(0, 210, 255)
		ToggleStroke.Color = ToggleBtn.TextColor3
	end)

	MakeDraggable(MainFrame, TitleBar)
	MakeDraggable(ToggleBtn, ToggleBtn)

	local Tabs = {}
	local WindowFunctions = {}

	function WindowFunctions:NewTab(name, icon)
		local TabBtn = Instance.new("TextButton", SidebarList)
		TabBtn.Size = UDim2.new(1, 0, 0, 34)
		TabBtn.BackgroundColor3 = Color3.fromRGB(24, 26, 36)
		TabBtn.BackgroundTransparency = 1
		TabBtn.Text = "  " .. icon .. "  " .. name
		TabBtn.TextColor3 = Color3.fromRGB(140, 145, 160)
		TabBtn.Font = Enum.Font.GothamMedium
		TabBtn.TextSize = 12
		TabBtn.TextXAlignment = Enum.TextXAlignment.Left
		TabBtn.AutoButtonColor = false
		Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

		local TabStroke = Instance.new("UIStroke", TabBtn)
		TabStroke.Thickness = 1
		TabStroke.Color = Color3.fromRGB(0, 210, 255)
		TabStroke.Transparency = 1

		local TabContent = Instance.new("ScrollingFrame", ContentFrame)
		TabContent.Size = UDim2.new(1, 0, 1, 0)
		TabContent.BackgroundTransparency = 1
		TabContent.Visible = false
		TabContent.ScrollBarThickness = 3
		TabContent.ScrollBarImageColor3 = Color3.fromRGB(35, 38, 55)
		TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y

		local ContentLayout = Instance.new("UIListLayout", TabContent)
		ContentLayout.Padding = UDim.new(0, 8)

		TabBtn.MouseButton1Click:Connect(function()
			for _, v in pairs(Tabs) do
				TweenService:Create(v.Btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(140, 145, 160)}):Play()
				TweenService:Create(v.Stroke, TweenInfo.new(0.2), {Transparency = 1}):Play()
				v.Content.Visible = false
			end
			TweenService:Create(TabBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
			TweenService:Create(TabStroke, TweenInfo.new(0.2), {Transparency = 0.8}):Play()
			TabContent.Visible = true
		end)

		table.insert(Tabs, {Btn = TabBtn, Content = TabContent, Stroke = TabStroke})

		local TabFunctions = {Content = TabContent}

		-- สร้างปุ่มปกติ (Modern & Clean)
		function TabFunctions:NewButton(text, callback)
			local Button = Instance.new("TextButton", TabContent)
			Button.Size = UDim2.new(1, -6, 0, 34)
			Button.BackgroundColor3 = Color3.fromRGB(24, 27, 38)
			Button.Text = text
			Button.TextColor3 = Color3.fromRGB(230, 235, 245)
			Button.Font = Enum.Font.GothamMedium
			Button.TextSize = 12
			Button.AutoButtonColor = false
			Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

			local BtnStroke = Instance.new("UIStroke", Button)
			BtnStroke.Thickness = 1
			BtnStroke.Color = Color3.fromRGB(35, 40, 60)

			Button.MouseEnter:Connect(function()
				TweenService:Create(Button, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(32, 36, 52)}):Play()
				TweenService:Create(BtnStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(0, 210, 255)}):Play()
			end)

			Button.MouseLeave:Connect(function()
				TweenService:Create(Button, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(24, 27, 38)}):Play()
				TweenService:Create(BtnStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(35, 40, 60)}):Play()
			end)

			Button.MouseButton1Click:Connect(function()
				TweenService:Create(Button, TweenInfo.new(0.08), {Size = UDim2.new(1, -10, 0, 32)}):Play()
				task.wait(0.08)
				TweenService:Create(Button, TweenInfo.new(0.08), {Size = UDim2.new(1, -6, 0, 34)}):Play()
				pcall(callback)
			end)
		end

		-- สร้าง TextBox สำหรับพิมพ์โค้ด (มีระยะขอบสเปซพอดีๆ)
		function TabFunctions:NewTextBox(placeholder)
			local BoxFrame = Instance.new("Frame", TabContent)
			BoxFrame.Size = UDim2.new(1, -6, 0, 110)
			BoxFrame.BackgroundColor3 = Color3.fromRGB(12, 13, 19)
			Instance.new("UICorner", BoxFrame).CornerRadius = UDim.new(0, 6)

			local BoxStroke = Instance.new("UIStroke", BoxFrame)
			BoxStroke.Thickness = 1
			BoxStroke.Color = Color3.fromRGB(30, 33, 48)

			local TextBox = Instance.new("TextBox", BoxFrame)
			TextBox.Size = UDim2.new(1, 0, 1, 0)
			TextBox.BackgroundTransparency = 1
			TextBox.PlaceholderText = placeholder or "วางโค้ดที่นี่..."
			TextBox.PlaceholderColor3 = Color3.fromRGB(90, 95, 110)
			TextBox.Text = ""
			TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.Font = Enum.Font.Code
			TextBox.TextSize = 11
			TextBox.TextXAlignment = Enum.TextXAlignment.Left
			TextBox.TextYAlignment = Enum.TextYAlignment.Top
			TextBox.ClearTextOnFocus = false
			TextBox.MultiLine = true
			TextBox.TextWrapped = true

			-- เพิ่มช่องว่างไม่ให้ข้อความชิดขอบเกินไป (ช่วยให้ดูไม่รก)
			local Padding = Instance.new("UIPadding", TextBox)
			Padding.PaddingTop = UDim.new(0, 8)
			Padding.PaddingLeft = UDim.new(0, 8)
			Padding.PaddingRight = UDim.new(0, 8)
			Padding.PaddingBottom = UDim.new(0, 8)

			TextBox.Focused:Connect(function()
				TweenService:Create(BoxStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(0, 210, 255)}):Play()
			end)
			TextBox.FocusLost:Connect(function()
				TweenService:Create(BoxStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(30, 33, 48)}):Play()
			end)

			return TextBox
		end

		-- สร้าง Toggle Button แบบมีตัวเปิดปิด (Custom Animated Switch)
		function TabFunctions:NewToggle(text, callback)
			local TglFrame = Instance.new("Frame", TabContent)
			TglFrame.Size = UDim2.new(1, -6, 0, 36)
			TglFrame.BackgroundColor3 = Color3.fromRGB(24, 27, 38)
			Instance.new("UICorner", TglFrame).CornerRadius = UDim.new(0, 6)

			local TglStroke = Instance.new("UIStroke", TglFrame)
			TglStroke.Thickness = 1
			TglStroke.Color = Color3.fromRGB(35, 40, 60)

			local TglLabel = Instance.new("TextLabel", TglFrame)
			TglLabel.Size = UDim2.new(1, -60, 1, 0)
			TglLabel.Position = UDim2.new(0, 12, 0, 0)
			TglLabel.BackgroundTransparency = 1
			TglLabel.Text = text
			TglLabel.TextColor3 = Color3.fromRGB(200, 205, 215)
			TglLabel.Font = Enum.Font.GothamMedium
			TglLabel.TextSize = 12
			TglLabel.TextXAlignment = Enum.TextXAlignment.Left

			-- แถบสวิตช์หลัก (พื้นหลังสวิตช์)
			local SwitchBg = Instance.new("Frame", TglFrame)
			SwitchBg.Size = UDim2.new(0, 34, 0, 18)
			SwitchBg.Position = UDim2.new(1, -46, 0.5, -9)
			SwitchBg.BackgroundColor3 = Color3.fromRGB(45, 48, 65)
			Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)

			-- ปุ่มวงกลมเล็กๆ ด้านใน
			local SwitchBall = Instance.new("Frame", SwitchBg)
			SwitchBall.Size = UDim2.new(0, 14, 0, 14)
			SwitchBall.Position = UDim2.new(0, 2, 0.5, -7)
			SwitchBall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Instance.new("UICorner", SwitchBall).CornerRadius = UDim.new(1, 0)
			Instance.new("UIAspectRatioConstraint", SwitchBall)

			local ClickBtn = Instance.new("TextButton", TglFrame)
			ClickBtn.Size = UDim2.new(1, 0, 1, 0)
			ClickBtn.BackgroundTransparency = 1
			ClickBtn.Text = ""

			local state = false
			local tweenInfo = TweenInfo.new(0.001, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			ClickBtn.MouseButton1Click:Connect(function()
				state = not state
				if state then
					TweenService:Create(SwitchBg, tweenInfo, {BackgroundColor3 = Color3.fromRGB(0, 210, 255)}):Play()
					TweenService:Create(SwitchBall, tweenInfo, {Position = UDim2.new(1, -16, 0.5, -7)}):Play()
					TweenService:Create(TglLabel, tweenInfo, {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
				else
					TweenService:Create(SwitchBg, tweenInfo, {BackgroundColor3 = Color3.fromRGB(45, 48, 65)}):Play()
					TweenService:Create(SwitchBall, tweenInfo, {Position = UDim2.new(0, 2, 0.5, -7)}):Play()
					TweenService:Create(TglLabel, tweenInfo, {TextColor3 = Color3.fromRGB(200, 205, 215)}):Play()
				end
				pcall(callback, state)
			end)
		end

		return TabFunctions
	end

	task.spawn(function()
		task.wait(0.1)
		if Tabs[1] then
			Tabs[1].Btn.BackgroundTransparency = 0
			Tabs[1].Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			Tabs[1].Stroke.Transparency = 0.8
			Tabs[1].Content.Visible = true
		end
	end)

	return WindowFunctions
end

-- [[ เริ่มต้นใช้งาน UI ]]
local Window = Library:NewWindow("X-WACK STORE  |  Pisit G-Menu V7")

local MainTab = Window:NewTab("ตัวรันโค้ด", "⚡")
local HistoryTab = Window:NewTab("ประวัติบันทึก", "📂")

-- สร้างช่องกรอกโค้ดในหน้าหลัก
local CodeBox = MainTab:NewTextBox("วางโค้ด Luau / Roblox Script ที่นี่...")

-- 1. คัดลอกโค้ด
MainTab:NewButton("คัดลอกโค้ด", function()
	if setclipboard then
		setclipboard(CodeBox.Text)
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "X-WACK STORE",
			Text = "คัดลอกโค้ดลง Clipboard เรียบร้อยแล้ว!",
			Duration = 3
		})
	end
end)

-- 2. รันโค้ด 1 ครั้ง
MainTab:NewButton("รันโค้ด 1 ครั้ง", function()
	if CodeBox.Text ~= "" then
		local func, err = loadstring(CodeBox.Text)
		if func then
			task.spawn(func)
		else
			warn("Execute Error: ", err)
		end
	end
end)

-- 3. บันทึกโค้ด (แยกตาม Place ID)
MainTab:NewButton("บันทึกโค้ด", function()
	if CodeBox.Text == "" or not writefile then return end
	local folder = "PisitSaves/" .. MapID
	if not isfolder("PisitSaves") then makefolder("PisitSaves") end
	if not isfolder(folder) then makefolder(folder) end
	
	local fileName = folder .. "/Save_" .. os.time() .. ".lua"
	writefile(fileName, CodeBox.Text)

	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "X-WACK STORE",
		Text = "บันทึกไฟล์เรียบร้อยแล้ว!",
		Duration = 3
	})
end)

-- 4. ระบบรันรัวๆ (Auto-Execute Loop ด้วยไอคอนสวิทช์ใหม่)
local IsSpamming = false
MainTab:NewToggle("รันรัวๆ (Auto Run Loop)", function(state)
	IsSpamming = state
	task.spawn(function()
		while IsSpamming do
			if CodeBox.Text ~= "" then
				pcall(function()
					loadstring(CodeBox.Text)()
				end)
			end
			task.wait(0.2)
		end
	end)
end)

-- [[ หน้าต่างประวัติบันทึกไฟล์ ]]
local function RefreshHistory()
	for _, child in pairs(HistoryTab.Content:GetChildren()) do
		if child:IsA("Frame") then child:Destroy() end
	end

	local folder = "PisitSaves/" .. MapID
	if isfolder and isfolder(folder) then
		for _, file in pairs(listfiles(folder)) do
			local EntryFrame = Instance.new("Frame", HistoryTab.Content)
			EntryFrame.Size = UDim2.new(1, -6, 0, 38)
			EntryFrame.BackgroundColor3 = Color3.fromRGB(24, 27, 38)
			Instance.new("UICorner", EntryFrame).CornerRadius = UDim.new(0, 6)

			local EntryStroke = Instance.new("UIStroke", EntryFrame)
			EntryStroke.Thickness = 1
			EntryStroke.Color = Color3.fromRGB(35, 40, 60)

			local Label = Instance.new("TextLabel", EntryFrame)
			Label.Size = UDim2.new(0.5, -10, 1, 0)
			Label.Position = UDim2.new(0, 12, 0, 0)
			Label.BackgroundTransparency = 1
			Label.Text = file:sub(#folder + 2)
			Label.TextColor3 = Color3.fromRGB(220, 225, 235)
			Label.Font = Enum.Font.GothamMedium
			Label.TextSize = 11
			Label.TextXAlignment = Enum.TextXAlignment.Left

			-- ปุ่มดึงโค้ดมาใช้
			local UseBtn = Instance.new("TextButton", EntryFrame)
			UseBtn.Size = UDim2.new(0, 52, 0, 24)
			UseBtn.Position = UDim2.new(1, -116, 0.5, -12)
			UseBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
			UseBtn.Text = "ใช้งาน"
			UseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			UseBtn.Font = Enum.Font.GothamBold
			UseBtn.TextSize = 11
			Instance.new("UICorner", UseBtn).CornerRadius = UDim.new(0, 5)

			UseBtn.MouseButton1Click:Connect(function()
				if readfile then
					CodeBox.Text = readfile(file)
					game:GetService("StarterGui"):SetCore("SendNotification", {
						Title = "X-WACK STORE",
						Text = "โหลดโค้ดเข้าสู่ Textbox แล้ว!",
						Duration = 3
					})
				end
			end)

			-- ปุ่มลบไฟล์
			local DelBtn = Instance.new("TextButton", EntryFrame)
			DelBtn.Size = UDim2.new(0, 52, 0, 24)
			DelBtn.Position = UDim2.new(1, -58, 0.5, -12)
			DelBtn.BackgroundColor3 = Color3.fromRGB(235, 50, 70)
			DelBtn.Text = "ลบไฟล์"
			DelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			DelBtn.Font = Enum.Font.GothamBold
			DelBtn.TextSize = 11
			Instance.new("UICorner", DelBtn).CornerRadius = UDim.new(0, 5)

			DelBtn.MouseButton1Click:Connect(function()
				if delfile then
					delfile(file)
					EntryFrame:Destroy()
				end
			end)
		end
	end
end

-- ปุ่มรีเฟรชรายการประวัติ
HistoryTab:NewButton("🔄 รีเฟรชรายการไฟล์", function()
	RefreshHistory()
end)

-- โหลดรายการครั้งแรก
RefreshHistory()

-- แจ้งเตือนเมื่อ UI พร้อมใช้งาน
game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "X-WACK STORE",
	Text = "รวมระบบ Pisit G-Menu V7 สำเร็จแล้ว!",
	Duration = 5
})
