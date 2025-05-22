-- @ScriptType: Script
game:GetService("ReplicatedStorage"):WaitForChild("Values"):WaitForChild("started"):GetPropertyChangedSignal("Value"):Connect(function()
	if game.ReplicatedStorage.Values.started.Value == true then
		local rn = math.random(1, #game.Players:GetChildren())
		local leader = game.Players:GetChildren()[rn]
		game.ReplicatedStorage.Values:WaitForChild("Leader").Value = leader
		local protectors = {}
		for i, v in pairs(game.Players:GetChildren()) do
			if v ~= leader then
				table.insert(protectors, v)
				v.Team = game:GetService("Teams"):WaitForChild("Protectors")
			else
				v.Team = game:GetService("Teams"):WaitForChild("Leader")
			end
		end
		game.ReplicatedStorage.Events.tutorial:FireAllClients()
	end
end)

local tutorialsFinished = 0
local goal = math.round(#game.Players:GetChildren()/2)
local reached = false
local control = require(script:WaitForChild("control"))


game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("finishedTutorial").OnServerEvent:Connect(function(plr)
	if reached == false then
		tutorialsFinished += 1
		if tutorialsFinished >= goal then
			reached = true
		end
	end
end)

repeat task.wait() until reached == true

local function newWave(countdown)
	if countdown > 0 and countdown ~= nil then
		local cd = control.Countdown(countdown)
		repeat task.wait() until cd == true
	end
	control.ClearNotifications()
	control.Notify("Wave "..control.CurrentWave)
	control.StartWave()
end

-- Begin real game
local cd = control.Countdown(30)
repeat task.wait() until cd == true
control.ClearNotifications()

local msgr = game.Workspace.Messenger
local msgrBubble = msgr:WaitForChild("Head"):WaitForChild("BillboardGui")

game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("messengerCam"):FireAllClients(workspace.Messenger.Head) -- Cutscene
msgrBubble.Enabled = true
control.Messenger("The peasants are coming! Prepare for battle!")
task.wait(3)
control.Messenger("They're waiting outside!")
task.wait(5)
game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("unlockCamera"):FireAllClients()
msgrBubble.Enabled = false

newWave(0) -- Wave 1

game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("messengerCam"):FireAllClients(workspace.Messenger.Head) -- Cutscene
msgrBubble.Enabled = true
control.Messenger("Good work team!")
task.wait(3)
control.Messenger("Don't get too happy.")
task.wait(3)
control.Messenger("It gets worse.")
task.wait(5)
game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("unlockCamera"):FireAllClients()
msgrBubble.Enabled = false

newWave(15) -- Wave 2 (Just do next waves without cutscene until wave 10 which will be a boss)
newWave(15)
newWave(15)
newWave(15) -- 5
newWave(15)


