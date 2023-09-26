-- orion
_G.autoTap = false
_G.autoEgg = false
_G.autoRebirth = false
_G.speedNumber = 16
_G.jumpNumber = 16
_G.selectedRebirth = 1
_G.selectedEgg = "basic"
_G.selectedWorld = "Lava"
_G.selectedUpgrade = "ClickMultiply"
_G.autoUpgrade = false
local clickMod = require(game.Players.LocalPlayer.PlayerScripts.Aero.Controllers.UI.Click)

function doTap()
    while _G.autoTap == true do
        clickMod:Click()
        wait()
    end
end
function doRebirth()
    while _G.autoRebirth == true do
        local args = {[1] = _G.selectedRebirth}
        game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.RebirthService.BuyRebirths:FireServer(unpack(args))
        wait()
    end
end
function doEgg()
    while _G.autoEgg == true do
        local args = {[1] = _G.selectedEgg}
        game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.EggService.Purchase:FireServer(unpack(args))
        wait()
    end
end
function teleportTO(placeCFrame)
    local plyr = game.Players.LocalPlayer;
    if plyr.Character then
        plyr.Character.HumanoidRootPart.CFrame = placeCFrame;
    end
end
function teleportWorld()
    if game:GetService("Workspace").Worlds:FindFirstChild(_G.selectedWorld) then
        teleportTO(game:GetService("Workspace").Worlds[_G.selectedWorld].Teleport.CFrame)
    end
end
function doSpeed()
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.speedNumber
    end
end
function doJump()
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = _G.jumpNumber
    end
end
function doUpgrade()
    while _G.autoUpgrade == true do
        local args = {
        [1] = _G.selectedUpgrade}
        game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.UpgradeService.BuyUpgrade:FireServer(unpack(args))
        wait()
    end
end




if game.PlaceId == 5490351219 then
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "RM7Hubs | Clicker Madness", HidePremium = false, IntroText = "by 2ivsl majed", SaveConfig = true, ConfigFolder = "OrionTest"})


--tabs
local FarmTab = Window:MakeTab({
	Name = "الاوتو فارم",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local EggTab = Window:MakeTab({
	Name = "البيض",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Teleport = Window:MakeTab({
	Name = "التنقل",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Player = Window:MakeTab({
	Name = "اللاعب",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Upgrade = Window:MakeTab({
	Name = "اوتو تحديث / Ubgrade",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})


--toggles
Upgrade:AddDropdown({
	Name = "اختار التحديث / Upgrade",
	Default = _G.selectedUpgrade,
	Options = {"ClickMultiply","CursorDamage", "Health","JumpPower","PetStorage","WalkSpeed"},
	Callback = function(Value)
        _G.selectedUpgrade = Value
	end    
})
Upgrade:AddToggle({
	Name = "اوتو Upgrade",
	Default = false,
	Callback = function(Value)
        _G.autoUpgrade = Value
        doUpgrade()
	end    
})
FarmTab:AddToggle({
	Name = "اوتو كليكر",
	Default = false,
	Callback = function(Value)
        _G.autoTap = Value
        doTap()
	end    
})
FarmTab:AddToggle({
	Name = "اوتو ريبيرت / Rebirth",
	Default = false,
	Callback = function(Value)
        _G.autoRebirth = Value
        doRebirth()
	end    
})
Player:AddSlider({
	Name = "سرعه",
	Min = 16,
	Max = 200,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	Callback = function(Value)
        _G.speedNumber = Value
        doSpeed()
	end    
})
Player:AddSlider({
	Name = "نط",
	Min = 16,
	Max = 200,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	Callback = function(Value)
        _G.jumpNumber = Value
        doJump()
	end    
})
FarmTab:AddDropdown({
	Name = "اختار الريبيرت / Rebirth",
	Default = "1",
	Options = {"1", "10","100","1000","10000","100000","1000000","10000000"},
	Callback = function(Value)
        _G.selectedRebirth = Value
        print(_G.selectedRebirth)
	end    
})
EggTab:AddToggle({
	Name = "اوتو فتح البيض",
	Default = false,
	Callback = function(Value)
        _G.autoEgg = Value
        doEgg()
	end    
})
EggTab:AddDropdown({
	Name = "اختار بيضه",
    Default = _G.selectedEgg,
	Options = {"basic","lava","desert","ocean","winter","toxic","candy","forest","storm","blocky","space","dominus","infinity","future","city","moon","fire"},
	Callback = function(Value)
        _G.selectedEgg = Value
	end    
})
Teleport:AddButton({
	Name = "التنقل الى العالم المختار",
	Callback = function()
        teleportWorld()
  	end    
})
Teleport:AddDropdown({
	Name = "اختر العالم ",
    Default = _G.selectedWorld,
	Options = {"Lava","Desert","Ocean","Winter","Toxic","Candy","Forest","Strom","Blocks","Space","Dominus","Infinity","Future","City","Moon","Fire"},
	Callback = function(Value)
        _G.selectedWorld = Value
	end    
})

OrionLib:Init()
end
