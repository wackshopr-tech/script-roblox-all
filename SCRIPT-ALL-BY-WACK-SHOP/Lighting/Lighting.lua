local Lighting = game:GetService("Lighting")

local function applyLighting()
	Lighting.FogStart = 100000
	Lighting.FogEnd = 100000
	Lighting.FogColor = Color3.fromRGB(200, 200, 200)

	Lighting.Brightness = 2
	Lighting.ClockTime = 13.5
	Lighting.GlobalShadows = true
	Lighting.OutdoorAmbient = Color3.fromRGB(170, 170, 170)
	Lighting.Ambient = Color3.fromRGB(140, 140, 140)
	Lighting.ExposureCompensation = 0
end

applyLighting()

Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
	Lighting.ClockTime = 13.5
end)
