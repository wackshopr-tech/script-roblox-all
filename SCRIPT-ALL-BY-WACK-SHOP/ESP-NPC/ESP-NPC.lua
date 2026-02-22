local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESP_COLOR = Color3.new(1, 1, 1)
local TEXT_SIZE = 14
local SCAN_DELAY = 1.5

local ESP_CACHE = {}

local function isNPC(model)
    if not model:IsA("Model") or Players:GetPlayerFromCharacter(model) then return false end
    local hum = model:FindFirstChildOfClass("Humanoid")
    local root = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso")
    return hum and root and hum.Health > 0
end

local function createESP(npc)
    if ESP_CACHE[npc] then return end

    local root = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Torso")
    if not root then return end

    local hl = Instance.new("Highlight")
    hl.FillColor = ESP_COLOR
    hl.FillTransparency = 0.8
    hl.OutlineColor = Color3.new(1, 1, 1)
    hl.Adornee = npc
    hl.Parent = npc

    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.fromScale(4, 1)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = root
    billboard.Parent = npc

    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(1, 1)
    label.BackgroundTransparency = 1
    label.TextColor3 = ESP_COLOR
    label.TextStrokeTransparency = 0.5
    label.Font = Enum.Font.GothamBold
    label.TextSize = TEXT_SIZE
    label.Text = ""
    label.Parent = billboard

    local line = Drawing.new("Line")
    line.Color = ESP_COLOR
    line.Thickness = 1
    line.Visible = false

    ESP_CACHE[npc] = {
        Highlight = hl,
        Billboard = billboard,
        Text = label,
        Line = line,
        Root = root
    }
end

local function removeESP(npc)
    local esp = ESP_CACHE[npc]
    if esp then
        if esp.Highlight then esp.Highlight:Destroy() end
        if esp.Billboard then esp.Billboard:Destroy() end
        if esp.Line then esp.Line:Remove() end
        ESP_CACHE[npc] = nil
    end
end

task.spawn(function()
    while task.wait(SCAN_DELAY) do
        for _, obj in ipairs(workspace:GetChildren()) do
            if isNPC(obj) then
                createESP(obj)
            elseif obj:IsA("Folder") or obj:IsA("Model") then
                for _, subObj in ipairs(obj:GetChildren()) do
                    if isNPC(subObj) then createESP(subObj) end
                end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local camSize = Camera.ViewportSize

    for npc, esp in pairs(ESP_CACHE) do
        if not npc:IsDescendantOf(workspace) then
            removeESP(npc)
            continue
        end

        local root = esp.Root
        local hum = npc:FindFirstChildOfClass("Humanoid")

        if root and hum and hum.Health > 0 then
            local dist = (hrp.Position - root.Position).Magnitude
            esp.Text.Text = math.floor(dist) .. " m"

            local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)
            if onScreen then
                esp.Line.From = Vector2.new(camSize.X / 2, camSize.Y)
                esp.Line.To = Vector2.new(screenPos.X, screenPos.Y)
                esp.Line.Visible = true
            else
                esp.Line.Visible = false
            end
        else
            removeESP(npc)
        end
    end
end)
