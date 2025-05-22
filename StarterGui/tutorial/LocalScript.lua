-- @ScriptType: LocalScript
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("tutorial").OnClientEvent:Connect(function()
	script.Parent.Enabled = true
end)