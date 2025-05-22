-- @ScriptType: Script
function damage(touched)
	if touched.Parent:FindFirstChildOfClass("Humanoid") then
		touched.Parent:FindFirstChildOfClass("Humanoid").Health = touched.Parent:FindFirstChildOfClass("Humanoid").Health + script.AmountPerHit.Value
	end
end

function Possess(touched)
	local parts = script.HumanoidsHit:GetChildren()
	local hit = false
	if #parts ~= 0 then
		for x = 1, #parts do
			if parts[x].ClassName == "ObjectValue" then
				if parts[x].Value == touched.Parent then
					hit = true
				end
			end
		end
	end
	local val = Instance.new("ObjectValue")
	if hit == false then
		val.Value = touched.Parent
		val.Parent = script.HumanoidsHit
		val.Name = "Hit"
		damage(touched)
	else
		val:Destroy()
		val = nil
	end
	if script.HitMoreThanOnce.Value == true and val ~= nil then
		wait(script.HitMoreThanOnce.TimeBeforeHitAgain.Value)
		val:Destroy()
	end
end

local parts = script.Parent:GetChildren()

for x = 1, #parts do
	if parts[x].ClassName == "Part" or parts[x].ClassName == "MeshPart" then
		parts[x].Touched:Connect(Possess)
	end
end