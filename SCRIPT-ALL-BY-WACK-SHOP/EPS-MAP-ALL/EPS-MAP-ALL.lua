local Players = game:GetService("Players")

local function applyESP(player, character)
	if not character then return end

	local head = character:WaitForChild("Head", 5)
	if not head then return end

	if character:FindFirstChild("PlayerHighlight") then
		character.PlayerHighlight:Destroy()
	end

	if head:FindFirstChild("NameBillboard") then
		head.NameBillboard:Destroy()
	end

	-- Highlight
	local highlight = Instance.new("Highlight")
	highlight.Name = "PlayerHighlight"
	highlight.Adornee = character
	highlight.FillTransparency = 1
	highlight.OutlineTransparency = 0
	highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = character

	-- Billboard
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "NameBillboard"
	billboard.Size = UDim2.fromOffset(200, 40) -- ขนาดคงที่ (px)
	billboard.StudsOffsetWorldSpace = Vector3.new(0, 2.8, 0)
	billboard.AlwaysOnTop = true
	billboard.MaxDistance = math.huge
	billboard.Adornee = head
	billboard.Parent = head

	-- Text
	local text = Instance.new("TextLabel")
	text.Size = UDim2.fromScale(1, 1)
	text.BackgroundTransparency = 1
	text.Text = player.Name
	text.TextColor3 = Color3.fromRGB(255, 255, 0)
	text.TextStrokeTransparency = 0
	text.TextStrokeColor3 = Color3.new(0, 0, 0)
	text.Font = Enum.Font.SourceSansBold
	text.TextScaled = false
	text.TextSize = 15 -- 🔒 ล็อกไว้ 15
	text.AutomaticSize = Enum.AutomaticSize.None
	text.TextWrapped = false
	text.Parent = billboard

	-- 🔒 ล็อกสเกล ป้องกัน Roblox แอบปรับ
	local uiScale = Instance.new("UIScale")
	uiScale.Scale = 1
	uiScale.Parent = billboard
end

local function setupPlayer(player)
	player.CharacterAdded:Connect(function(character)
		applyESP(player, character)
	end)

	if player.Character then
		applyESP(player, player.Character)
	end
end

for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end

Players.PlayerAdded:Connect(setupPlayer)
