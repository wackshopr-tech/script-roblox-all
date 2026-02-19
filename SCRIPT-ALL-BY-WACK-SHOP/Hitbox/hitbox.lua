local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WACKSHOP_HITBOX"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.fromOffset(240, 180)
mainFrame.Position = UDim2.fromScale(0.7, 0.15)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = false
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(0,170,255)
stroke.Thickness = 1.5

-- =========================
-- DRAG SYSTEM (Mobile + PC)
-- =========================

local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	mainFrame.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- =========================

local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = mainFrame
titleLabel.Size = UDim2.new(1, 0, 0, 35)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "HITBOX CONTROLLER"
titleLabel.TextColor3 = Color3.fromRGB(0,200,255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16

local credit = Instance.new("TextLabel")
credit.Parent = mainFrame
credit.Size = UDim2.new(1, 0, 0, 18)
credit.Position = UDim2.new(0,0,1,-20)
credit.BackgroundTransparency = 1
credit.Text = "By WACK SHOP"
credit.TextColor3 = Color3.fromRGB(120,170,255)
credit.Font = Enum.Font.Gotham
credit.TextSize = 11

local textBox = Instance.new("TextBox")
textBox.Parent = mainFrame
textBox.Position = UDim2.new(0.1, 0, 0.32, 0)
textBox.Size = UDim2.new(0.8, 0, 0, 32)
textBox.Text = "32"
textBox.ClearTextOnFocus = false
textBox.TextColor3 = Color3.fromRGB(255,255,255)
textBox.Font = Enum.Font.GothamSemibold
textBox.TextSize = 15
textBox.BackgroundColor3 = Color3.fromRGB(25, 35, 60)
textBox.BorderSizePixel = 0
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0,10)

local toggleButton = Instance.new("TextButton")
toggleButton.Parent = mainFrame
toggleButton.Position = UDim2.new(0.1, 0, 0.58, 0)
toggleButton.Size = UDim2.new(0.8, 0, 0, 40)
toggleButton.Text = "▶ เปิด Hitbox"
toggleButton.BackgroundColor3 = Color3.fromRGB(0,100,200)
toggleButton.TextColor3 = Color3.fromRGB(255,255,255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 15
toggleButton.BorderSizePixel = 0
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0,12)

local clickSound = Instance.new("Sound")
clickSound.Parent = toggleButton
clickSound.SoundId = "rbxassetid://9117665351"
clickSound.Volume = 1

_G.HeadSize = tonumber(textBox.Text) or 32
_G.Disabled = true

textBox.FocusLost:Connect(function()
	local newSize = tonumber(textBox.Text)
	if newSize then
		_G.HeadSize = newSize
	else
		textBox.Text = tostring(_G.HeadSize)
	end
end)

toggleButton.MouseButton1Click:Connect(function()
	_G.Disabled = not _G.Disabled
	clickSound:Play()

	if _G.Disabled then
		toggleButton.Text = "▶ เปิด Hitbox"
		toggleButton.BackgroundColor3 = Color3.fromRGB(0,100,200)
	else
		toggleButton.Text = "■ ปิด Hitbox"
		toggleButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
	end
end)

RunService.RenderStepped:Connect(function()
	if not _G.Disabled then
		for _, v in pairs(Players:GetPlayers()) do
			if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				pcall(function()
					local hrp = v.Character.HumanoidRootPart
					hrp.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
					hrp.Transparency = 0.6
					hrp.Material = Enum.Material.Neon
					hrp.Color = Color3.fromRGB(0,170,255)
					hrp.CanCollide = false
				end)
			end
		end
	end
end)
