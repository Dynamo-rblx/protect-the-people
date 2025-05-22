-- @ScriptType: LocalScript
-- Services
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Ledge Grab Settings
local LedgeDebugEnabled: boolean = false
local LedgeTimeWindow: number = 1
local LedgeClimbTime: number = 1
local ClimbY: number = 8
local WallRayLength: number = 5
local LedgeCheckHeight: number = 8

-- Player & Character
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Head: BasePart = Character:WaitForChild("Head")
local HumanoidRootPart: BasePart = Character:WaitForChild("HumanoidRootPart")
local Humanoid: Humanoid = Character:WaitForChild("Humanoid")
local Animator: Animator = Humanoid:WaitForChild("Animator")

-- User Input Variables
local lastSpacePressed = tick()

-- Ledge Climb Animation
local LedgeClimbAnimTrack = Animator:LoadAnimation(script:WaitForChild("LedgeClimbAnim", 3)) -- or your own

-- Ray Params
local rayparams = RaycastParams.new()
rayparams.FilterType = Enum.RaycastFilterType.Exclude
rayparams.FilterDescendantsInstances = {Character}

-- TweenInfo
local ledgeClimbInfo = TweenInfo.new(LedgeClimbTime, Enum.EasingStyle.Linear)

-- Debug Function
local function LedgeDebug(position: Vector3)
	if not LedgeDebugEnabled then return end
	local DebugPoint = Instance.new("Attachment")
	DebugPoint.Visible = true
	DebugPoint.CFrame = CFrame.new(position)
	DebugPoint.Parent = workspace.Terrain
	task.delay(5, function()
		DebugPoint:Destroy()
	end)
end

-- Auxiliary Functions
local function roofCheck()
	return workspace:Raycast(HumanoidRootPart.Position, HumanoidRootPart.CFrame.UpVector * LedgeCheckHeight, rayparams)
end

local function wallCheck()
	return workspace:Raycast(HumanoidRootPart.Position, HumanoidRootPart.CFrame.LookVector * WallRayLength, rayparams)
end

local function ledgeCheck()
	return workspace:Raycast(Head.Position + HumanoidRootPart.CFrame.UpVector * LedgeCheckHeight, HumanoidRootPart.CFrame.LookVector * WallRayLength, rayparams)
end

local function AnchorMovement(Root, Humanoid, Toggle)
    Root.Anchored = Toggle
    Humanoid.AutoRotate = not Toggle
end

-- Main Function
local function LedgeJump()
	local wallTable = wallCheck()
	
	if not wallTable or ledgeCheck() or roofCheck() then return end
    
    task.spawn(LedgeDebug, wallTable.Position)
	
	AnchorMovement(HumanoidRootPart, Humanoid, true)
    
    local GoalCFrame = CFrame.new(wallTable.Position) * CFrame.new(0, ClimbY, 0) * HumanoidRootPart.CFrame.Rotation
    local ClimbTween = TweenService:Create(HumanoidRootPart, ledgeClimbInfo, {CFrame = GoalCFrame})
    
	if LedgeClimbAnimTrack then LedgeClimbAnimTrack:Play() end

    ClimbTween:Play()
	ClimbTween.Completed:Wait()

    AnchorMovement(HumanoidRootPart, Humanoid, false)
end


-- Input Began Event
UserInputService.InputBegan:Connect(function(key, gme)
    if gme or key.KeyCode ~= Enum.KeyCode.Space then return end
    
    if tick() - lastSpacePressed <= LedgeTimeWindow then
        LedgeJump()
    else
        lastSpacePressed = tick()
    end
    
end)

