-- @ScriptType: Script
script.Parent.ChildRemoved:Connect(function()
	if #script.Parent:GetChildren() == 1 then
		game.ServerStorage:WaitForChild("Cleared"):Fire()
	end
	
	if #script.Parent:GetChildren() > 1 and #script.Parent:GetChildren() <= 5 then
		for i, v in pairs(script.Parent:GetChildren()) do
			if v:FindFirstChildOfClass("Highlight") then
				v:FindFirstChildOfClass("Highlight").Enabled = true
			end
		end
	end
end)