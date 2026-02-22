local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local textButton = Instance.new("TextButton")
textButton.Parent = screenGui
textButton.Position = UDim2.new(0.8, 0, 0.1, 0)
textButton.Size = UDim2.new(0, 150, 0, 50)
textButton.Text = "ทะลุกำแพง: ปิด"
textButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton.Font = Enum.Font.GothamBold
textButton.TextSize = 16
textButton.AutoButtonColor = false
textButton.BorderSizePixel = 2
textButton.BorderColor3 = Color3.fromRGB(200, 200, 200)
textButton.Active = true
textButton.Draggable = true -- ✅ ทำให้ลาก UI ได้

-- เสียงตอนกดปุ่ม
local clickSound = Instance.new("Sound", textButton)
clickSound.SoundId = "rbxassetid://9117665351"
clickSound.Volume = 1

-- เอฟเฟกต์ตอนโฮเวอร์
textButton.MouseEnter:Connect(function()
    textButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)

textButton.MouseLeave:Connect(function()
    textButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

textButton.MouseButton1Down:Connect(function()
    textButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

textButton.MouseButton1Up:Connect(function()
    textButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)

-- ตัวแปรสำหรับสถานะการทะลุ
local canCollide = true

-- ฟังก์ชันสำหรับเปิด/ปิดการทะลุ
textButton.MouseButton1Click:Connect(function()
    canCollide = not canCollide
    clickSound:Play()  

    if canCollide then
        textButton.Text = "ทะลุกำแพง: ปิด"
        textButton.BorderColor3 = Color3.fromRGB(200, 200, 200)
    else
        textButton.Text = "ทะลุกำแพง: เปิด"
        textButton.BorderColor3 = Color3.fromRGB(0, 255, 0)
    end
end)

-- ฟังก์ชันสำหรับเปิด/ปิดการชน
game:GetService("RunService").Heartbeat:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if character then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = canCollide
            end
        end
    end
end)
