
-- RL Team GUI [كامل ومصحح - نسخة واحدة]

-- نسخ رابط الديسكورد
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

local HRP = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
HRP = HRP:WaitForChild("HumanoidRootPart")

-- 🏠 صفحة البداية
local Home = UI:addPage("Menu | البدايه 🏠", 1, true, 6)
Home:addLabel("تم نسخ رابط سيرفرنا دسكورد خش سيرفرنا عشان تشوف كل شي", "تم صنع السكربت بواسطه RL Team ")

-- كشف الكل
local allESPActive = false
local allESPList = {}

local function AddESPToPlayer(player)
    if player == LocalPlayer then return end
    if not player.Character then return end

    -- Highlight
    if not player.Character:FindFirstChild("ESP_HL") then
        local hl = Instance.new("Highlight")
        hl.Name = "ESP_HL"
        hl.FillColor = Color3.fromRGB(255, 255, 255) -- جسم أبيض
        hl.OutlineColor = Color3.fromRGB(0, 0, 0) -- أطراف سوداء
        hl.FillTransparency = 0.3
        hl.OutlineTransparency = 0
        hl.Parent = player.Character
        allESPList[player] = hl
    end

    -- Billboard للاسم
    if not player.Character:FindFirstChild("ESP_Name") then
        local head = player.Character:FindFirstChild("Head")
        if head then
            local tag = Instance.new("BillboardGui")
            tag.Name = "ESP_Name"
            tag.Size = UDim2.new(0, 100, 0, 20)
            tag.StudsOffset = Vector3.new(0, 2, 0)
            tag.AlwaysOnTop = true
            tag.Parent = head

            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = player.Name
            nameLabel.TextColor3 = Color3.fromRGB(0, 170, 255) -- أزرق
            nameLabel.TextScaled = true
            nameLabel.Font = Enum.Font.SourceSansSemibold
            nameLabel.TextSize = 12
            nameLabel.Parent = tag
        end
    end
end

local function RemoveESPFromPlayer(player)
    if player.Character then
        local hl = player.Character:FindFirstChild("ESP_HL")
        local tag = player.Character:FindFirstChild("ESP_Name")
        if hl then hl:Destroy() end
        if tag then tag:Destroy() end
    end
    allESPList[player] = nil
end

Home:addToggle(" كشف الكل | ESP ALL", function(state)
    allESPActive = state

    if state then
        -- إضافة ESP لجميع اللاعبين الحاليين
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                AddESPToPlayer(p)
            end
        end

        -- متابعة أي لاعب جديد يدخل
        Players.PlayerAdded:Connect(function(p)
            p.CharacterAdded:Connect(function()
                wait(1) -- ننتظر ظهور الشخصية
                if allESPActive then
                    AddESPToPlayer(p)
                end
            end)
        end)

        -- متابعة اللاعبين الحاليين اللي يعيدون شخصياتهم
        for _, p in ipairs(Players:GetPlayers()) do
            p.CharacterAdded:Connect(function()
                wait(1)
                if allESPActive then
                    AddESPToPlayer(p)
                end
            end)
        end

    else
        -- إزالة كل ESP
        for _, p in pairs(Players:GetPlayers()) do
            RemoveESPFromPlayer(p)
        end
    end
end)

-- إعادة الدخول
Home:addButton("Rejoin | إعادة دخول", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)


-- 🎯 صفحة TargetInfo | المستهدف
local PD = UI:addPage("🎯 TargetInfo | المستهدف", 2, true, 6)

local selectedPlayerName = nil
local selectedPlayerObject = nil
local flingConnection = nil

-- اختيار اللاعب
PD:addTextBox("اختيار اللاعب", "اكتب اول حرف من اسمه", function(input)
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #input) == input:lower() then
            selectedPlayerName = p.Name
            selectedPlayerObject = p
            StarterGui:SetCore("SendNotification", {
                Title = "تم تحديد اللاعب",
                Text = selectedPlayerName,
                Duration = 3
            })
            -- رصد خروج اللاعب من السيرفر
            p.AncestryChanged:Connect(function()
                if not p:IsDescendantOf(game) then
                    StarterGui:SetCore("SendNotification", {
                        Title = "🚫 اللاعب خرج",
                        Text = p.Name .. " غادر السيرفر",
                        Duration = 4
                    })
                    selectedPlayerName = nil
                    selectedPlayerObject = nil
                    -- فصل الفلنق إذا كان شغال
                    if flingConnection then
                        flingConnection:Disconnect()
                        flingConnection = nil
                    end
                    StopBang()
                    StopGetBanged()
                end
            end)
            break
        end
    end
end)

-- زر تنقل للاعب
PD:addButton("تنقل للمستهدف | TP To Target", function()
    if selectedPlayerObject and selectedPlayerObject.Character then
        local p = selectedPlayerObject.Character:FindFirstChild("HumanoidRootPart")
        if p then 
            LocalPlayer.Character:MoveTo(p.Position + Vector3.new(2,0,2))
        end
    end
end)

-- فلنق toggle
PD:addToggle("طير المستهدف | Fling Target", function(state)
    if flingConnection then flingConnection:Disconnect() flingConnection = nil end
    if not selectedPlayerObject or not selectedPlayerObject.Character then return end
    local targetHRP = selectedPlayerObject.Character:FindFirstChild("HumanoidRootPart")
    local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetHRP or not myHRP then return end

    if state then
        flingConnection = RunService.Heartbeat:Connect(function()
            if not targetHRP or not myHRP then return end
            myHRP.CFrame = targetHRP.CFrame
            myHRP.Velocity = Vector3.new(1e5, 1e5, 1e5)
        end)
    else
        if flingConnection then flingConnection:Disconnect() flingConnection = nil end
    end
end)

-- متغيرات تحكم يغتصب اللاعب (Bang)
local BangActive = false
local BangConnection = nil

-- GetBanged Variables
local GetBangedActive = false
local GetBangedConnection = nil

local function StartBang()
    if not selectedPlayerObject or not selectedPlayerObject.Character then return end
    local targetHRP = selectedPlayerObject.Character:FindFirstChild("HumanoidRootPart")
    local myChar = LocalPlayer.Character
    if not targetHRP or not myChar then return end
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    local myHumanoid = myChar:FindFirstChildOfClass("Humanoid")
    if not myHRP or not myHumanoid then return end

    BangActive = true
    local forward = true
    local lastSwitch = tick()

    BangConnection = RunService.Heartbeat:Connect(function()
        if not BangActive then return end
        if not targetHRP or not targetHRP.Parent then return end

        myHumanoid.Sit = true

        if tick() - lastSwitch >= 0.10 then
            forward = not forward
            lastSwitch = tick()
        end

        local offset = forward and CFrame.new(0, 0, 1.2) or CFrame.new(0, 0, 2)
        myHRP.CFrame = targetHRP.CFrame * offset
    end)
end

local function StopBang()
    BangActive = false
    if BangConnection then
        BangConnection:Disconnect()
        BangConnection = nil
    end
    local myHumanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if myHumanoid then
        myHumanoid.Sit = false
    end
end

local function StartGetBanged()
    if not selectedPlayerObject or not selectedPlayerObject.Character then return end
    local myChar = LocalPlayer.Character
    local targetChar = selectedPlayerObject.Character
    if not myChar or not targetChar then return end

    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
    if not myHRP or not targetHRP then return end

    GetBangedActive = true
    local forward = true
    local lastSwitch = tick()

    GetBangedConnection = RunService.Heartbeat:Connect(function()
        if not GetBangedActive then return end
        if not myHRP or not myHRP.Parent then return end

        if tick() - lastSwitch >= 0.07 then
            forward = not forward
            lastSwitch = tick()
        end

        local offset = forward and CFrame.new(0, 0, -1.5) or CFrame.new(0, 0, -2.2)
        myHRP.CFrame = targetHRP.CFrame * offset
    end)
end

local function StopGetBanged()
    GetBangedActive = false
    if GetBangedConnection then
        GetBangedConnection:Disconnect()
        GetBangedConnection = nil
    end
end

-- Toggles في القائمة
PD:addToggle("يغتصب اللاعب | Bang", function(state)
    if not selectedPlayerObject then
        StarterGui:SetCore("SendNotification", {Title = "خطأ", Text = "لم يتم اختيار لاعب", Duration = 3})
        return false
    end
    if state then
        StartBang()
    else
        StopBang()
    end
end)

PD:addToggle("يغتصبك | GetBanged", function(state)
    if not selectedPlayerObject then
        StarterGui:SetCore("SendNotification", {Title = "خطأ", Text = "لم يتم اختيار لاعب", Duration = 3})
        return false
    end
    if state then
        StartGetBanged()
    else
        StopGetBanged()
    end
end)

local HeadBangActive = false
local HeadBangConnection = nil

local moveDistance = 0.07 -- مدى التقديم والترجيع
local moveSpeed = 2
local forward = true
local currentOffset = 0

local function StartHeadBang()
    if not selectedPlayerObject or not selectedPlayerObject.Character then return end
    local targetHead = selectedPlayerObject.Character:FindFirstChild("Head")
    local myChar = LocalPlayer.Character
    if not targetHead or not myChar then return end

    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end

    HeadBangActive = true
    forward = true
    currentOffset = 0

    HeadBangConnection = RunService.Heartbeat:Connect(function(dt)
        if not HeadBangActive then return end
        if not targetHead or not targetHead.Parent then return end

        -- تحديث مقدار الحركة
        if forward then
            currentOffset += moveSpeed * dt
            if currentOffset >= moveDistance then
                currentOffset = moveDistance
                forward = false
            end
        else
            currentOffset -= moveSpeed * dt
            if currentOffset <= 0 then
                currentOffset = 0
                forward = true
            end
        end
    end)
end

-- مشاهدة اللاعب
PD:addToggle("مشاهده المستهدف | View", function(state)
    if selectedPlayerObject and selectedPlayerObject.Character then
        Camera.CameraSubject = state and selectedPlayerObject.Character:FindFirstChild("Humanoid") or LocalPlayer.Character:FindFirstChild("Humanoid")
    end
end)

-- كشف اللاعب ESP
PD:addToggle("كشف المستهدف | ESP", function(state)
    if selectedPlayerObject and selectedPlayerObject.Character then
        local old = selectedPlayerObject.Character:FindFirstChild("ESP")
        if state and not old then
            local esp = Instance.new("Highlight", selectedPlayerObject.Character)
            esp.Name = "ESP"
            esp.FillColor = Color3.fromRGB(255, 0, 0)
            esp.FillTransparency = 0.5
            esp.OutlineColor = Color3.fromRGB(255, 255, 255)
        elseif not state and old then
            old:Destroy()
        end
    end
end)

-- زر RESET (ريست الشخصية)
PD:addButton("RESET | ريسيت", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health = 0
    end
end)


-- 🛡️ الحماية
local SK = UI:addPage(" الحمايه | Protection 🛡️", 3, true, 6)
local anti = {
    fling = false, afk = false, sit = false, delete = false,
    anchor = false, jump = false, speed = false, velocity = false,
}
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end

    if anti.fling or anti.velocity then
        for _, obj in pairs(char:GetDescendants()) do
            if obj:IsA("BodyVelocity") or obj:IsA("BodyAngularVelocity") then obj:Destroy() end
        end
    end
    if anti.anchor then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Anchored then part.Anchored = false end
        end
    end
    if anti.jump then
        local h = char:FindFirstChildWhichIsA("Humanoid")
        if h and h.JumpPower > 50 then h.JumpPower = 50 end
    end
    if anti.speed then
        local h = char:FindFirstChildWhichIsA("Humanoid")
        if h and h.WalkSpeed > 16 then h.WalkSpeed = 16 end
    end
end)

SK:addToggle("🌀 مضاد Fling", function(v) anti.fling = v end)
SK:addToggle("💤 مضاد AFK", function(v)
    anti.afk = v
    if v then
        LocalPlayer.Idled:Connect(function()
            VirtualUser:Button2Down(Vector2.new())
            wait(1)
            VirtualUser:Button2Up(Vector2.new())
        end)
    end
end)
SK:addToggle("🪑 مضاد Sit", function(v) anti.sit = v end)
SK:addToggle("🧱 مضاد Anchor", function(v) anti.anchor = v end)
SK:addToggle("🦘 مضاد JumpPower", function(v) anti.jump = v end)
SK:addToggle("🏃‍♂️ مضاد Speed", function(v) anti.speed = v end)
SK:addToggle("🌪️ مضاد Velocity", function(v) anti.velocity = v end)

-- 🙌 الكريدت
local LND = UI:addPage("Credits | الحقوق 👾", 6, true, 5)
LND:addLabel("مطور السكربت", "Majed627")
LND:addButton("نسخ رابط سيرفر الدسكورد تحصل كل شي هناك", function()
    setclipboard("https://discord.gg/aDexK56tau")
    StarterGui:SetCore("SendNotification", {Title = "تم النسخ", Text = "✅"})
end)
LND:addButton("نسخ يوزر المطرر", function()
    setclipboard("Majed627")
    StarterGui:SetCore("SendNotification", {Title = "تم النسخ", Text = "✅"})
end)

