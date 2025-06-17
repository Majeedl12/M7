
setclipboard("https://discord.gg/aDexK56tau")
game.StarterGui:SetCore("SendNotification", {
    Title = "تم نسخ رابط سيرفر المطورين",
    Text = "✅"
})

-- تحميل المكتبة
local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/aaaa"))()
local UI = GUI:CreateWindow("RL Team", "RedLine")

-- تعريف الخدمات
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = character:WaitForChild("HumanoidRootPart")

------------------------------
-- 🏠 صفحة الهوم
------------------------------
local Home = UI:addPage("Home", 1, true, 6)

Home:addLabel("RL Team", "Don't use in games with anti cheats")

Home:addButton("RESET | ريسيت", function()
    LocalPlayer.Character.Humanoid.Health = 0
end)

Home:addToggle("جري | Sprint", function(value)
    LocalPlayer.Character.Humanoid.WalkSpeed = value and 40 or 16
end)

Home:addTextBox("السرعه | Walkspeed", "Number here", function(val)
    LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(val)
end)

Home:addTextBox("Jump Power | قوه النط", "Number here", function(val)
    LocalPlayer.Character.Humanoid.JumpPower = tonumber(val)
end)

------------------------------
-- 🎮 صفحة Misc
------------------------------
local PE = UI:addPage("Misc", 2, true, 6)

 
PE:addButton("Fling Touch",function()
    
local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))();
local Notify = AkaliNotif.Notify;
Notify({
Description = "RL TEAM";
Title = "RedLine :).";
Duration = 10;
});
loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe./main/Fling%20GUI"))()

    game.StarterGui:SetCore("SendNotification",{
        Title = "تم الضغط";
        Text = "Clicked✅";
    })
end)


PE:addButton("سكربت العاده - JerkOff",function()
     loadstring(game:HttpGet("https://pastebin.com/raw/YiSqWZ78"))()
    game.StarterGui:SetCore("SendNotification",{
        Title = "تم الضغط";
        Text = "Clicked✅";
    })
end)

------------------------------
-- 🎯 TargetInfo Page
------------------------------
local PD = UI:addPage("TargetInfo", 3, true, 6)
PD:addLabel("Script message", "Script Made By RL Team")

local selectedPlayerName = nil

PD:addTextBox("اختيار اللاعب", "ادخل اول حرفين من الاسم", function(input)
    input = input:lower()
    selectedPlayerName = nil
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #input) == input or p.DisplayName:lower():sub(1, #input) == input then
            selectedPlayerName = p.Name
            StarterGui:SetCore("SendNotification", {
                Title = "تم اختيار اللاعب",
                Text = "اللاعب: " .. p.Name,
                Duration = 3
            })
            break
        end
    end
end)

-- Bang خلفي
PD:addToggle("Bang | تغتصبه", function(state)
    local target = Players:FindFirstChild(selectedPlayerName)
    if not target then return end
    _G["BackBangFlag"] = state
    coroutine.wrap(function()
        while _G["BackBangFlag"] and target.Character and HRP do
            local offset = Vector3.new(0, -1.05, 0.58)
            local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                TweenService:Create(HRP, TweenInfo.new(0.12), {CFrame = targetHRP.CFrame * CFrame.new(offset)}):Play()
                wait(0.12)
                TweenService:Create(HRP, TweenInfo.new(0.12), {CFrame = targetHRP.CFrame * CFrame.new(offset + Vector3.new(0, 0, 0.3))}):Play()
                wait(0.12)
            end
        end
    end)()
end)

-- Bang أمامي
PD:addToggle("GetBanged | يغتصبك", function(state)
    local target = Players:FindFirstChild(selectedPlayerName)
    if not target then return end
    _G["FrontBangFlag"] = state
    coroutine.wrap(function()
        while _G["FrontBangFlag"] and target.Character and HRP do
            local offset = Vector3.new(0, -1.05, -0.4)
            local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                TweenService:Create(HRP, TweenInfo.new(0.12), {CFrame = targetHRP.CFrame * CFrame.new(offset)}):Play()
                wait(0.12)
                TweenService:Create(HRP, TweenInfo.new(0.12), {CFrame = targetHRP.CFrame * CFrame.new(offset + Vector3.new(0, 0, -0.3))}):Play()
                wait(0.12)
            end
        end
    end)()
end)

PD:addToggle("Spectate | مشاهدة", function(state)
    local target = Players:FindFirstChild(selectedPlayerName)
    if target and target.Character then
        Camera.CameraSubject = state and target.Character:FindFirstChild("Humanoid") or LocalPlayer.Character:FindFirstChild("Humanoid")
    end
end)

PD:addToggle("ESP | كشف", function(state)
    local target = Players:FindFirstChild(selectedPlayerName)
    if not target or not target.Character then return end
    if state then
        local hl = Instance.new("Highlight", target.Character)
        hl.Name = "ESP"
        hl.FillColor = Color3.fromRGB(255, 0, 0)
        hl.FillTransparency = 0.5
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    else
        local esp = target.Character:FindFirstChild("ESP")
        if esp then esp:Destroy() end
    end
end)

PD:addButton("Teleport | تنقل عنده", function()
    local target = Players:FindFirstChild(selectedPlayerName)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character:MoveTo(target.Character.HumanoidRootPart.Position + Vector3.new(2, 0, 2))
    end
end)

------------------------------
-- 🛡️ صفحة الحماية
------------------------------
local SK = UI:addPage("Protection", 4, true, 6)

local AntiFling = false
local AntiRape = false
local AntiAFK = false

RunService.Heartbeat:Connect(function()
    if AntiFling then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                for _, obj in pairs(p.Character:GetDescendants()) do
                    if obj:IsA("BodyVelocity") or obj:IsA("AngularVelocity") then
                        obj:Destroy()
                    end
                end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if AntiRape then
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local otherHRP = p.Character.HumanoidRootPart
                if (hrp.Position - otherHRP.Position).Magnitude < 5 and hrp.CFrame.LookVector:Dot((otherHRP.Position - hrp.Position).Unit) < -0.5 then
                    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(180), 0)
                end
            end
        end
    end
end)

SK:addToggle("🌀 مضاد Fling", function(state) AntiFling = state end)
SK:addToggle("🍑 مضاد Bang", function(state) AntiRape = state end)
SK:addToggle("💤 مضاد AFK", function(state)
    AntiAFK = state
    if state then
        LocalPlayer.Idled:Connect(function()
            VirtualUser:Button2Down(Vector2.new(), workspace.CurrentCamera.CFrame)
            wait(1)
            VirtualUser:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame)
        end)
    end
end)

------------------------------
-- 🙌 صفحة الكريدت
------------------------------
local LND = UI:addPage("Credits", 5, true, 6)

LND:addLabel("مطورين السكربت", "Majed627 / https://discord.gg/aDexK56tau")

LND:addButton("نسخ رابط السيرفر", function()
    setclipboard("https://discord.gg/aDexK56tau")
    StarterGui:SetCore("SendNotification", {Title = "تم نسخ الرابط", Text = "✅"})
end)

LND:addButton("نسخ يوزر المطور", function()
    setclipboard("Majed627")
    StarterGui:SetCore("SendNotification", {Title = "تم نسخ اليوزر", Text = "✅"})
end)

