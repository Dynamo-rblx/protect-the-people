-- @ScriptType: LocalScript
-- Glide script - October 16, 2022

local FLOAT_FORCE = 4.6 -- Increase to float more, decrease to float less
local GLIDE_KEY = Enum.KeyCode.G -- Change this to change the key for gliding

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local character = player.Character
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local falling = false
humanoid.StateChanged:Connect(function(old, new)
	if new == Enum.HumanoidStateType.Freefall then
		falling = true
	else
		falling = false
	end
end)

local holding = false
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == GLIDE_KEY then
				holding = true
			end
		end
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == GLIDE_KEY then
			holding = false
		end
	end
end)

local glideAnim = humanoid.Animator:LoadAnimation(script:WaitForChild("GlideAnim"))
glideAnim.Priority = Enum.AnimationPriority.Action4

local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function()
	if (holding == true and falling == true) then
		if not hrp:FindFirstChild("GlideForce") then
			local glideForce = Instance.new("BodyVelocity")
			glideForce.Name = "GlideForce"
			glideForce.MaxForce = Vector3.new(0, 100000, 0)
			glideForce.Velocity = Vector3.new(0, -10, 0)
			glideForce.Parent = hrp
			glideAnim:Play(.1)
			
			print("Gliding")
		end
	else
		if hrp:FindFirstChild("GlideForce") then
			hrp.GlideForce:Destroy()
			glideAnim:Stop()
			
			print("Not gliding")
		end
	end 
end)