-- @ScriptType: Script
local control = require(game:GetService("ServerScriptService"):WaitForChild("main"):WaitForChild("control"))

game.Players.PlayerAdded:Connect(function(plr)
	
	
	while task.wait() do
		plr.CharacterAdded:Wait()
		task.wait(0)
		local char = plr.Character
		
		char:FindFirstChildOfClass("Humanoid").Died:Connect(function()
			if plr.Team == game.Teams:WaitForChild("Leader") then
				game:GetService("ServerStorage"):WaitForChild("droppedCrown"):Fire(plr.Name)
				plr.Team = game.Teams:WaitForChild("Protectors")
				plr:LoadCharacter()
			end
		end)
	end
end)

game:GetService("ServerStorage"):WaitForChild("droppedCrown").Event:Connect(function(name)
	control.CrownDropped(name)
end)

game:GetService("ServerStorage"):WaitForChild("pickedupCrown").Event:Connect(function(name)
	control.CrownSaved(name)
end)