-- @ScriptType: ModuleScript
local RE = game:GetService("ServerStorage")
local enemiesFolder = RE:WaitForChild("Enemies")
local foliageFolder = game.Workspace:WaitForChild("Foliage")
local crowndropped = false
local livingEnemies = {}

local control = {}

control.Waves = {
	wave1 = {
		Enemies = {
			Peasant = 15, -- Amount of enemies for each player
		},

		Spawns = {
			Front = true,
			Sides = false,
			Back = false
		},

		Lighting = {
			Ambient = Color3.fromRGB(45,45,45),
			ClockTime = 9.5,
			Brightness = 2.11,
			GlobalShadows = true,
			OutdoorAmbient = Color3.fromRGB(70,70,70)
		},

		Terrain = {
			GrassColor = Color3.fromRGB(111, 126, 62),
			FoliageBrickColor = BrickColor.new("Slime green"),
			Foliage = true,
			Leaves = true

		}	
	},

	wave2 = {
		Enemies = {
			Peasant = 10, -- Amount of enemies for each player
			Criminal = 3
		},

		Spawns = {
			Front = true,
			Sides = false,
			Back = false
		},

		Lighting = {
			Ambient = Color3.fromRGB(45,45,45),
			ClockTime = 9.5,
			Brightness = 2.11,
			GlobalShadows = true,
			OutdoorAmbient = Color3.fromRGB(70,70,70)
		},

		Terrain = {
			GrassColor = Color3.fromRGB(111, 126, 62),
			FoliageBrickColor = BrickColor.new("Slime green"),
			Foliage = true,
			Leaves = true

		}	
	},

	wave3 = {
		Enemies = {
			Peasant = 5, -- Amount of enemies for each player
			Criminal = 5,
			Bomber = 2
		},

		Spawns = {
			Front = true,
			Sides = false,
			Back = false
		},

		Lighting = {
			Ambient = Color3.fromRGB(45,45,45),
			ClockTime = 9.5,
			Brightness = 2.11,
			GlobalShadows = true,
			OutdoorAmbient = Color3.fromRGB(70,70,70)
		},

		Terrain = {
			GrassColor = Color3.fromRGB(111, 126, 62),
			FoliageBrickColor = BrickColor.new("Slime green"),
			Foliage = true,
			Leaves = true

		}	
	},

	wave4 = {
		Enemies = {
			Peasant = 10, -- Amount of enemies for each player
			Bomber = 3
		},

		Spawns = {
			Front = true,
			Sides = false,
			Back = false
		},

		Lighting = {
			Ambient = Color3.fromRGB(45,45,45),
			ClockTime = 9.5,
			Brightness = 2.11,
			GlobalShadows = true,
			OutdoorAmbient = Color3.fromRGB(70,70,70)
		},

		Terrain = {
			GrassColor = Color3.fromRGB(111, 126, 62),
			FoliageBrickColor = BrickColor.new("Slime green"),
			Foliage = true,
			Leaves = true

		}	
	},

	wave5 = {
		Enemies = {
			Bomber = 3, -- Amount of enemies for each player
			Criminal = 10
		},

		Spawns = {
			Front = true,
			Sides = false,
			Back = false
		},

		Lighting = {
			Ambient = Color3.fromRGB(45,45,45),
			ClockTime = 9.5,
			Brightness = 2.11,
			GlobalShadows = true,
			OutdoorAmbient = Color3.fromRGB(70,70,70)
		},

		Terrain = {
			GrassColor = Color3.fromRGB(111, 126, 62),
			FoliageBrickColor = BrickColor.new("Slime green"),
			Foliage = true,
			Leaves = true

		}	
	},

	wave6 = {
		Enemies = {
			Peasant = 5 -- Amount of enemies for each player
		},

		Spawns = {
			Front = true,
			Sides = true,
			Back = true
		},

		Lighting = {
			Ambient = Color3.fromRGB(45,45,45),
			ClockTime = 9.5,
			Brightness = 2.11,
			GlobalShadows = true,
			OutdoorAmbient = Color3.fromRGB(70,70,70)
		},

		Terrain = {
			GrassColor = Color3.fromRGB(111, 126, 62),
			FoliageBrickColor = BrickColor.new("Slime green"),
			Foliage = true,
			Leaves = true

		}	
	},
}

control.CurrentWave = 1

function control.AddWave()
	control.CurrentWave += 1
end

function control.StartWave()
	local waveData = control.Waves["wave"..tostring(control.CurrentWave)]
	local enemyData = waveData.Enemies

	game.Lighting.Ambient = waveData.Lighting.Ambient
	game.Lighting.Brightness = waveData.Lighting.Brightness
	game.Lighting.GlobalShadows = 	waveData.Lighting.GlobalShadows
	game.Lighting.ClockTime = waveData.Lighting.ClockTime
	game.Lighting.OutdoorAmbient = waveData.Lighting.OutdoorAmbient

	game.Workspace.Terrain:SetMaterialColor(Enum.Material.Grass, waveData.Terrain.GrassColor)

	if waveData.Terrain.Foliage == false then
		foliageFolder.Parent = game.ServerStorage
	else
		foliageFolder.Parent = game.Workspace
	end

	for i, v in pairs(foliageFolder:GetChildren()) do
		if v:IsA("BasePart") or v:IsA("Part") or v:IsA("UnionOperation") then
			if v.Name == "Leaves" then
				if waveData.Terrain.Foliage == true then
					v.CanCollide = true
					v.Transparency = 0
					v.BrickColor = waveData.Terrain.FoliageBrickColor
				else
					v.CanCollide = false
					v.Transparency = 1
				end
			end
		end
	end



	for i, enemy in pairs(enemiesFolder:GetChildren()) do
		if enemyData[enemy.Name] then
			for i=1, enemyData[enemy.Name] do
				local eClone = enemy:Clone()

				if waveData.Spawns.Front == true then
					eClone:SetPrimaryPartCFrame(CFrame.new(Vector3.new(math.random(-190, 200), 40, math.random(260, 430))))
					eClone.Parent = game.Workspace:WaitForChild("Enemies")
				end

				if waveData.Spawns.Sides == true then
					local eTemp = eClone:Clone()
					if math.random(1,2) == 1 then
						eTemp:SetPrimaryPartCFrame(CFrame.new(Vector3.new(math.random(-350, -190), 40, math.random(-46, 130)))) -- left
					else
						eTemp:SetPrimaryPartCFrame(CFrame.new(Vector3.new(math.random(313, 395), 40, math.random(-130, 45)))) -- right
					end
					eTemp.Parent = game.Workspace:WaitForChild("Enemies")
				end

				if waveData.Spawns.Back == true then
					local eTemp = eClone:Clone()
					eTemp:Clone():SetPrimaryPartCFrame(CFrame.new(Vector3.new(math.random(-130, 235), 80, math.random(-425, -260))))
					eTemp.Parent = game.Workspace:WaitForChild("Enemies")
				end


			end
		end
	end
	game.ServerStorage:WaitForChild("Cleared").Event:Wait()
	control.Notify("Wave "..control.CurrentWave.." Concluded")
	control.CurrentWave += 1
end

function control.Notify(raw)
	local txt = tostring(raw)
	local h = script:WaitForChild("Notification")
	h:WaitForChild("display").Text = txt

	for i, v in pairs(game.Players:GetChildren()) do
		local Pui = v.PlayerGui
		for i, v in pairs(Pui:GetChildren()) do
			if v.Name == "Notification" then
				v:Destroy()
			end
			h:Clone().Parent = Pui
		end
	end
end

function control.ClearNotifications()
	for i, v in pairs(game.Players:GetChildren()) do
		local Pui = v.PlayerGui
		for i, v in pairs(Pui:GetChildren()) do
			if v.Name == "Notification" then
				v:Destroy()
			end
		end
	end
end

function control.CrownSaved(name)
	control.ClearNotifications()
	control.Notify(name.." has claimed the crown!")
	game.Lighting:WaitForChild("crownDropped").Enabled = false
	local countdown = 5
	
	repeat
		if crowndropped == false then
			task.wait(1)
			countdown -= 1
			control.Notify("Resuming in "..tostring(countdown))
		end
	until countdown <= 0
	
	crowndropped = false
end

function control.CrownDropped(name)
	control.ClearNotifications()
	control.Notify(name.." has dropped the crown!")
	game.Lighting:WaitForChild("crownDropped").Enabled = true
	local countdown = 30
	repeat
		if crowndropped == true then
			task.wait(1)
			countdown -= 1
			control.Notify("CROWN DROPPED: "..tostring(countdown))
		else
			countdown = 30
			break
		end
	until countdown <= 0	
	if countdown == 0 then
		control.Lose()
	end
end

function control.Countdown(start)
	local countdown = start or 10
	repeat
		if crowndropped == false then
			task.wait(1)
			countdown -= 1
			control.Notify(tostring(countdown))
		end
	until countdown <= 0

	return true
end

function control.Messenger(message)
	local msngr = workspace:WaitForChild("Messenger")
	local msg = msngr:WaitForChild("Head"):WaitForChild("BillboardGui"):WaitForChild("msg")

	msg.Text = tostring(message)
end

function control.Lose()
	for i, v in pairs(game.Players:GetChildren()) do
		v.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 0
		v.Character:FindFirstChildOfClass("Humanoid").JumpPower = 0
	end
	
	
end

return control
