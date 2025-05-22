-- @ScriptType: Script
while task.wait() do
	if script:FindFirstChild("droppedCrown") then
		
		local leaderName = ""

		for i, plr in pairs(game.Players:GetChildren()) do
			if plr.Team == game:GetService("Teams"):WaitForChild("Leader") then
				leaderName = plr.Name
			end
		end

		if leaderName ~= "" then
			local leader = game.Players:FindFirstChild(leaderName)

			if leader then
				leader.CharacterAdded:Wait()
				local char = leader.Character

				if char then
					local hrp = char:WaitForChild("HumanoidRootPart")

					if hrp then
						script:WaitForChild("droppedCrown").Position = hrp.Position
					else
						script:WaitForChild("droppedCrown").Parent = game.Workspace
					end
				else
					script:WaitForChild("droppedCrown").Parent = game.Workspace
				end
				
			else
				script:WaitForChild("droppedCrown").Parent = game.Workspace	
			end
		else
			script:WaitForChild("droppedCrown").Parent = game.Workspace
		end
		
	end
	
	
end