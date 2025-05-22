-- @ScriptType: LocalScript


local Camera = workspace.CurrentCamera
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChild("Humanoid")

local function FixCamera()
	Camera.CameraType = Enum.CameraType.Custom
	Camera.CameraSubject = Humanoid
	Camera.FieldOfView = 60
end

Humanoid.Died:Connect(function()
	local CameraCurrentPos = Camera.CFrame.Position
	Camera.FieldOfView = 80
	Camera.CameraSubject = nil
	Camera.CameraType = Enum.CameraType.Scriptable
	
	game["Run Service"].Heartbeat:Connect(function()
		local CharHead = Character:FindFirstChild("Head")
		
		if CharHead then
			Camera.CFrame = CFrame.lookAt(CameraCurrentPos, CharHead.Position)
		end
	end)
end)

FixCamera()