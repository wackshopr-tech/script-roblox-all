local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- คอนฟิก
local ESP_COLOR = Color3.fromRGB(255, 255, 255)
local TEXT_SIZE = 14
local UPDATE_FREQUENCY = 0.1 -- อัปเดตระยะทางทุก 0.1 วินาที (ประหยัดกว่าทุกเฟรม)

local ESP_CACHE = {}

-- ฟังก์ชันตรวจสอบ NPC แบบรวดเร็ว
local function isNPC(model)
    if not model:IsA("Model") or Players:GetPlayerFromCharacter(model) then return false end
    local hum = model:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health > 0 and (model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso"))
end

local function createESP(npc)
    if ESP_CACHE[npc] then return end
    
    local root = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Torso")
    if not root then return end

    -- ใช้ Highlight (ประสิทธิภาพสูงเพราะ Engine วาดให้โดยตรง)
    local hl = Instance.new("Highlight")
    hl.Name = "ESPHighlight"
    hl.FillColor = ESP_COLOR
    hl.FillTransparency = 0.7
    hl.OutlineColor = Color3.new(1, 1, 1)
    hl.Adornee = npc
    hl.Parent = npc

    -- BillboardGui สำหรับระยะทาง
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPLabel"
    billboard.Size = UDim2.fromOffset(100, 30)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = root
    
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.fromScale(1, 1)
    label.TextColor3 = ESP_COLOR
    label.TextStrokeTransparency = 0.5
    label.Font = Enum.Font.GothamBold
    label.TextSize = TEXT_SIZE
    label.Text = ""
    label.Parent = billboard
    
    billboard.Parent = npc

    ESP_CACHE[npc] = {
        Label = label,
        Root = root,
        Hum = npc:FindFirstChildOfClass("Humanoid")
    }
end

local function removeESP(npc)
    if ESP_CACHE[npc] then
        local hl = npc:FindFirstChild("ESPHighlight")
        local bb = npc:FindFirstChild("ESPLabel")
        if hl then hl:Destroy() end
        if bb then bb:Destroy() end
        ESP_CACHE[npc] = nil
    end
end

-- ⚡ วิธีใหม่: ใช้ DescendantAdded เพื่อตรวจจับ NPC ทันทีที่เกิด (ไม่ต้องรอ Loop Scan)
Workspace.DescendantAdded:Connect(function(obj)
    task.wait(0.1) -- รอให้ Part โหลดเสร็จนิดนึง
    if isNPC(obj) then
        createESP(obj)
    end
end)

-- Scan รอบแรกตอนรันสคริปต์
for _, obj in ipairs(Workspace:GetDescendants()) do
    if isNPC(obj) then
        createESP(obj)
    end
end

-- 🔄 อัปเดตระยะทางแบบคุมความเร็ว (ไม่รันทุกเฟรมให้หนักเครื่อง)
task.spawn(function()
    while true do
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        if hrp then
            for npc, data in pairs(ESP_CACHE) do
                if not npc:IsDescendantOf(Workspace) or data.Hum.Health <= 0 then
                    removeESP(npc)
                else
                    local dist = (hrp.Position - data.Root.Position).Magnitude
                    data.Label.Text = string.format("[%d m]", math.floor(dist))
                end
            end
        end
        task.wait(UPDATE_FREQUENCY)
    end
end)
