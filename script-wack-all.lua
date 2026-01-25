local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local discordLink = "https://discord.gg/Tr67FCsEm8"
if setclipboard then
    setclipboard(discordLink)
    print("✅ คัดลอกลิงก์ Discord แล้ว: " .. discordLink)
elseif syn and syn.write_clipboard then
    syn.write_clipboard(discordLink)
    print("✅ คัดลอกลิงก์ Discord แล้ว: " .. discordLink)
elseif Clipboard and Clipboard.set then
    Clipboard.set(discordLink)
    print("✅ คัดลอกลิงก์ Discord แล้ว: " .. discordLink)
else
    print("⚠️ Executor ของคุณไม่รองรับการคัดลอกคลิปบอร์ด ลิงก์ Discord: " .. discordLink)
end
spawn(function()
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Cyber Nuvex";
            Text = "คัดลอกลิงก์ Discord แล้ว!\nเข้าร่วมเลย: " .. discordLink;
            Duration = 8;
        })
    end)
end)
local function createUI()
    if CoreGui:FindFirstChild("WACKShopUI") then
        CoreGui.WACKShopUI:Destroy()
    end
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "WACKShopUI"
    ScreenGui.ResetOnSpawn = false
    pcall(function()
        syn.protect_gui(ScreenGui)
    end)
    ScreenGui.Parent = CoreGui
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    MainFrame.Size = UDim2.new(0, 350, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Active = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 3
    MainStroke.Transparency = 0.3
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local MainGrad = Instance.new("UIGradient", MainStroke)
    MainGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 50, 150)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255))
    }
    MainGrad.Rotation = 45
    local TitleLabel1 = Instance.new("TextLabel")
    TitleLabel1.Parent = MainFrame
    TitleLabel1.BackgroundTransparency = 1
    TitleLabel1.Size = UDim2.new(1, 0, 0, 50)
    TitleLabel1.Position = UDim2.new(0, 0, 0, 5)
    TitleLabel1.Font = Enum.Font.GothamBlack
    TitleLabel1.Text = "👑 Cyber Nuvex 👑"
    TitleLabel1.TextSize = 26
    TitleLabel1.TextColor3 = Color3.fromRGB(255, 255, 255)
    local Grad1 = Instance.new("UIGradient", TitleLabel1)
    Grad1.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 80, 180)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
    }
    local TitleLabel2 = Instance.new("TextLabel")
    TitleLabel2.Parent = MainFrame
    TitleLabel2.BackgroundTransparency = 1
    TitleLabel2.Size = UDim2.new(1, 0, 0, 40)
    TitleLabel2.Position = UDim2.new(0, 0, 0, 50)
    TitleLabel2.Font = Enum.Font.GothamBold
    TitleLabel2.Text = "การกลับมาของ WACK SHOP"
    TitleLabel2.TextSize = 16
    TitleLabel2.TextColor3 = Color3.fromRGB(180, 220, 255)
    local FunctionButtonsFrame = Instance.new("ScrollingFrame")
    FunctionButtonsFrame.Parent = MainFrame
    FunctionButtonsFrame.BackgroundTransparency = 1
    FunctionButtonsFrame.Size = UDim2.new(1, -20, 1, -100)
    FunctionButtonsFrame.Position = UDim2.new(0, 10, 0, 90)
    FunctionButtonsFrame.ScrollBarThickness = 5
    FunctionButtonsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    FunctionButtonsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    local functionCategories = {
        ["🏃 การเคลื่อนที่"] = {
            ["🚀 บิน / fly"] = "https://pastebin.com/raw/iUVERBrs",
            ["🔥 วาป / คลิก"] = "https://pastebin.com/raw/K5FYvtvN",
            ["🦴 ทะลุกำแพง / ปุ่ม"] = "https://pastebin.com/raw/7Qab6kg9",
            ["🏃 วิ่งเร็ว 4 เท่า"] = "https://pastebin.com/raw/pZhkm5mD"
        },
        ["⚔️ การโจมตี"] = {
            ["⚔️ ฆ่าบอท ทุกตัว"] = "https://pastebin.com/raw/DczvQZyU",
            ["🎯 ล็อคหัวผู้เล่น"] = "https://pastebin.com/raw/W46s2cTh"
        },
        ["🔧 เครื่องมือช่วยเล่น"] = {
            ["🎁 เสกของ"] = "https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub-Backup/main/gametoolgiver.lua",
            ["🔥 บูส FPS"] = "https://pastebin.com/raw/mXhbHDVk",
            ["🎩 Hitbox 32%"] = "https://pastebin.com/raw/iRyTtfmf",
            ["💪🏻 อมตะ"] = "https://pastebin.com/raw/EjrTrMwC",
            ["👾 คีย์บอร์ด"] = "https://raw.githubusercontent.com/Xxtan31/Ata/main/deltakeyboardcrack.txt",
            ["👻 หายตัว"] = "https://pastebin.com/raw/3Rnd9rHf"
        },
        ["😈 ปั่นประสาทผู้เล่น"] = {
            ["🌌 หลุมดำ"] = "https://pastebin.com/raw/pkZnU5P5",
            ["🥴 ชักว่าว"] = "https://pastefy.app/wa3v2Vgm/raw",
            ["⬜ F3X "] = "https://pastebin.com/raw/FZmTykdY",
            ["🌟 ดึงคน false"] = "https://pastebin.com/raw/CuDBzSm6"
        },
        ["🔍 ESP & การมองเห็น"] = {
            ["🔍 ESP Players"] = "https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/EPS-MAP-ALL/EPS-MAP-ALL.lua",
            ["🤖 ESP BOT,NPC"] = "https://pastebin.com/raw/q26QuUBF"
        }
    }
    local yOffset = 0
    for category, scripts in pairs(functionCategories) do
        local label = Instance.new("TextLabel")
        label.Parent = FunctionButtonsFrame
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(1, -20, 0, 30)
        label.Position = UDim2.new(0, 10, 0, yOffset)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 18
        label.TextColor3 = Color3.fromRGB(100, 200, 255)
        label.Text = category
        label.TextXAlignment = Enum.TextXAlignment.Left
        local underline = Instance.new("Frame")
        underline.Parent = label
        underline.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        underline.Size = UDim2.new(0.4, 0, 0, 3)
        underline.Position = UDim2.new(0, 0, 1, -3)
        underline.BorderSizePixel = 0
        local uGrad = Instance.new("UIGradient", underline)
        uGrad.Color = ColorSequence.new(Color3.fromRGB(0, 180, 255), Color3.fromRGB(255, 60, 120))
        yOffset += 35
        for name, url in pairs(scripts) do
            local btn = Instance.new("TextButton")
            btn.Parent = FunctionButtonsFrame
            btn.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
            btn.Size = UDim2.new(1, -20, 0, 40)
            btn.Position = UDim2.new(0, 10, 0, yOffset)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 16
            btn.TextColor3 = Color3.fromRGB(230, 230, 255)
            btn.Text = name
            btn.AutoButtonColor = false
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
            local btnStroke = Instance.new("UIStroke", btn)
            btnStroke.Thickness = 2
            btnStroke.Transparency = 0.6
            local btnGrad = Instance.new("UIGradient", btnStroke)
            btnGrad.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 0, 120))
            }
            btn.MouseEnter:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 80)}):Play()
                TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.2}):Play()
            end)
            btn.MouseLeave:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 45)}):Play()
                TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.6}):Play()
            end)
            btn.MouseButton1Click:Connect(function()
                TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
                TweenService:Create(btnStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 0.6}):Play()
                loadstring(game:HttpGet(url))()
            end)
            yOffset += 45
        end
        yOffset += 15
    end
    local Toggle = Instance.new("TextButton")
    Toggle.Parent = ScreenGui
    Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    Toggle.Size = UDim2.new(0, 50, 0, 50)
    Toggle.Position = UDim2.new(0, 60, 0, 60)
    Toggle.Font = Enum.Font.GothamBlack
    Toggle.Text = "W"
    Toggle.TextSize = 28
    Toggle.TextColor3 = Color3.fromRGB(0, 200, 255)
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
    local ToggleStroke = Instance.new("UIStroke", Toggle)
    ToggleStroke.Thickness = 3
    ToggleStroke.Transparency = 0.4
    local tGrad = Instance.new("UIGradient", ToggleStroke)
    tGrad.Color = ColorSequence.new(Color3.fromRGB(0, 150, 255), Color3.fromRGB(255, 50, 150))
    local isVisible = true
    Toggle.MouseButton1Click:Connect(function()
        isVisible = not isVisible
        MainFrame.Visible = isVisible
    end)
end
createUI()
while true do
    wait(1)
    if not CoreGui:FindFirstChild("WACKShopUI") then
        createUI()
    end

end
