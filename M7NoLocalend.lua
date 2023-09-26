local library = loadstring(game:HttpGet('https://pastebin.com/raw/HSMwHzEm'))()

local Window = library:CreateWindow("VR7Hubs", "TPS STREET SOCCER", 10044538000)

local Tab = Window:CreateTab("السكربتات")

local MRPage = Tab:CreateFrame("الريتش")

MRPage:CreateLabel("تفعيل ريتش الجوال")
MRPage:CreateLabel("اذا ما اشتغل ترا ذي نسخه تجريبيه")
MRPage:CreateLabel("2ivsl من صنع")
local RunSteppedMobile
local DistanceReachMobile = 0

MRPage:CreateButton("تفعيل الريتش", "Enables Reach", function()
    RunSteppedMobile = game:GetService("RunService").RenderStepped:Connect(function()
if game.Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game.Workspace.TPSSystem.TPS.Position).Magnitude <= DistanceReachMobile then
if game.Lighting[game.Players.LocalPlayer.Name].PreferredFoot.Value == 1 then
firetouchinterest(game.Players.LocalPlayer.Character["Right Leg"], game.Workspace.TPSSystem.TPS, 0)
			firetouchinterest(game.Players.LocalPlayer.Character["Right Leg"], game.Workspace.TPSSystem.TPS, 1)
elseif game.Lighting[game.Players.LocalPlayer.Name].PreferredFoot.Value == 2 then
firetouchinterest(game.Players.LocalPlayer.Character["Left Leg"], game.Workspace.TPSSystem.TPS, 0)
			firetouchinterest(game.Players.LocalPlayer.Character["Left Leg"], game.Workspace.TPSSystem.TPS, 1)

end
end
end
if game.Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game.Workspace.TPSSystem.TPS.Position).Magnitude <= DistanceReach then
if game.Lighting[game.Players.LocalPlayer.Name].PreferredFoot.Value == 1 then
firetouchinterest(game.Players.LocalPlayer.Character["RightLowerLeg"], game.Workspace.TPSSystem.TPS, 0)
			firetouchinterest(game.Players.LocalPlayer.Character["RightLowerLeg"], game.Workspace.TPSSystem.TPS, 1)
elseif game.Lighting[game.Players.LocalPlayer.Name].PreferredFoot.Value == 2 then
firetouchinterest(game.Players.LocalPlayer.Character["LeftLowerLeg"], game.Workspace.TPSSystem.TPS, 0)
			firetouchinterest(game.Players.LocalPlayer.Character["LeftLowerLeg"], game.Workspace.TPSSystem.TPS, 1)
			end
			end
			end
			end)
end)
MRPage:CreateButton("بعد ما تفعل الريتش اضغط ذا الزر مهم جدا", "Size of Reach", function()
    DistanceReachMobile = 100
end)
MRPage:CreateButton("قفل الريتش", "Disable Reach", function()
    RunSteppedMobile:Disconnect()
end)

local TPPage = Tab:CreateFrame("التنقل")

TPPage:CreateLabel("التنقل")

TPPage:CreateButton("تنقل الى الكره", "Teleporting You To The Ball", function()
game.Players.LocalPlayer.Character:MoveTo(game.Workspace.TPSSystem.TPS.Position)
end)
TPPage:CreateButton("تنقل الى تيم الاحمر", "Teleporting You To The Red Goal", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0.229434282, 13.2999945, -111.25293, -0.999964356, 6.47347465e-09, -0.00844059512, 5.92729865e-09, 1, 6.47332428e-08, 0.00844059512, 6.46809042e-08, -0.999964356)
end)

TPPage:CreateButton("التنقل الى التيم الازرق", "Teleporting You To The Blue Goal", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-0.337467283, 13.2999945, 113.940865, 0.999967039, 4.84168332e-08, 0.00811586808, -4.90094685e-08, 1, 7.28228073e-08, -0.00811586808, -7.32181604e-08, 0.999967039)
end)
local GKPage = Tab:CreateFrame("الحارس")
GKPage:CreateLabel("متنوع  ")

GKPage:CreateToggle("السماح بالحفظ في كل مكان ", "Allows You Save On The Field", function(arg)
if arg then
for i,v in pairs(game.Workspace.GKSystem:GetChildren()) do
    if v.Name == "Fix" then
       v.CanTouch = false
    end
end
    else
        for i,v in pairs(game.Workspace.GKSystem:GetChildren()) do
    if v.Name == "Fix" then
       v.CanTouch = true
    end
end
end
end)

GKPage:CreateToggle("الحفظ التلقائي [طريقة اللمس] ", "Auto Save The Ball [Touched Method]", function(arg)
if arg then
TouchedGKBallBox = game.Workspace.TPSSystem.TPS.Touched:Connect(function(HRP)
    if HRP == game.Players.LocalPlayer.Character.HumanoidRootPart then
        for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "TPS" and v:IsA("Part") then
    if game.Players.LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
    AnimationId = "304581045"
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://"..AnimationId
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
wait(SaveDelay)

local A_1 = game:GetService("Workspace").TPSSystem.TPS
local A_2 = game.Players.LocalPlayer.Character["Right Leg"]
local Event = game:GetService("Workspace").FE.Actions.SaveRL
Event:FireServer(A_1, A_2)

local Events2 = game:GetService("Workspace").FE.Kick.RemoteEvent2
Events2:FireServer()
else
AnimationId = "3008336125"
local Anim = Instance.new("Animation")
Anim.AnimationId = "rbxassetid://"..AnimationId
local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
k:Play()
wait(SaveDelay)

local A_1 = game:GetService("Workspace").TPSSystem.TPS
local A_2 = game.Players.LocalPlayer.Character["HumanoidRootPart"]
local Event = game:GetService("Workspace").FE.Actions.SaveT
Event:FireServer(A_1, A_2)

local Events3 = game:GetService("Workspace").FE.Kick.RemoteEvent2
Events3:FireServer()
end
end
end
end
end)
    else
TouchedGKBallBox:Disconnect()
end
end)



GKPage:CreateToggle("نظرة تلقائية على الكرة ", "Auto Look At The Ball When In The Box. Switched Teams = Untoggle", function(arg)
if arg then
local PartB = game:GetService("Workspace").GKSystem.Fix2
local PartR = game:GetService("Workspace").GKSystem.Fix1

if game.Players.LocalPlayer.TeamColor == BrickColor.new("Bright blue") then
PartBlueTouched = PartB.Touched:Connect(function()
    local touching = PartB:GetTouchingParts()
	for i=1,#touching do
		if touching[i] == game.Players.LocalPlayer.Character.HumanoidRootPart then
			repeat wait()
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game.Workspace.TPSSystem.TPS.Position).Magnitude > 6 then
			game.Players.LocalPlayer.PlayerGui.LockScript.SetLock.Value = true
game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.Position,game.Workspace.TPSSystem.TPS.Position)
end

			until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game.Workspace.TPSSystem.TPS.Position).Magnitude <= 4.5
end
end
end)
else
PartRedTouched = PartR.Touched:Connect(function()
    local touching = PartR:GetTouchingParts()
	for i=1,#touching do
		if touching[i] == game.Players.LocalPlayer.Character.HumanoidRootPart then
			repeat wait()
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game.Workspace.TPSSystem.TPS.Position).Magnitude > 6 then
			game.Players.LocalPlayer.PlayerGui.LockScript.SetLock.Value = true
game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.Position,game.Workspace.TPSSystem.TPS.Position)
end

			until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game.Workspace.TPSSystem.TPS.Position).Magnitude <= 4.5
end
end
end)
end
    else
    PartRedTouched:Disconnect()
    PartBlueTouched:Disconnect()
    wait(1)
    game.Players.LocalPlayer.PlayerGui.LockScript.SetLock.Value = false
end
end)

GKPage:CreateToggle("العودة التلقائية ", "Auto Return To Team Goal When You Died.", function(arg)
if arg then
HumanoidDied = game.Players.LocalPlayer.CharacterAdded:Connect(function()
       wait(0.5)
          if game.Players.LocalPlayer.TeamColor == BrickColor.new("Bright red") then
          game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = Vector3.new(-2.114, 13.3, -118.341)
    else
          game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = Vector3.new(0.512, 13.3, 122.121)
       end
    end)
    else
    HumanoidDied:Disconnect()
end
end)

GKPage:CreateLabel("التكوينات ")

GKPage:CreateBox("تاخير الحفظ التلقائي", 10044538000, function(arg)
SaveDelay = tonumber(arg)
end)

GKPage:CreateSlider("مسافة الحفظ التلقائي ", 0, 10,function(arg)
   Distance = arg
end)

local SPage = Tab:CreateFrame("لاعب مهاجم ")

SPage:CreateToggle("اوتو فارم جول", "Auto Goal [Autofarn]. Use At Your Own Risk", function(arg)
if arg then
_G.AUTOFARM = true
while _G.AUTOFARM do
wait()
local HRPRotation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Rotation
local GoalPST = game.Workspace.TPSSystem.TPS.CFrame
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = HRPRotation + GoalPST.Position
    local A_1 = game:GetService("Workspace").TPSSystem.TPS
local A_2 = game:GetService("Players").LocalPlayer.Character.Head
local Event = game:GetService("Workspace").FE.Actions.Tackle
Event:FireServer(A_1, A_2)

local Events2 = game:GetService("Workspace").FE.Kick.RemoteEvent2
Events2:FireServer()
if game.Players.LocalPlayer.TeamColor == BrickColor.new("Bright red") then
game.Players.LocalPlayer.PlayerGui.LockScript.SetLock.Value = true
game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.Position + Vector3.new(0, 45, 0),game.Workspace.BlueGoal.Part.Position)
end
if game.Players.LocalPlayer.TeamColor == BrickColor.new("Bright blue") then
game.Players.LocalPlayer.PlayerGui.LockScript.SetLock.Value = true
game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.Position + Vector3.new(0, 45, 0),game.Workspace.RedGoal.Part.Position)
end
end
    else
_G.AUTOFARM = false
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Lines.Line12.CFrame
game.Players.LocalPlayer.PlayerGui.LockScript.SetLock.Value = false
end
end)

SPage:CreateToggle("السماح بتخريب مسك الكره من الحارس", "Allows You Shoot From Goalkeeper's Goal Box", function(arg)
if arg then
game:GetService("Workspace").GKSystem.Fix1.CanTouch = false
        game:GetService("Workspace").GKSystem.Fix2.CanTouch = false
    else
        game:GetService("Workspace").GKSystem.Fix1.CanTouch = true
        game:GetService("Workspace").GKSystem.Fix2.CanTouch = true
end
end)

SPage:CreateToggle("اوتو شوت", "Auto Shoot The Ball When You Are Near", function(arg)
if arg then
_G.MOD = true
    while _G.MOD do
    wait()
    for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "TPS" and v:IsA("Part") then
    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude <= 6 then
       local ModuleKick = require(game:GetService("Players").LocalPlayer.Backpack.Module)
ModuleKick.Kick()
ModuleKick.Kick2()
end
end
end
end
    else
    _G.MOD = false
end
end)

SPage:CreateToggle("اوتو انبراش / زحلقه", "Auto Tackle The Ball. Recommended 'Face At The Ball'", function(arg)
if arg then
_G.MODT = true
    while _G.MODT do
    wait()
    for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "TPS" and v:IsA("Part") then
    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude <= 6 then
       local ModuleKick = require(game:GetService("Players").LocalPlayer.Backpack.Module)
ModuleKick.Tackle()
end
end
end
end
    else
    _G.MODT = false
end
end)

SPage:CreateToggle("اوتو دفاع / الدفاع عن المرمى", "Auto Defending Your Team Goal", function(arg)
if arg then
if game.Players.LocalPlayer.TeamColor == BrickColor.new("Bright blue") then
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = Vector3.new(0.6464786529541016, 13.299994468688965, 92.49656677246094)
else
game.Players.LocalPlayer.Character.Humanoid.WalkToPoint = Vector3.new(0.11751431971788406, 13.299994468688965, -91.30338287353516)
end
_G.AUTODEFENCE = true
while _G.AUTODEFENCE do
wait()
    if game.Players.LocalPlayer.TeamColor == BrickColor.new("Bright blue") then
        if (game.Workspace.TPSSystem.TPS.Position - game.Workspace.TPSSystem.Part2.Position).Magnitude <= 125 then
        game.Players.LocalPlayer.PlayerGui.LockScript.SetLock.Value = true
game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.Position + Vector3.new(0, 45, 0),game.Workspace.RedGoal.Part.Position)
game.Players.LocalPlayer.Character.Humanoid:MoveTo(game.Workspace.TPSSystem.TPS.Position)
for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "TPS" and v:IsA("Part") then
    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude <= 6 then
       local ModuleKick = require(game:GetService("Players").LocalPlayer.Backpack.Module)
ModuleKick.Tackle()
local A_1 = game:GetService("Workspace").TPSSystem.TPS
local A_2 = game:GetService("Players").LocalPlayer.Character.Head
local Event = game:GetService("Workspace").FE.Actions.Tackle
Event:FireServer(A_1, A_2)
end
end
end
end
end
if game.Players.LocalPlayer.TeamColor == BrickColor.new("Bright red") then
        if (game.Workspace.TPSSystem.TPS.Position - game.Workspace.TPSSystem.Part1.Position).Magnitude <= 125 then
        game.Players.LocalPlayer.PlayerGui.LockScript.SetLock.Value = true
game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.Position + Vector3.new(0, 45, 0),game.Workspace.BlueGoal.Part.Position)
game.Players.LocalPlayer.Character.Humanoid:MoveTo(game.Workspace.TPSSystem.TPS.Position)
for i,v in pairs(game.Workspace:GetDescendants()) do
    if v.Name == "TPS" and v:IsA("Part") then
    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude <= 6 then
       local ModuleKick = require(game:GetService("Players").LocalPlayer.Backpack.Module)
ModuleKick.Tackle()
local A_1 = game:GetService("Workspace").TPSSystem.TPS
local A_2 = game:GetService("Players").LocalPlayer.Character.Head
local Event = game:GetService("Workspace").FE.Actions.Tackle
Event:FireServer(A_1, A_2)
end
end
end
end
end
end
    else
        _G.AUTODEFENCE = false
        wait(1)
        game.Players.LocalPlayer.PlayerGui.LockScript.SetLock.Value = false
end
end)

SPage:CreateToggle("اوتو قتل", "Auto Changes Power Of The Kick By Distance. Just Click To Shoot", function(arg)
if arg then
_G.AUTOPOWER = true
while _G.AUTOPOWER do
wait()
    if game.Players.LocalPlayer.TeamColor == BrickColor.new("Bright blue") then
        if (game.Workspace.TPSSystem.TPS.Position - game.Workspace.TPSSystem.Part1.Position).Magnitude <= 90 then
        game.Players.LocalPlayer.Backpack.Speed.Value = 65
        game.Players.LocalPlayer.Backpack.Angle.Value = Vector3.new(4000000, 1000, 4000000)
        elseif (game.Workspace.TPSSystem.TPS.Position - game.Workspace.TPSSystem.Part1.Position).Magnitude > 99 then
        game.Players.LocalPlayer.Backpack.Speed.Value = 65
        game.Players.LocalPlayer.Backpack.Angle.Value = Vector3.new(4000000, 1100, 4000000)
    end
end
if game.Players.LocalPlayer.TeamColor == BrickColor.new("Bright red") then
        if (game.Workspace.TPSSystem.TPS.Position - game.Workspace.TPSSystem.Part2.Position).Magnitude <= 99 then
        game.Players.LocalPlayer.Backpack.Speed.Value = 65
        game.Players.LocalPlayer.Backpack.Angle.Value = Vector3.new(4000000, 1000, 4000000)
        elseif (game.Workspace.TPSSystem.TPS.Position - game.Workspace.TPSSystem.Part2.Position).Magnitude > 100 then
        game.Players.LocalPlayer.Backpack.Speed.Value = 65
        game.Players.LocalPlayer.Backpack.Angle.Value = Vector3.new(4000000, 1100, 4000000)
    end
end
end
    else
        _G.AUTOPOWER = false
end
end)



SPage:CreateToggle("اوتو تحسين ايم الباص / المناوله", "Locks/Faces At Your Teammate. Don't Use ShiftLock", function(arg)
if arg then
local Offset = CFrame.new(4, 0, 0)
    
    local BGyro = Instance.new("BodyGyro", game.Players.LocalPlayer.Character.HumanoidRootPart)
BGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
BGyro.P = 99999
BGyro.D = 500

_G.PLR = true
while _G.PLR do
wait()
for i,v in pairs(game.Players:GetPlayers()) do
                  if v.Name ~= game.Players.LocalPlayer.Character.Name and  (v.Character.Head.CFrame.p - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.p).Magnitude < DistancePass and Player.TeamColor == v.TeamColor then
                  local Direction = ((v.Character.Head.CFrame * Offset).p - game.Players.LocalPlayer.Character.HumanoidRootPart.Position) * Vector3.new(1, 0, 1)
BGyro.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Direction)
end
end
end
    else
    _G.PLR = false
    for i,v in pairs(game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
    if v.Name == "BodyGyro" then
    v:Destroy()
    end
    end
end
end)

SPage:CreateToggle("اوتو باص / مناوله", "Locks/Faces At Your Teammate. [lookAt Method]", function(arg)
if arg then
_G.LookAAA = true
while _G.LookAAA do
wait()
for i,v in pairs(game.Players:GetPlayers()) do
                  if v.Name ~= game.Players.LocalPlayer.Character.Name and  (v.Character.Head.CFrame.p - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.p).Magnitude < DistancePass and Player.TeamColor == v.TeamColor then
game.Players.LocalPlayer.PlayerGui.LockScript.SetLock.Value = true
game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.Position + Vector3.new(0, 45, 0),v.Character.HumanoidRootPart.Position)
end
end
end
    else
    _G.LookAAA = false
    wait(0.5)
    game.Players.LocalPlayer.PlayerGui.LockScript.SetLock.Value = false
end
end)
