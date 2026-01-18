--// SERVICES
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

--// MAIN FUNCTION
local function createUI()
    if CoreGui:FindFirstChild("WACKShopUI") then
        CoreGui.WACKShopUI:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "WACKShopUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui
    pcall(function() syn.protect_gui(ScreenGui) end)

    --================ MAIN FRAME =================
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 380, 0, 480)
    Main.Position = UDim2.new(0.52, -190, 0.55, -240)
    Main.BackgroundColor3 = Color3.fromRGB(12,12,20)
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true
    Main.Visible = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

    local MainStroke = Instance.new("UIStroke", Main)
    MainStroke.Thickness = 3
    MainStroke.Transparency = 0.25
    MainStroke.Color = Color3.fromRGB(255, 200, 0)

    --================ TITLE =================
    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1,0,0,55)
    Title.BackgroundTransparency = 1
    Title.Text = "แนวเกรียนๆ • WACK SHOP"
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 22
    Title.TextColor3 = Color3.fromRGB(255, 220, 120)

    --================ SCROLL =================
    local Scroll = Instance.new("ScrollingFrame", Main)
    Scroll.Position = UDim2.new(0,10,0,65)
    Scroll.Size = UDim2.new(1,-20,1,-75)
    Scroll.CanvasSize = UDim2.new(0,0,0,0)
    Scroll.ScrollBarThickness = 6
    Scroll.BackgroundTransparency = 1

    local ScrollLayout = Instance.new("UIListLayout", Scroll)
    ScrollLayout.Padding = UDim.new(0,14)

    ScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Scroll.CanvasSize = UDim2.new(0,0,0,ScrollLayout.AbsoluteContentSize.Y + 10)
    end)

    --================ DATA =================
    local functionCategories = {
        ["ผู้สร้าง By Wack Shop"] = {
            ["เตะออกแมพ"] = "https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/FLINGCORE/FLINGCORE.lua",
            ["ดึงคน false"] = "https://pastebin.com/raw/CuDBzSm6",
            ["ดูดสิ่งของ"] = "https://raw.githubusercontent.com/wackshopr-tech/script-roblox-all/refs/heads/main/SCRIPT-ALL-BY-WACK-SHOP/BLACK%20HOLE%20v3/BLACKHOLEv3.lua",
            ["ท่ากวนๆ"] = "https://pastebin.com/raw/yb6Fqqpg"
        },
    }

    --================ CREATE CATEGORIES =================
    for category, scripts in pairs(functionCategories) do
        local CatFrame = Instance.new("Frame", Scroll)
        CatFrame.BackgroundColor3 = Color3.fromRGB(18,18,28)
        CatFrame.BorderSizePixel = 0
        CatFrame.Size = UDim2.new(1, -4, 0, 0)
        Instance.new("UICorner", CatFrame).CornerRadius = UDim.new(0,12)

        local Padding = Instance.new("UIPadding", CatFrame)
        Padding.PaddingTop = UDim.new(0,10)
        Padding.PaddingBottom = UDim.new(0,10)
        Padding.PaddingLeft = UDim.new(0,10)
        Padding.PaddingRight = UDim.new(0,10)

        local Layout = Instance.new("UIListLayout", CatFrame)
        Layout.Padding = UDim.new(0,8)

        local CatTitle = Instance.new("TextLabel", CatFrame)
        CatTitle.Size = UDim2.new(1,0,0,26)
        CatTitle.BackgroundTransparency = 1
        CatTitle.Text = "▣ "..category
        CatTitle.Font = Enum.Font.GothamBold
        CatTitle.TextSize = 18
        CatTitle.TextXAlignment = Enum.TextXAlignment.Left
        CatTitle.TextColor3 = Color3.fromRGB(255, 210, 80)

        for name, url in pairs(scripts) do
            local btn = Instance.new("TextButton", CatFrame)
            btn.Size = UDim2.new(1,0,0,40)
            btn.BackgroundColor3 = Color3.fromRGB(28,28,40)
            btn.Text = name
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 15
            btn.TextColor3 = Color3.fromRGB(235,235,235)
            btn.AutoButtonColor = false
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

            local Stroke = Instance.new("UIStroke", btn)
            Stroke.Transparency = 0.6
            Stroke.Color = Color3.fromRGB(255, 200, 0)

            btn.MouseEnter:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(40,40,60)
                }):Play()
            end)

            btn.MouseLeave:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(28,28,40)
                }):Play()
            end)

            btn.MouseButton1Click:Connect(function()
                loadstring(game:HttpGet(url))()
            end)
        end

        local function resize()
            CatFrame.Size = UDim2.new(
                1, -4,
                0,
                Layout.AbsoluteContentSize.Y + 20
            )
        end

        resize()
        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resize)
    end

    --================ TOGGLE BUTTON =================
    local Toggle = Instance.new("TextButton", ScreenGui)
    Toggle.Size = UDim2.new(0,48,0,48)
    Toggle.Position = UDim2.new(0,20,0,120)
    Toggle.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    Toggle.Text = "W"
    Toggle.Font = Enum.Font.GothamBlack
    Toggle.TextSize = 18
    Toggle.TextColor3 = Color3.fromRGB(20,20,20)
    Toggle.Active = true
    Toggle.Draggable = true
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1,0)

    local ToggleStroke = Instance.new("UIStroke", Toggle)
    ToggleStroke.Thickness = 3
    ToggleStroke.Color = Color3.fromRGB(255, 170, 0)

    local visible = true
    Toggle.MouseButton1Click:Connect(function()
        visible = not visible
        Main.Visible = visible
    end)
end

createUI()
