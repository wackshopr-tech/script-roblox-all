
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

pcall(function()
    CoreGui:FindFirstChild("ProLoaderGUI"):Destroy()
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ProLoaderGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.Size = UDim2.fromOffset(420, 260)
Main.BackgroundColor3 = Color3.fromRGB(20,20,25)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,18)

local function label(text, y, size, bold)
    local l = Instance.new("TextLabel", Main)
    l.Position = UDim2.fromOffset(20, y)
    l.Size = size
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(255,255,255)
    l.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextSize = bold and 22 or 14
    l.TextXAlignment = Enum.TextXAlignment.Left
    return l
end

label("WACK SHOP", 15, UDim2.new(1,-40,0,40), true)
label("WACK SHOP ได้เพิ่มระบบ GUI ทั้ง 2 แบบเพื่อสดวกต่อการใช้งานของทุกคน !!! ", 55, UDim2.new(1,-40,0,20), false)

local function button(text, y)
    local b = Instance.new("TextButton", Main)
    b.Position = UDim2.fromOffset(30, y)
    b.Size = UDim2.new(1,-60,0,55)
    b.Text = text
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 18
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(35,35,50)
    b.AutoButtonColor = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,14)
    return b
end

local oldBtn = button("▶ GUI เวอร์ชั่น เก่า", 100)
local newBtn = button("▶ GUI เวอร์ชั่น ใหม่", 170)

local function runScript(url)
    task.spawn(function()
        local src
        local ok, err = pcall(function()
            src = game:HttpGet(url, true)
        end)

        if not ok or not src then
            warn("❌ HttpGet Failed:", err)
            return
        end

        local func, loadErr = loadstring(src)
        if not func then
            warn("❌ Loadstring Failed:", loadErr)
            return
        end

        ScreenGui:Destroy()

        func()
    end)
end

oldBtn.MouseButton1Click:Connect(function()
    runScript("https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/script-wack-all.lua")
end)

newBtn.MouseButton1Click:Connect(function()
    runScript("https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/Gui-New.lua")
end)
