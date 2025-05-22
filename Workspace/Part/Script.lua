-- @ScriptType: Script
script.Parent.Touched:Connect(function(bp)
	if bp.Parent:FindFirstChild("Humanoid") and not(game.Players:FindFirstChild(bp.Parent.Name)) then
		local ctrl = game.ServerScriptService:WaitForChild("main"):WaitForChild("control")
		local control = require(ctrl)
		
		control.Notify("Enemies spotted near entryway!")
		
		if bp.Parent:FindFirstChildOfClass("Highlight") then
			bp.Parent:FindFirstChildOfClass("Highlight").Enabled = true
		end
	end
end)