local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--==================================================
-- X-WACK STORE CLEANUP
--==================================================

pcall(function()
	local OldGui = CoreGui:FindFirstChild("X-WACK_STORE")
	if OldGui then
		OldGui:Destroy()
	end
end)

local Library = {}

--==================================================
-- DRAG SYSTEM
--==================================================

local function MakeDraggable(frame, handle)
	local dragging = false
	local dragInput
	local dragStart
	local startPos

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	handle.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then

			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging and frame and frame.Parent then
			local delta = input.Position - dragStart

			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

--==================================================
-- WINDOW
--==================================================

function Library:NewWindow(title)

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "X-WACK_STORE"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = false
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Parent = CoreGui

	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "X-WACK_STORE_MainFrame"
	MainFrame.Size = UDim2.fromOffset(480, 310)
	MainFrame.Position = UDim2.new(0.5, -240, 0.5, -155)
	MainFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
	MainFrame.BorderSizePixel = 0
	MainFrame.Visible = true
	MainFrame.ClipsDescendants = false
	MainFrame.Parent = ScreenGui

	Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

	--==================================================
	-- RESIZE SYSTEM
	--==================================================

	local MIN_WIDTH = 340
	local MIN_HEIGHT = 230

	local MAX_WIDTH = 900
	local MAX_HEIGHT = 650

	local function GetViewport()
		local CurrentCamera = workspace.CurrentCamera

		if CurrentCamera then
			return CurrentCamera.ViewportSize
		end

		return Vector2.new(1920, 1080)
	end

	local function GetMaxSize()
		local viewport = GetViewport()

		local maxWidth = math.max(
			MIN_WIDTH,
			math.min(MAX_WIDTH, viewport.X - 20)
		)

		local maxHeight = math.max(
			MIN_HEIGHT,
			math.min(MAX_HEIGHT, viewport.Y - 20)
		)

		return maxWidth, maxHeight
	end

	local function ClampMainFrame()
		if not MainFrame or not MainFrame.Parent then
			return
		end

		local viewport = GetViewport()

		local absolutePosition = MainFrame.AbsolutePosition
		local absoluteSize = MainFrame.AbsoluteSize

		local offsetX = MainFrame.Position.X.Offset
		local offsetY = MainFrame.Position.Y.Offset

		if absolutePosition.X < 0 then
			offsetX = offsetX - absolutePosition.X
		elseif absolutePosition.X + absoluteSize.X > viewport.X then
			offsetX = offsetX - (
				absolutePosition.X + absoluteSize.X - viewport.X
			)
		end

		if absolutePosition.Y < 0 then
			offsetY = offsetY - absolutePosition.Y
		elseif absolutePosition.Y + absoluteSize.Y > viewport.Y then
			offsetY = offsetY - (
				absolutePosition.Y + absoluteSize.Y - viewport.Y
			)
		end

		MainFrame.Position = UDim2.new(
			MainFrame.Position.X.Scale,
			offsetX,
			MainFrame.Position.Y.Scale,
			offsetY
		)
	end

	--==================================================
	-- GLOW
	--==================================================

	local GlowFrame = Instance.new("Frame")
	GlowFrame.Name = "X-WACK_STORE_Glow"
	GlowFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	GlowFrame.Position = UDim2.fromScale(0.5, 0.5)
	GlowFrame.Size = UDim2.new(1, 10, 1, 10)
	GlowFrame.BackgroundTransparency = 1
	GlowFrame.ZIndex = 0
	GlowFrame.Parent = MainFrame

	Instance.new("UICorner", GlowFrame).CornerRadius = UDim.new(0, 13)

	local GlowStroke = Instance.new("UIStroke")
	GlowStroke.Thickness = 5
	GlowStroke.Transparency = 0.6
	GlowStroke.Parent = GlowFrame

	local Stroke = Instance.new("UIStroke")
	Stroke.Thickness = 1.2
	Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	Stroke.Parent = MainFrame

	local UIGradient = Instance.new("UIGradient")
	UIGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(
			0,
			Color3.fromRGB(0, 210, 255)
		),

		ColorSequenceKeypoint.new(
			0.5,
			Color3.fromRGB(255, 0, 130)
		),

		ColorSequenceKeypoint.new(
			1,
			Color3.fromRGB(0, 210, 255)
		)
	})
	UIGradient.Parent = Stroke

	local GUIAlive = true

	task.spawn(function()
		local rotation = 0

		while GUIAlive and ScreenGui.Parent do
			task.wait(0.03)

			rotation = (rotation + 1.5) % 360

			UIGradient.Rotation = rotation

			GlowStroke.Color = Color3.fromHSV(
				rotation / 360,
				0.75,
				1
			)
		end
	end)

	--==================================================
	-- TITLE BAR
	--==================================================

	local TitleBar = Instance.new("Frame")
	TitleBar.Name = "X-WACK_STORE_TitleBar"
	TitleBar.Size = UDim2.new(1, 0, 0, 36)
	TitleBar.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
	TitleBar.BorderSizePixel = 0
	TitleBar.Parent = MainFrame

	Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Name = "X-WACK_STORE_Title"
	TitleLabel.Size = UDim2.new(1, -70, 1, 0)
	TitleLabel.Position = UDim2.new(0, 14, 0, 0)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text = title
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextSize = 14
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Parent = TitleBar

	--==================================================
	-- CLOSE BUTTON
	--==================================================

	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Name = "X-WACK_STORE_Close"
	CloseBtn.Size = UDim2.fromOffset(22, 22)
	CloseBtn.Position = UDim2.new(1, -30, 0, 7)
	CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 45, 75)
	CloseBtn.Text = "✕"
	CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseBtn.Font = Enum.Font.GothamBold
	CloseBtn.TextSize = 11
	CloseBtn.AutoButtonColor = false
	CloseBtn.Parent = TitleBar

	Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

	local closing = false

	CloseBtn.MouseButton1Click:Connect(function()
		if closing then
			return
		end

		closing = true

		TweenService:Create(
			MainFrame,
			TweenInfo.new(
				0.25,
				Enum.EasingStyle.Quart,
				Enum.EasingDirection.In
			),
			{
				Size = UDim2.fromOffset(0, 0)
			}
		):Play()

		task.wait(0.25)

		GUIAlive = false

		if ScreenGui then
			ScreenGui:Destroy()
		end
	end)

	--==================================================
	-- SIDEBAR
	--==================================================

	local Sidebar = Instance.new("Frame")
	Sidebar.Name = "X-WACK_STORE_Sidebar"
	Sidebar.Size = UDim2.new(0, 130, 1, -42)
	Sidebar.Position = UDim2.new(0, 4, 0, 38)
	Sidebar.BackgroundColor3 = Color3.fromRGB(18, 19, 26)
	Sidebar.BorderSizePixel = 0
	Sidebar.Parent = MainFrame

	Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

	local SidebarList = Instance.new("ScrollingFrame")
	SidebarList.Name = "X-WACK_STORE_TabList"
	SidebarList.Size = UDim2.new(1, -6, 1, -8)
	SidebarList.Position = UDim2.new(0, 3, 0, 4)
	SidebarList.BackgroundTransparency = 1
	SidebarList.BorderSizePixel = 0
	SidebarList.ScrollBarThickness = 2
	SidebarList.CanvasSize = UDim2.new(0, 0, 0, 0)
	SidebarList.AutomaticCanvasSize = Enum.AutomaticSize.Y
	SidebarList.Parent = Sidebar

	local SidebarLayout = Instance.new("UIListLayout")
	SidebarLayout.Padding = UDim.new(0, 4)
	SidebarLayout.Parent = SidebarList

	--==================================================
	-- CONTENT
	--==================================================

	local ContentFrame = Instance.new("Frame")
	ContentFrame.Name = "X-WACK_STORE_Content"
	ContentFrame.Size = UDim2.new(1, -144, 1, -44)
	ContentFrame.Position = UDim2.new(0, 138, 0, 40)
	ContentFrame.BackgroundTransparency = 1
	ContentFrame.Parent = MainFrame

	--==================================================
	-- TOGGLE BUTTON
	--==================================================

	local ToggleBtn = Instance.new("TextButton")
	ToggleBtn.Name = "X-WACK_STORE_Toggle"
	ToggleBtn.Size = UDim2.fromOffset(36, 36)
	ToggleBtn.Position = UDim2.new(0, 20, 0, 20)
	ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
	ToggleBtn.Text = "X"
	ToggleBtn.TextColor3 = Color3.fromRGB(0, 210, 255)
	ToggleBtn.Font = Enum.Font.GothamBold
	ToggleBtn.TextSize = 16
	ToggleBtn.AutoButtonColor = false
	ToggleBtn.Parent = ScreenGui

	Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

	local ToggleStroke = Instance.new("UIStroke")
	ToggleStroke.Color = Color3.fromRGB(0, 210, 255)
	ToggleStroke.Thickness = 1.2
	ToggleStroke.Parent = ToggleBtn

	ToggleBtn.MouseButton1Click:Connect(function()
		if not MainFrame or not MainFrame.Parent then
			return
		end

		MainFrame.Visible = not MainFrame.Visible

		if MainFrame.Visible then
			ToggleBtn.Text = "X"
			ToggleBtn.TextColor3 = Color3.fromRGB(0, 210, 255)
		else
			ToggleBtn.Text = "W"
			ToggleBtn.TextColor3 = Color3.fromRGB(255, 0, 130)
		end

		ToggleStroke.Color = ToggleBtn.TextColor3
	end)

	--==================================================
	-- RESIZE HANDLE
	--==================================================

	local ResizeHandle = Instance.new("TextButton")
	ResizeHandle.Name = "X-WACK_STORE_Resize"
	ResizeHandle.AnchorPoint = Vector2.new(1, 1)
	ResizeHandle.Position = UDim2.new(1, -5, 1, -5)
	ResizeHandle.Size = UDim2.fromOffset(24, 24)
	ResizeHandle.BackgroundColor3 = Color3.fromRGB(28, 31, 43)
	ResizeHandle.Text = "↘"
	ResizeHandle.TextColor3 = Color3.fromRGB(0, 210, 255)
	ResizeHandle.Font = Enum.Font.GothamBold
	ResizeHandle.TextSize = 15
	ResizeHandle.AutoButtonColor = false
	ResizeHandle.ZIndex = 50
	ResizeHandle.Parent = MainFrame

	Instance.new("UICorner", ResizeHandle).CornerRadius = UDim.new(0, 6)

	local ResizeStroke = Instance.new("UIStroke")
	ResizeStroke.Color = Color3.fromRGB(0, 210, 255)
	ResizeStroke.Transparency = 0.35
	ResizeStroke.Thickness = 1
	ResizeStroke.Parent = ResizeHandle

	local resizing = false
	local resizeInput
	local resizeStart
	local startSize

	ResizeHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			resizing = true
			resizeInput = input
			resizeStart = input.Position
			startSize = MainFrame.AbsoluteSize
		end
	end)

	ResizeHandle.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then

			resizeInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not resizing then
			return
		end

		if input ~= resizeInput then
			return
		end

		if not MainFrame or not MainFrame.Parent then
			resizing = false
			return
		end

		local delta = input.Position - resizeStart

		local maxWidth, maxHeight = GetMaxSize()

		local width = math.clamp(
			startSize.X + delta.X,
			MIN_WIDTH,
			maxWidth
		)

		local height = math.clamp(
			startSize.Y + delta.Y,
			MIN_HEIGHT,
			maxHeight
		)

		MainFrame.Size = UDim2.fromOffset(
			width,
			height
		)

		ClampMainFrame()
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input == resizeInput
			or input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			resizing = false
			resizeInput = nil
		end
	end)

	--==================================================
	-- VIEWPORT PROTECTION
	--==================================================

	local CurrentCamera = workspace.CurrentCamera

	if CurrentCamera then
		CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()

			if not MainFrame or not MainFrame.Parent then
				return
			end

			local maxWidth, maxHeight = GetMaxSize()

			local currentSize = MainFrame.AbsoluteSize

			MainFrame.Size = UDim2.fromOffset(
				math.clamp(
					currentSize.X,
					MIN_WIDTH,
					maxWidth
				),

				math.clamp(
					currentSize.Y,
					MIN_HEIGHT,
					maxHeight
				)
			)

			task.defer(ClampMainFrame)
		end)
	end

	MakeDraggable(MainFrame, TitleBar)
	MakeDraggable(ToggleBtn, ToggleBtn)

	--==================================================
	-- TABS
	--==================================================

	local Tabs = {}
	local WindowFunctions = {}

	function WindowFunctions:NewTab(name, icon)

		local TabBtn = Instance.new("TextButton")
		TabBtn.Name = "X-WACK_STORE_Tab_" .. name
		TabBtn.Size = UDim2.new(1, 0, 0, 30)
		TabBtn.BackgroundColor3 = Color3.fromRGB(24, 26, 36)
		TabBtn.BackgroundTransparency = 0.6
		TabBtn.Text = "  " .. icon .. "  " .. name
		TabBtn.TextColor3 = Color3.fromRGB(170, 175, 190)
		TabBtn.Font = Enum.Font.GothamBold
		TabBtn.TextSize = 12
		TabBtn.TextXAlignment = Enum.TextXAlignment.Left
		TabBtn.AutoButtonColor = false
		TabBtn.Parent = SidebarList

		Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

		local TabStroke = Instance.new("UIStroke")
		TabStroke.Thickness = 1
		TabStroke.Color = Color3.fromRGB(0, 210, 255)
		TabStroke.Transparency = 1
		TabStroke.Parent = TabBtn

		local TabContent = Instance.new("ScrollingFrame")
		TabContent.Name = "X-WACK_STORE_Content_" .. name
		TabContent.Size = UDim2.new(1, -4, 1, 0)
		TabContent.BackgroundTransparency = 1
		TabContent.BorderSizePixel = 0
		TabContent.Visible = false
		TabContent.ScrollBarThickness = 2
		TabContent.ScrollBarImageColor3 = Color3.fromRGB(0, 210, 255)
		TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
		TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
		TabContent.Parent = ContentFrame

		local ContentLayout = Instance.new("UIListLayout")
		ContentLayout.Padding = UDim.new(0, 5)
		ContentLayout.Parent = TabContent

		TabBtn.MouseButton1Click:Connect(function()

			for _, tab in pairs(Tabs) do
				TweenService:Create(
					tab.Btn,
					TweenInfo.new(0.15),
					{
						BackgroundTransparency = 0.6,
						TextColor3 = Color3.fromRGB(170, 175, 190)
					}
				):Play()

				TweenService:Create(
					tab.Stroke,
					TweenInfo.new(0.15),
					{
						Transparency = 1
					}
				):Play()

				tab.Content.Visible = false
			end

			TweenService:Create(
				TabBtn,
				TweenInfo.new(0.15),
				{
					BackgroundTransparency = 0,
					TextColor3 = Color3.fromRGB(255, 255, 255)
				}
			):Play()

			TweenService:Create(
				TabStroke,
				TweenInfo.new(0.15),
				{
					Transparency = 0
				}
			):Play()

			TabContent.Visible = true
		end)

		table.insert(Tabs, {
			Btn = TabBtn,
			Content = TabContent,
			Stroke = TabStroke
		})

		local TabFunctions = {}

		function TabFunctions:NewButton(text, callback)

			local Button = Instance.new("TextButton")
			Button.Name = "X-WACK_STORE_Button"
			Button.Size = UDim2.new(1, -6, 0, 30)
			Button.BackgroundColor3 = Color3.fromRGB(24, 27, 38)
			Button.Text = "   " .. text
			Button.TextColor3 = Color3.fromRGB(240, 242, 250)
			Button.Font = Enum.Font.GothamMedium
			Button.TextSize = 12
			Button.TextXAlignment = Enum.TextXAlignment.Left
			Button.AutoButtonColor = false
			Button.Parent = TabContent

			Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

			local BtnStroke = Instance.new("UIStroke")
			BtnStroke.Thickness = 1
			BtnStroke.Color = Color3.fromRGB(0, 210, 255)
			BtnStroke.Transparency = 0.85
			BtnStroke.Parent = Button

			Button.MouseEnter:Connect(function()
				TweenService:Create(
					Button,
					TweenInfo.new(0.15),
					{
						BackgroundColor3 = Color3.fromRGB(32, 36, 52)
					}
				):Play()

				TweenService:Create(
					BtnStroke,
					TweenInfo.new(0.15),
					{
						Transparency = 0.2
					}
				):Play()
			end)

			Button.MouseLeave:Connect(function()
				TweenService:Create(
					Button,
					TweenInfo.new(0.15),
					{
						BackgroundColor3 = Color3.fromRGB(24, 27, 38)
					}
				):Play()

				TweenService:Create(
					BtnStroke,
					TweenInfo.new(0.15),
					{
						Transparency = 0.85
					}
				):Play()
			end)

			Button.MouseButton1Click:Connect(function()

				TweenService:Create(
					Button,
					TweenInfo.new(0.08),
					{
						Size = UDim2.new(1, -10, 0, 28)
					}
				):Play()

				task.wait(0.08)

				if Button and Button.Parent then
					TweenService:Create(
						Button,
						TweenInfo.new(0.08),
						{
							Size = UDim2.new(1, -6, 0, 30)
						}
					):Play()
				end

				if typeof(callback) == "function" then
					local success, err = pcall(callback)

					if not success then
						warn(
							"[X-WACK_STORE] Button Error:",
							err
						)
					end
				end
			end)
		end

		return TabFunctions
	end

	task.spawn(function()
		task.wait(0.1)

		if Tabs[1] then
			Tabs[1].Btn.BackgroundTransparency = 0
			Tabs[1].Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			Tabs[1].Stroke.Transparency = 0
			Tabs[1].Content.Visible = true
		end
	end)

	return WindowFunctions
end

--==================================================
-- X-WACK STORE
--==================================================

local Window = Library:NewWindow(
	"X-WACK STORE  |  X-WACK STORE V2"
)

local Tab1 = Window:NewTab("หลัก", "🏠")
local Tab2 = Window:NewTab("โจมตี", "⚔️")
local Tab3 = Window:NewTab("เครื่องมือ", "🔧")
local Tab4 = Window:NewTab("แกล้ง", "🤡")
local Tab5 = Window:NewTab("ดวงตาเทพ", "👁️")

--==================================================
-- TAB 1
--==================================================

Tab1:NewButton("🔴 บิน (Fly V3)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/Fly%20V3/Fly-V3.lua"
	))()
end)

Tab1:NewButton("🔴 กระโดดไม่จำกัด", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/Infinite%20Jump/Infinite-Jump.lua"
	))()
end)

Tab1:NewButton("🔴 วิ่งเร็ว (Speed 100)", function()
	local character = Player.Character

	if not character then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid.WalkSpeed = 100
	end
end)

Tab1:NewButton("🔴 วาร์ปตามเมาส์ (Click TP)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/Click%20TP/Click-TP.lua"
	))()
end)

Tab1:NewButton("🔴 ทะลุกำแพง (Noclip)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/Through%20the%20wall/main.lua"
	))()
end)

Tab1:NewButton("🔴 หายตัว (Invisible)", function()
	loadstring(game:HttpGet(
		"https://pastebin.com/raw/3Rnd9rHf"
	))()
end)

Tab1:NewButton("🔴 โหมดอมตะ (God Mode)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/GOD-MAIN/GOD-MAIN.lua"
	))()
end)

--==================================================
-- TAB 2
--==================================================

Tab2:NewButton("🟠 ล็อคหัวผู้เล่น (Aimbot)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/aimbot/aimbot.lua"
	))()
end)

Tab2:NewButton("🟠 ฆ่าบอทออร่า (Kill All NPC)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/kill-all-bot/killall-npc..lua"
	))()
end)

Tab2:NewButton("🟠 ขยายขนาดขอบเขต (Hitbox)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/Hitbox/hitbox.lua"
	))()
end)

--==================================================
-- TAB 3
--==================================================

Tab3:NewButton("🟡 เพิ่มความลื่น (FPS Boost)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/Boots-fps/Boots-fps.lua"
	))()
end)

Tab3:NewButton("🟡 แมพสว่าง (Fullbright)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/Lighting/Lighting.lua"
	))()
end)

Tab3:NewButton("🟡 เสกของ (Conjure Items)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/conjure%20things/conjure-things.lua"
	))()
end)

Tab3:NewButton("🟡 แป้นพิมพ์บนหน้าจอ (Keyboard)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/Xxtan31/Ata/main/deltakeyboardcrack.txt"
	))()
end)

Tab3:NewButton("🟡 ปรับความเร็วรถ (Car Speed)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/Speed-car/Speed-car.lua"
	))()
end)

Tab3:NewButton("🟡 Infinite Yield (คำสั่งพรีเมียม)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"
	))()
end)

Tab3:NewButton("🟡 Quirky CMD", function()
	loadstring(game:HttpGet(
		"https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"
	))()
end)

--==================================================
-- TAB 4
--==================================================

Tab4:NewButton("🟢 หลุมดำ (Blackhole)", function()
	loadstring(game:HttpGet(
		"https://pastebin.com/raw/pkZnU5P5"
	))()
end)

Tab4:NewButton("🟢 ชนกระเด็น (Fling All)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/FLINGCORE/FLINGCORE.lua"
	))()
end)

Tab4:NewButton("🟢 ดึงคน (Pull People)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/pull%20false%20people/pull-false-people.lua"
	))()
end)

Tab4:NewButton("🟢 ท่าทางพิเศษ (Bang Anim)", function()
	loadstring(game:HttpGet(
		"https://pastefy.app/wa3v2Vgm/raw"
	))()
end)

Tab4:NewButton("🟢 เครื่องมือ F3X", function()
	loadstring(game:HttpGet(
		"https://pastebin.com/raw/FZmTykdY"
	))()
end)

--==================================================
-- TAB 5
--==================================================

Tab5:NewButton("🟣 ESP ผู้เล่น (ESP Players)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/EPS-MAP-ALL/EPS-MAP-ALL.lua"
	))()
end)

Tab5:NewButton("🟣 ESP บอท (ESP NPC)", function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/ESP-NPC/ESP-NPC.lua"
	))()
end)

--==================================================
-- NOTIFICATION
--==================================================

pcall(function()
	StarterGui:SetCore("SendNotification", {
		Title = "X-WACK STORE",
		Text = "X-WACK STORE V2 โหลดเสร็จสิ้นแล้ว!",
		Duration = 5
	})
end)
