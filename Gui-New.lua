-- Nexus V2 UI Library (Premium Edition) - Fixed & Improved
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer

-- ==========================================
-- UI LIBRARY CORE
-- ==========================================
local Library = {}

-- ฟังก์ชันทำให้ UI ลากได้
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

function Library:NewWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "WACKSHOP_Fixed"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 550, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = true
    MainFrame.Parent = ScreenGui

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
    local Stroke = Instance.new("UIStroke", MainFrame)
    Stroke.Color = Color3.fromRGB(60, 60, 80)
    Stroke.Thickness = 1.5

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -50, 1, 0)
    TitleLabel.Position = UDim2.new(0, 20, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar

    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 140, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame

    local SidebarLayout = Instance.new("UIListLayout", Sidebar)
    SidebarLayout.Padding = UDim.new(0, 5)

    -- Container
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -150, 1, -50)
    ContentFrame.Position = UDim2.new(0, 145, 0, 45)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame

    -- Toggle Button (ปุ่มลอยเปิดปิด)
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
    ToggleBtn.Position = UDim2.new(0, 50, 0, 50)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    ToggleBtn.Text = "W"
    ToggleBtn.TextColor3 = Color3.fromRGB(0, 195, 255)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 25
    ToggleBtn.Parent = ScreenGui
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", ToggleBtn).Color = Color3.fromRGB(0, 195, 255)

    ToggleBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
        ToggleBtn.Text = MainFrame.Visible and "N" or "X"
    end)

    MakeDraggable(MainFrame, TitleBar)
    MakeDraggable(ToggleBtn, ToggleBtn)

    local Tabs = {}
    local WindowFunctions = {}

    function WindowFunctions:NewTab(name, icon)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(1, -10, 0, 35)
        TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = "  " .. icon .. " " .. name
        TabBtn.TextColor3 = Color3.fromRGB(150, 150, 170)
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.TextSize = 14
        TabBtn.TextXAlignment = Enum.TextXAlignment.Left
        TabBtn.Parent = Sidebar
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)

        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false
        TabContent.ScrollBarThickness = 2
        TabContent.CanvasSize = UDim2.new(0,0,0,0)
        TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabContent.Parent = ContentFrame
        Instance.new("UIListLayout", TabContent).Padding = UDim.new(0, 8)

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Tabs) do
                v.Btn.BackgroundTransparency = 1
                v.Content.Visible = false
            end
            TabBtn.BackgroundTransparency = 0.8
            TabContent.Visible = true
        end)

        table.insert(Tabs, {Btn = TabBtn, Content = TabContent})

        local TabFunctions = {}
        function TabFunctions:NewButton(text, callback)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, -5, 0, 35)
            Button.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            Button.Text = "   " .. text
            Button.TextColor3 = Color3.fromRGB(230, 230, 230)
            Button.Font = Enum.Font.Gotham
            Button.TextSize = 14
            Button.TextXAlignment = Enum.TextXAlignment.Left
            Button.Parent = TabContent
            Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

            Button.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
        end
        return TabFunctions
    end

    -- เปิดหน้าแรกอัตโนมัติ
    spawn(function()
        wait(0.1)
        if Tabs[1] then 
            Tabs[1].Btn.BackgroundTransparency = 0.8
            Tabs[1].Content.Visible = true 
        end
    end)

    return WindowFunctions
end

-- ==========================================
-- SCRIPT INITIALIZATION (ส่วนการใช้งาน)
-- ==========================================

local Window = Library:NewWindow("WACKSHOP V2 | GUI-New")

local Tab1 = Window:NewTab("หลัก", "🏠")
local Tab2 = Window:NewTab("โจมตี", "⚔️")
local Tab3 = Window:NewTab("เครื่องมือ", "🔧")
local Tab4 = Window:NewTab("แกล้ง", "🤡")
local Tab5 = Window:NewTab("ดวงตเทพมั้งง", "👁️")

-- หลัก
Tab1:NewButton("🔴 บิน", function() loadstring(game:HttpGet("https://pastebin.com/raw/iUVERBrs"))() end)
Tab1:NewButton("🔴 วิ่งเร็ว", function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100 end)
Tab1:NewButton("🔴 วาป", function() loadstring(game:HttpGet("https://pastebin.com/raw/K5FYvtvN"))() end)
Tab1:NewButton("🔴 ทะลุกำแพง", function() loadstring(game:HttpGet("https://pastebin.com/raw/7Qab6kg9"))() end)
Tab1:NewButton("🔴 หายตัว", function() loadstring(game:HttpGet("https://pastebin.com/raw/3Rnd9rHf"))() end)


-- โจมตี
Tab2:NewButton("🟠 ล็อคหัวผู้เล่น", function() loadstring(game:HttpGet("https://pastebin.com/raw/W46s2cTh"))() end)
Tab2:NewButton("🟠 ฆ่าบอทออร่า", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/kill-all-bot/killall-npc..lua"))() end)
Tab2:NewButton("🟠 Hitbox ", function() loadstring(game:HttpGet("https://pastebin.com/raw/iRyTtfmf"))() end)

-- เครื่องมือ
Tab3:NewButton("🟡 เพิ่มความลื่น", function() loadstring(game:HttpGet("https://pastebin.com/raw/mXhbHDVk"))() end)
Tab3:NewButton("🟡 เสกของ", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub-Backup/main/gametoolgiver.lua"))() end)
Tab3:NewButton("🟡 อมตะ", function() loadstring(game:HttpGet("https://pastebin.com/raw/EjrTrMwC"))() end)
Tab3:NewButton("🟡 Infinite Yield", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)
Tab3:NewButton("🟡 Kruel Admin", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Veaquach/kruel/refs/heads/main/kruel%20obf.txt"))() end)

-- แกล้ง
Tab4:NewButton("🟢 หลุมดำ", function() loadstring(game:HttpGet("https://pastebin.com/raw/pkZnU5P5"))() end)
Tab4:NewButton("🟢 เตะออกแมพ", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/FLINGCORE/FLINGCORE.lua"))() end)
Tab4:NewButton("🟢 ดึงคน false", function() loadstring(game:HttpGet("https://pastebin.com/raw/CuDBzSm6"))() end)
Tab4:NewButton("🟢 เสวขวย", function() loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))() end)
Tab4:NewButton("🟢 F3X ", function() loadstring(game:HttpGet("https://pastebin.com/raw/FZmTykdY"))() end)

-- มองทะลุ
Tab5:NewButton("🟣 ESP Players", function() loadstring(game:HttpGet("https://pastefy.app/hfNViKiG/raw"))() end)
Tab5:NewButton("🟣 ESP NPC", function() loadstring(game:HttpGet("https://pastefy.app/CWOTa3im/raw"))() end)

-- แจ้งเตือนเมื่อโหลดเสร็จ
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "WACKSHOP V2 Loaded";
    Text = "Enjoy WACKSHOP!";
    Duration = 5;
})
