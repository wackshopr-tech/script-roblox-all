local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local function applyESP(player, character)
	if not character or player == LocalPlayer then return end

	local head = character:WaitForChild("Head", 5)
	local root = character:WaitForChild("HumanoidRootPart", 5)
	if not head or not root then return end

	-- ลบ ESP เก่าออกก่อนเพื่อป้องกันการทำงานซ้ำซ้อน
	if character:FindFirstChild("PlayerHighlight") then
		character.PlayerHighlight:Destroy()
	end

	if head:FindFirstChild("NameBillboard") then
		head.NameBillboard:Destroy()
	end

	-- สร้างระบบ Highlight (เส้นขอบตัวละคร)
	local highlight = Instance.new("Highlight")
	highlight.Name = "PlayerHighlight"
	highlight.Adornee = character
	highlight.FillTransparency = 1 -- ตั้งเป็น 1 เพื่อไม่ให้ตัวละครทึบแสง
	highlight.OutlineTransparency = 0
	highlight.OutlineColor = Color3.fromRGB(255, 255, 0) -- สีเหลือง
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = character

	-- สร้างระบบชื่อบนหัว (BillboardGui)
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "NameBillboard"
	billboard.Size = UDim2.new(0, 300, 0, 80)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.MaxDistance = math.huge
	billboard.Adornee = head
	billboard.Parent = head

	local text = Instance.new("TextLabel")
	text.Size = UDim2.new(1, 0, 1, 0)
	text.BackgroundTransparency = 1
	text.Text = player.Name
	text.TextColor3 = Color3.fromRGB(255, 255, 0)
	text.TextStrokeTransparency = 0
	text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	text.Font = Enum.Font.SourceSansBold
	text.TextSize = 13
	text.Parent = billboard
end

local function setupPlayer(player)
	player.CharacterAdded:Connect(function(character)
		applyESP(player, character)
	end)

	if player.Character then
		applyESP(player, player.Character)
	end
end

-- รันระบบสำหรับผู้เล่นที่อยู่ในเซิร์ฟเวอร์อยู่แล้ว
for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end

-- รันระบบสำหรับผู้เล่นที่เพิ่งเข้าเซิร์ฟเวอร์มาใหม่
Players.PlayerAdded:Connect(setupPlayer)
