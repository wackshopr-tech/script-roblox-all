local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local oldGui = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("CustomSpeedGui")
if oldGui then oldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SpeedInput = Instance.new("TextBox")
local ToggleBtn = Instance.new("TextButton")
local InfoText = Instance.new("TextLabel")

ScreenGui.Name = "CustomSpeedGui"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30,30,35)
MainFrame.Position = UDim2.new(0.5,-100,0.5,-90)
MainFrame.Size = UDim2.new(0,220,0,190)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,8)
MainCorner.Parent = MainFrame

Title.Parent = MainFrame
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "ปรับความเร็วรถ"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold

SpeedInput.Parent = MainFrame
SpeedInput.Position = UDim2.new(0.1,0,0.25,0)
SpeedInput.Size = UDim2.new(0.8,0,0,35)
SpeedInput.BackgroundColor3 = Color3.fromRGB(45,45,50)
SpeedInput.Text = "150"
SpeedInput.TextColor3 = Color3.fromRGB(0,255,150)
SpeedInput.TextSize = 16
SpeedInput.Font = Enum.Font.GothamMedium

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0,8)
InputCorner.Parent = SpeedInput

ToggleBtn.Parent = MainFrame
ToggleBtn.Position = UDim2.new(0.1,0,0.55,0)
ToggleBtn.Size = UDim2.new(0.8,0,0,45)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
ToggleBtn.Text = "OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
ToggleBtn.TextSize = 18
ToggleBtn.Font = Enum.Font.GothamBold

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0,8)
BtnCorner.Parent = ToggleBtn

InfoText.Parent = MainFrame
InfoText.Position = UDim2.new(0,0,0.85,0)
InfoText.Size = UDim2.new(1,0,0,20)
InfoText.BackgroundTransparency = 1
InfoText.Text = "By WACK SHOP"
InfoText.TextColor3 = Color3.fromRGB(150,150,150)
InfoText.TextSize = 12
InfoText.Font = Enum.Font.Gotham

local speedEnabled = false
local targetSpeed = 150
local speedConnection = nil

local function startSpeedHack()
    if speedConnection then
        speedConnection:Disconnect()
    end

    speedConnection = RunService.Heartbeat:Connect(function()
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildWhichIsA("Humanoid")
            if humanoid and humanoid.SeatPart and humanoid.SeatPart:IsA("VehicleSeat") then
                local seat = humanoid.SeatPart

                if seat.Throttle ~= 0 then
                    local currentY = seat.AssemblyLinearVelocity.Y
                    local direction = seat.CFrame.LookVector * (seat.Throttle * targetSpeed)
                    seat.AssemblyLinearVelocity = Vector3.new(direction.X,currentY,direction.Z)
                end
            end
        end
    end)
end

ToggleBtn.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled

    if speedEnabled then
        targetSpeed = tonumber(SpeedInput.Text)
        if not targetSpeed or targetSpeed < 1 then
            targetSpeed = 150
        end

        ToggleBtn.Text = "ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50,200,50)
        startSpeedHack()
    else
        ToggleBtn.Text = "OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)

        if speedConnection then
            speedConnection:Disconnect()
            speedConnection = nil
        end
    end
end)

UserInputService.InputBegan:Connect(function(input,gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
