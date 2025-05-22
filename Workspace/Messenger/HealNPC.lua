-- @ScriptType: Script
while task.wait() do
	script.Parent:WaitForChild("Humanoid").Health = script.Parent.Humanoid.MaxHealth
end