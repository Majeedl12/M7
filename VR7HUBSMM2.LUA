--LocalPlayer Name
local Player = game.Players.LocalPlayer
--الصفحه الرئيسيه
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
OrionLib:MakeNotification({
	Name = "انتظر ...",
	Content = "اصبر",
	Image = "rbxassetid://4483345998",
	Time = 3
})
local Window = OrionLib:MakeWindow({Name = "VR7Hubs | Murder Mystery", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
OrionLib:MakeNotification({
	Name = "تم تفعيل السكربت!",
	Content = "Loaded The MM2 UI, "..Player.Name.."!",
	Image = "rbxassetid://4483345998",
	Time = 3
})
--Tabs
local Tab2 = Window:MakeTab({
	Name = "الصفحه الرئيسيه",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Tab3 = Window:MakeTab({
	Name = "الفارم",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Tab4 = Window:MakeTab({
	Name = "كشف الاماكن",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Tab5 = Window:MakeTab({
	Name = "التخريب",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Tab6 = Window:MakeTab({
	Name = "الحقوق",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
--فارم
local Section = Tab2:AddSection({
	Name = "لازم يكون معك سكربت كيبورد"
})
Tab2:AddBind({
	Name = "التنقل الى المسدس",
	Default = Enum.KeyCode.Q,
	Hold = false,
	Callback = function()
			local currentX = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X
	local currentY = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y
	local currentZ = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z	

	if workspace:FindFirstChild("GunDrop") ~= nil then

		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("GunDrop").CFrame	
		wait(1)	
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(currentX, currentY, currentZ)

	else
OrionLib:MakeNotification({
	Name = "المسدس مو في الارض",
	Content = "برو المسدس مب طايح",
	Image = "rbxassetid://4483345998",
	Time = 3
})
	end
	end    
})
local Section = Tab2:AddSection({
	Name = " Q اضغط حرف عشان تاخذ المسدس"
})
Tab2:AddButton({
 Name = "سكربت كيبورد",
 Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
   end    
})
local Section = Tab2:AddSection({
	Name = " E اضغط حرف  عشان تقتل الكل"
})
Tab2:AddBind({
	Name = "قتل الكل)فقط القاتل)",
	Default = Enum.KeyCode.E,
	Hold = false,
	Callback = function()
			if game.Players.LocalPlayer.Backpack:FindFirstChild("Knife") ~= nil then -- Only works if you're the murderer

		local Players = game:GetService("Players")	
		for i, Victim in pairs(Players:GetPlayers()) do
			if Victim.Name ~= game.Players.LocalPlayer.Name then

				repeat wait()
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Victim.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
				until
				Victim.Character.Humanoid.Health == 0

			end
		end

	else
OrionLib:MakeNotification({
	Name = "حصل خطأ",
	Content = "ما قتلت ولا شخص",
	Image = "rbxassetid://4483345998",
	Time = 3
})
		print("No victims killed")
	end
	end    
})

--فارم
local Section = Tab3:AddSection({
	Name = "فارم"
})
Tab3:AddToggle({
	Name = "فارم كوينز",
	Default = false,
	Callback = function(value)
getgenv().Farm = (value)
while getgenv().Farm == true do
			local place = workspace:GetChildren()	
			local currentX = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X
			local currentY = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y
			local currentZ = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z

			for i,v in pairs(place) do	    
			    local vChildren = v:GetChildren()
			    for i,child in pairs(vChildren) do
			        if child.Name == "CoinContainer" then

						if child.Coin_Server:FindFirstChild("Coin") ~= nil then
				            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = child.Coin_Server.Coin.CFrame
						else
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(currentX, currentY, currentZ)
						end

			        end
			    end	
			end
wait(2)
end
	end    
})
--كشف اماكن الناس
local Section = Tab4:AddSection({
	Name = "كشف اماكن الناس"
})
Tab4:AddButton({
 Name = "كشف اماكن الناس",
 Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/M7majed/ScriptsByM7/main/ESP_majedLocalend.LUA"))()
   end    
})
Tab4:AddButton({
 Name = "كشف القاتل و الشرف و البريئ",
 Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/SH7SwQvy"))()
   end    
})
--التخريب
local Section = Tab5:AddSection({
	Name = "التخريب"
})
Tab5:AddButton({
	Name = "سكين اكس بوكس مجاني ",
	Callback = function()
      		OrionLib:MakeNotification({
	Name = "زبط!",
	Content = "مبروك السكين",
	Image = "rbxassetid://4483345998",
	Time = 3
})
	local Event = game:GetService("ReplicatedStorage").Remotes.Extras.IsXbox
	Event:FireServer(A_1)
  	end    
})
Tab5:AddToggle({
	Name = "عدم الموت",
	Default = false,
	Callback = function(value)
getgenv().God = (value)
while getgenv().God == true do
game.Players.LocalPlayer.Character.Humanoid:Remove()
Instance.new('Humanoid', game.Players.LocalPlayer.Character)
game:GetService("Workspace")[game.Players.LocalPlayer.Name]:FindFirstChildOfClass(
'Humanoid').HipHeight = 2
wait(10)
end
	end    
})
Tab5:AddToggle({
	Name = "تجميع كوين Aura",
	Default = false,
	Callback = function(value)
getgenv().God = (value)
while getgenv().God == true do
local Playeer = game:GetService('Players').LocalPlayer
Playeer.Character.LeftLowerLeg.Size = Vector3.new(15, 2, 2)
Playeer.Character.RightLowerLeg.Size = Vector3.new(15, 2, 2)
Playeer.Character.LeftUpperLeg.Size = Vector3.new(15, 2, 2)
Playeer.Character.RightUpperLeg.Size = Vector3.new(15, 2, 2)
Playeer.Character.RightFoot.Size = Vector3.new(15, 2, 2)
Playeer.Character.LeftFoot.Size = Vector3.new(15, 2, 2)
Playeer.Character.LeftLowerLeg.CanCollide = true
Playeer.Character.RightLowerLeg.CanCollide = true
Playeer.Character.LeftUpperLeg.CanCollide = true
Playeer.Character.RightUpperLeg.CanCollide = true
Playeer.Character.RightFoot.CanCollide = true
Playeer.Character.LeftFoot.CanCollide = true
Playeer.Character.LeftLowerLeg.Transparency = 1
Playeer.Character.RightLowerLeg.Transparency = 1
Playeer.Character.LeftUpperLeg.Transparency = 1
Playeer.Character.RightUpperLeg.Transparency = 1
Playeer.Character.RightFoot.Transparency = 1
Playeer.Character.LeftFoot.Transparency = 1
wait(10)
end
	end    
})
Tab5:AddButton({
	Name = "تهكير الشات . لازم تضغط حرف r و يشتغل",
	Callback = function()
      		local key = "r" -- the toxic key
_G.Toxic = false
 
local words = 
    {
        "ez kid",
        "im not hacking kid",
        "L",
        "loser",
        "sonned",
        "gg ez",
        "owned",
        "suck",
        "dogwater",
        "ur mom",
        "clown",
        "ez clown kid",
        "ur worst",
        "ligma",
        "ur bad",
        "seed",
        "kid",
        "ngl ur trash",
        "trash",
        "garbage",
        "litter",
        "adopted"
    }
 
local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()
 
local event = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
 
mouse.KeyDown:Connect(function(keybind)
    if _G.Toxic == false then
        if keybind == key then
            event:FireServer(words[math.random(#words)], "normalchat")
        end
    end
end)
  	end    
})
Tab5:AddButton({
	Name = "كشف اسم القاتل. لازم تكون في القيم",
	Callback = function()

local players = game.Players:GetPlayers()

for i,v in ipairs(players) do
  if v.Backpack:FindFirstChild("Knife") or (v.Character and v.Character:FindFirstChild("Knife")) then
  game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(v.Name .. " is the murderer!", "normalchat")
break
  end
end
end
})
Tab5:AddButton({
	Name = "كشف اسم الشرف . لازم تكون في قيم",
	Callback = function()

local players = game.Players:GetPlayers()

for i,v in ipairs(players) do
  if v.Backpack:FindFirstChild("Gun") or (v.Character and v.Character:FindFirstChild("Gun")) then
  game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(v.Name .. " is the sheriff!", "normalchat")
break
  end
end
end
})


--اللاعب
local Section = Tab6:AddSection({
	Name = "by VR7"
})
Tab6:AddButton({
    Name = "نسخ سيرفري بالديسكورد",
    Callback = function()
    setclipboard("https://discord.gg/dSgPgf9Z")
            print("link copied to clipoard")
      end
})
local Section = Tab6:AddSection({
	Name = "شكرا عشانك استخدمت السكربت"
})

Tab6:AddButton({
    Name = "نسخ اسمي بالديسكورد",
    Callback = function()
    setclipboard("v_r7")
            print("link copied to clipoard")
      end
})
