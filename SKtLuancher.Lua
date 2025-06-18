
-- إشعار ونسخ رابط الديسكورد
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

Home:addButton("سكربت العاده - JerkOff",function()
     loadstring(game:HttpGet("https://pastebin.com/raw/YiSqWZ78"))()
    game.StarterGui:SetCore("SendNotification",{
        Title = "تم الضغط";
        Text = "Clicked✅";
    })
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
-- 🎯 TargetInfo Page
------------------------------
local PD = UI:addPage("TargetInfo", 2, true, 6)
PD:addLabel("RL Team", "لمن تفعل طير المستهدف حاول تنتظر ثلاث ثواني عشان يطير")

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local selectedPlayerName = nil
local selectedPlayerObject = nil
local safePosition = nil
local HRP = nil
local FlingConnection = nil
local ESPObject = nil
local BackBangFlag = false
local FrontBangFlag = false

-- اختيار اللاعب
PD:addTextBox("اختيار اللاعب", "ادخل اول حرفين من الاسم", function(input)
    input = input:lower()
    selectedPlayerName = nil
    selectedPlayerObject = nil

    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #input) == input or p.DisplayName:lower():sub(1, #input) == input then
            selectedPlayerName = p.Name
            selectedPlayerObject = p

            StarterGui:SetCore("SendNotification", {
                Title = "✅ تم اختيار اللاعب",
                Text = "اللاعب: " .. p.Name,
                Duration = 3
            })

            -- إشعار عند الخروج
            p.AncestryChanged:Connect(function()
                if not p:IsDescendantOf(game) then
                    StarterGui:SetCore("SendNotification", {
                        Title = "🚫 اللاعب خرج",
                        Text = p.Name .. " غادر السيرفر",
                        Duration = 4
                    })
                    selectedPlayerName = nil
                    selectedPlayerObject = nil
                end
            end)
            break
        end
    end
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local flingConnection
local flingActive = false
local savedPosition = nil

PD:addToggle("Fling | طير المستهدف", function(state)
    flingActive = state

    local target = Players:FindFirstChild(selectedPlayerName)
    local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") or not HRP then
        return
    end

    local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")

    if flingConnection then
        flingConnection:Disconnect()
        flingConnection = nil
    end

    if state then
        savedPosition = HRP.Position

        flingConnection = RunService.Heartbeat:Connect(function()
            if not flingActive or not targetHRP or not HRP then return end

            -- الالتصاق بالمستهدف
            HRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 0)

            -- قوة الفلنق (Touch fling)
            local vel = HRP.Velocity
            HRP.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
            RunService.RenderStepped:Wait()
            HRP.Velocity = vel
            RunService.Stepped:Wait()
            HRP.Velocity = vel + Vector3.new(0, 0.1, 0)
        end)
    else
        if flingConnection then
            flingConnection:Disconnect()
            flingConnection = nil
        end

        -- يرجع اللاعب لمكانه الآمن
        if savedPosition and HRP then
            HRP.CFrame = CFrame.new(savedPosition + Vector3.new(0, 3, 0))
        end
    end
end)

-- Bang | تغتصبه (خلفي)
PD:addToggle("Bang | تغتصبه", function(state)
    local target = Players:FindFirstChild(selectedPlayerName)
    HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not target or not HRP then return end

    BackBangFlag = state
    coroutine.wrap(function()
        while BackBangFlag and target.Character and HRP do
            local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                local offset1 = Vector3.new(0, -1.05, 0.58)
                local offset2 = Vector3.new(0, -1.05, 0.88)
                TweenService:Create(HRP, TweenInfo.new(0.12), {CFrame = targetHRP.CFrame * CFrame.new(offset1)}):Play()
                wait(0.12)
                TweenService:Create(HRP, TweenInfo.new(0.12), {CFrame = targetHRP.CFrame * CFrame.new(offset2)}):Play()
                wait(0.12)
            end
        end
    end)()
end)

-- GetBanged | يغتصبك (أمامي)
PD:addToggle("GetBanged | يغتصبك", function(state)
    local target = Players:FindFirstChild(selectedPlayerName)
    HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not target or not HRP then return end

    FrontBangFlag = state
    coroutine.wrap(function()
        while FrontBangFlag and target.Character and HRP do
            local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                local offset1 = Vector3.new(0, -1.05, -0.4)
                local offset2 = Vector3.new(0, -1.05, -0.7)
                TweenService:Create(HRP, TweenInfo.new(0.12), {CFrame = targetHRP.CFrame * CFrame.new(offset1)}):Play()
                wait(0.12)
                TweenService:Create(HRP, TweenInfo.new(0.12), {CFrame = targetHRP.CFrame * CFrame.new(offset2)}):Play()
                wait(0.12)
            end
        end
    end)()
end)

-- Spectate | مشاهدة
PD:addToggle("Spectate | مشاهدة", function(state)
    local target = Players:FindFirstChild(selectedPlayerName)
    if target and target.Character then
        Camera.CameraSubject = state and target.Character:FindFirstChild("Humanoid") or LocalPlayer.Character:FindFirstChild("Humanoid")
    end
end)

-- ESP | كشف
PD:addToggle("ESP | كشف", function(state)
    local target = Players:FindFirstChild(selectedPlayerName)
    if not target or not target.Character then return end

    if state then
        if not target.Character:FindFirstChild("ESP") then
            ESPObject = Instance.new("Highlight", target.Character)
            ESPObject.Name = "ESP"
            ESPObject.FillColor = Color3.fromRGB(255, 0, 0)
            ESPObject.FillTransparency = 0.5
            ESPObject.OutlineColor = Color3.fromRGB(255, 255, 255)
        end
    else
        if ESPObject then ESPObject:Destroy() end
    end
end)

-- Teleport | تنقل عنده
PD:addButton("Teleport | تنقل عنده", function()
    local target = Players:FindFirstChild(selectedPlayerName)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character:MoveTo(target.Character.HumanoidRootPart.Position + Vector3.new(2, 0, 2))
    end
end)

------------------------------
-- 🛡️ صفحة الحماية
------------------------------
local SK = UI:addPage("Protection", 3, true, 6)

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
local LND = UI:addPage("Credits", 4, true, 6)

LND:addLabel("مطورين السكربت", "Majed627 / https://discord.gg/aDexK56tau")

LND:addButton("نسخ رابط السيرفر", function()
    setclipboard("https://discord.gg/aDexK56tau")
    StarterGui:SetCore("SendNotification", {Title = "تم نسخ الرابط", Text = "✅"})
end)

LND:addButton("نسخ يوزر المطور", function()
    setclipboard("Majed627")
    StarterGui:SetCore("SendNotification", {Title = "تم نسخ اليوزر", Text = "✅"})
end)

