local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/aaaa"))()

local UI = GUI:CreateWindow("VR7Hubs","اتمنى يعجبك السكربت يقلبي")

local Home = UI:addPage("Main",1,true,6)

Home:addButton("قتل من بعيد",function()
    game.StarterGui:SetCore("SendNotification",{
        Title = "تم تفعيل قتل من بعيد";
        Text = "by VR7";
    })
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Majeedl12/ScriptsByM7/main/Reach%20sword_fe.lua'))()
end)

Home:addTextBox("زياده الدم | الحد ١٠٠","Number here",function(value)
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)

-- Just an example of how you would actually use it i guess

local LP = UI:addPage("Other",1,true,6)

-- Label

LP:addLabel("سكربت بسيط وحلو","استمتع")


LP:addLabel("استمتع","قائمه اللاعب")
LP:addSlider("السرعه",16,150,function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)
LP:addTextBox("النط","Number here",function(value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
end)

LP:addButton("قتل نفسك",function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)

-- Dropdown 

local PLIST = {}

for i,v in pairs(game:GetService("Players"):GetPlayers()) do
    table.insert(PLIST,v.DisplayName)
end

LP:addDropdown("تنقل الى اللاعب",PLIST,4,function(value)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[value].Character.HumanoidRootPart.CFrame * CFrame.new(0,2,1)
end)
local Player = UI:addPage("الحقوق",1,true,6)
Player:addLabel("by VR7","SCRIPT VR7")
Player:addButton("نسخ رابط سيرفر الديسكورد",function()
    setclipboard("https://discord.gg/XafjTNQg")
            print("link copied to clipoard")
end)
Player:addButton("نسخ اسم قناه اليوتيوب",function()
        setclipboard("VR7")
            print("link copied to clipoard")
end)
