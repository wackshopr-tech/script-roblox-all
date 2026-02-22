local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local infiniteJump = false

local gui = Instance.new("ScreenGui")
gui.Name = "InfiniteJumpGUI"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 220, 0, 120)
main.Position = UDim2.new(0.5, -110, 0.4, -60)
main.BackgroundColor3 = Color3.fromRGB(45,45,45)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = false
main.Parent = gui
main.AnchorPoint = Vector2.new(0,0)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,16)
corner.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "Infinite Jump"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = main

local button = Instance.new("TextButton")
button.Size = UDim2.new(0.8,0,0,45)
button.Position = UDim2.new(0.1,0,0.55,0)
button.BackgroundColor3 = Color3.fromRGB(220,220,220)
button.TextColor3 = Color3.fromRGB(30,30,30)
button.Text = "OFF"
button.TextScaled = true
button.Font = Enum.Font.GothamBold
button.Parent = main

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0,12)
btnCorner.Parent = button

button.MouseButton1Click:Connect(function()
	infiniteJump = not infiniteJump
	if infiniteJump then
		button.Text = "ON"
		button.BackgroundColor3 = Color3.fromRGB(120,255,120)
	else
		button.Text = "OFF"
		button.BackgroundColor3 = Color3.fromRGB(220,220,220)
	end
end)

UserInputService.JumpRequest:Connect(function()
	if infiniteJump then
		local character = player.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end
	end
end)

local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	main.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

main.InputChanged:Connect(function(input)
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
