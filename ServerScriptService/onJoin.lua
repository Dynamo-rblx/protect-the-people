-- @ScriptType: Script
game.Players.PlayerAdded:Connect(function(plr)
	if game:GetService("ReplicatedStorage"):WaitForChild("Values"):WaitForChild("started") then
		local started = game.ReplicatedStorage.Values.started

		plr.PlayerGui:WaitForChild("menu"):WaitForChild("start").MouseButton1Click:Connect(function()
			started.Value = true


		end)

		repeat
			task.wait()
			plr.PlayerGui:WaitForChild("menu").Enabled = true
			game.Lighting:WaitForChild("Blur").Enabled = true
			workspace:WaitForChild("main").Volume = 1
		until started.Value == true

		plr.PlayerGui:WaitForChild("menu").Enabled = false
		workspace:WaitForChild("main").Volume = 2
		game.Lighting.Blur.Enabled = false

	end

	while task.wait() do
		if	game.ReplicatedStorage.Values:WaitForChild("Leader").Value == plr then
			if plr.Character then
				if plr.Character:FindFirstChild("Poor") then
					plr.Character.Poor:Destroy()
				end
				if plr.Character:FindFirstChild("Knight Helmet") then
					plr.Character["Knight Helmet"]:Destroy()
				end
				if not(plr.Character:FindFirstChild("King")) then
					script:WaitForChild("King"):Clone().Parent = plr.Character
				end
				if not(plr.Character:FindFirstChild("Classic Crown")) then
					script:WaitForChild("Classic Crown"):Clone().Parent = plr.Character
				end
				if not(plr.Backpack:FindFirstChild("Healing Staff")) and not(plr.Character:FindFirstChild("Healing Staff")) then
					script:WaitForChild("Healing Staff"):Clone().Parent = plr.Backpack
				end

			end
		else
			if plr.Character then
				if plr.Character:FindFirstChild("King") then
					plr.Character.King:Destroy()
				end
				if not(plr.Character:FindFirstChild("Poor")) then
					script:WaitForChild("Poor"):Clone().Parent = plr.Character
				end
				if not(plr.Character:FindFirstChild("Knight Helmet")) then
					script:WaitForChild("Knight Helmet"):Clone().Parent = plr.Character
				end
				if plr.Character:FindFirstChild("Classic Crown") then
					plr.Character["Classic Crown"]:Destroy()
				end
				if plr.Character:FindFirstChild("Healing Staff") then
					plr.Character["Healing Staff"]:Destroy()
				end
			end
		end
	end
end)