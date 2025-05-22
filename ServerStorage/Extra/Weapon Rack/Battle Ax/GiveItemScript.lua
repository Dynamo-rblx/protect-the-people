-- @ScriptType: Script
local clickEvent = require(game.ReplicatedStorage.ClickerModule).RemoteEvent
local GameSettings = require(game.ReplicatedStorage.GameSettings)
local asset = 12775410
local interactiveParts = {}

for _, v in pairs(script.Parent:GetChildren()) do
	if v.Name == "Interactive" then
		table.insert(interactiveParts, v)
		local clicker = Instance.new("ClickDetector")
		clicker.Parent = v
		clicker.MaxActivationDistance = GameSettings.ActivationDistance
	end
end

local function distanceToCharacter(player, part)
	local character = player.Character
	if character then
		local root = character:FindFirstChild("HumanoidRootPart")
		if root then
			return((root.Position - part.Position).magnitude)
		end
	end
	return math.huge
end

clickEvent.OnServerEvent:connect(function(player, part)
	local isPart = false
	for i = 1, #interactiveParts do
		if part == interactiveParts[i] then
			isPart = true
		end
	end
	if isPart and player.Character and distanceToCharacter(player, part) <= GameSettings.ActivationDistance then
		game:GetService("InsertService"):LoadAsset(asset):GetChildren()[1].Parent = player.Backpack
	end
end)