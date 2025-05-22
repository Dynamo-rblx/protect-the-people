-- @ScriptType: Script
local TweenService = game:GetService("TweenService")

function dissapear(thePart)
	local Change = {
		Transparency = 1
	}
	
	local PartSlideInfo = TweenInfo.new(
		script.Time.Value, --- Time to tween from position to position
		Enum.EasingStyle.Sine, 
		Enum.EasingDirection.Out, 
		0, --- Times repeated
		false, --- Reverse the tween or not
		0 --- Delay time
	)
	
	local PartSlideTween = TweenService:Create(thePart, PartSlideInfo, Change)
	
	PartSlideTween:Play()
end

local parts = script.Parent:GetChildren()

for x = 1, #parts do
	if parts[x].ClassName == "Part" or parts[x].ClassName == "MeshPart" then
		dissapear(parts[x])
	end
end

wait(script.Time.Value)
script.Parent:Destroy()