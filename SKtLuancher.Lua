
-- 🧩 بدء RL Team GUI
setclipboard("https://discord.gg/aDexK56tau")
game.StarterGui:SetCore("SendNotification", {
    Title = "تم نسخ رابط سيرفر المطورين",
    Text = "✅"
})

local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/aaaa"))()
local UI = GUI:CreateWindow("RL Team HUB | 1.2v ", "RedLine")

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

-- 🎯 صفحة المستهدف
local PD = UI:addPage(" TargetInfo | المستهدف", 2, true, 6)
local selectedPlayerObject = nil
local flingConnection = nil

PD:addTextBox("اختيار اللاعب | Select Player", "اكتب اول حرف من اسمه", function(input)
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #input) == input:lower() then
            selectedPlayerObject = p
            StarterGui:SetCore("SendNotification", {
                Title = "تم تحديد اللاعب",
                Text = p.Name,
                Duration = 3
            })
            p.AncestryChanged:Connect(function()
                if not p:IsDescendantOf(game) then
                    StarterGui:SetCore("SendNotification", {
                        Title = "🚫 اللاعب خرج",
                        Text = p.Name .. " غادر السيرفر",
                        Duration = 4
                    })
                    selectedPlayerObject = nil
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

PD:addButton("تنقل للمستهدف | TP To Target", function()
    if selectedPlayerObject and selectedPlayerObject.Character then
        local p = selectedPlayerObject.Character:FindFirstChild("HumanoidRootPart")
        if p then LocalPlayer.Character:MoveTo(p.Position + Vector3.new(2,0,2)) end
    end
end)

PD:addToggle("طير المستهدف | Fling Target", function(state)
    if flingConnection then flingConnection:Disconnect() flingConnection = nil end
    if not selectedPlayerObject or not selectedPlayerObject.Character then return end
    local targetHRP = selectedPlayerObject.Character:FindFirstChild("HumanoidRootPart")
    local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetHRP or not myHRP then return end
    if state then
        flingConnection = RunService.Heartbeat:Connect(function()
            myHRP.CFrame = targetHRP.CFrame
            myHRP.Velocity = Vector3.new(1e5, 1e5, 1e5)
        end)
    end
end)

-- Bang/GetBanged
local BangActive, GetBangedActive = false, false
local BangConnection, GetBangedConnection = nil, nil

local function StartBang()
    if not selectedPlayerObject or not selectedPlayerObject.Character then return end
    local targetHRP = selectedPlayerObject.Character:FindFirstChild("HumanoidRootPart")
    local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local myHumanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if not targetHRP or not myHRP or not myHumanoid then return end
    BangActive = true
    local forward, lastSwitch = true, tick()
    BangConnection = RunService.Heartbeat:Connect(function()
        if not BangActive then return end
        myHumanoid.Sit = true
        if tick() - lastSwitch >= 0.05 then forward = not forward lastSwitch = tick() end
        local offset = forward and CFrame.new(0, 0, 1.2) or CFrame.new(0, 0, 2)
        myHRP.CFrame = targetHRP.CFrame * offset
    end)
end
local function StopBang() BangActive = false if BangConnection then BangConnection:Disconnect() BangConnection = nil end end

local function StartGetBanged()
    if not selectedPlayerObject or not selectedPlayerObject.Character then return end
    local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local targetHRP = selectedPlayerObject.Character:FindFirstChild("HumanoidRootPart")
    if not myHRP or not targetHRP then return end
    GetBangedActive = true
    local forward, lastSwitch = true, tick()
    GetBangedConnection = RunService.Heartbeat:Connect(function()
        if not GetBangedActive then return end
        if tick() - lastSwitch >= 0.05 then forward = not forward lastSwitch = tick() end
        local offset = forward and CFrame.new(0, 0, -1.5) or CFrame.new(0, 0, -2.2)
        myHRP.CFrame = targetHRP.CFrame * offset
    end)
end
local function StopGetBanged() GetBangedActive = false if GetBangedConnection then GetBangedConnection:Disconnect() GetBangedConnection = nil end end

PD:addToggle("يغتصب اللاعب | Bang", function(state) if selectedPlayerObject then if state then StartBang() else StopBang() end end end)
PD:addToggle("يغتصبك | GetBanged", function(state) if selectedPlayerObject then if state then StartGetBanged() else StopGetBanged() end end end)
PD:addToggle("مشاهده المستهدف | View", function(state)
    if selectedPlayerObject and selectedPlayerObject.Character then
        Camera.CameraSubject = state and selectedPlayerObject.Character:FindFirstChild("Humanoid") or LocalPlayer.Character:FindFirstChild("Humanoid")
    end
end)
PD:addToggle("كشف المستهدف | ESP", function(state)
    if selectedPlayerObject and selectedPlayerObject.Character then
        local old = selectedPlayerObject.Character:FindFirstChild("ESP")
        if state and not old then
            local esp = Instance.new("Highlight", selectedPlayerObject.Character)
            esp.Name = "ESP"
            esp.FillColor = Color3.fromRGB(255, 0, 0)
            esp.FillTransparency = 0.5
            esp.OutlineColor = Color3.fromRGB(255, 255, 255)
        elseif not state and old then old:Destroy() end
    end
end)

-- كشف الكل (ESP) مع الألوان والتنسيق حسب الطلب
local allESPActive = false
local allESPList = {}

local function AddESPToPlayer(player)
    if player == LocalPlayer or not player.Character then return end

    -- Highlight
    if not player.Character:FindFirstChild("ESP_HL") then
        local hl = Instance.new("Highlight")
        hl.Name = "ESP_HL"
        hl.FillColor = Color3.fromRGB(255, 255, 255) -- أبيض
        hl.OutlineColor = Color3.fromRGB(0, 0, 0) -- أسود
        hl.FillTransparency = 0.3
        hl.OutlineTransparency = 0
        hl.Parent = player.Character
        allESPList[player] = hl
    end

    -- اسم اللاعب فوق الرأس
    if not player.Character:FindFirstChild("ESP_Name") then
        local head = player.Character:FindFirstChild("Head")
        if head then
            local tag = Instance.new("BillboardGui", head)
            tag.Name = "ESP_Name"
            tag.Size = UDim2.new(0, 100, 0, 20)
            tag.StudsOffset = Vector3.new(0, 2.5, 0)
            tag.AlwaysOnTop = true

            local nameLabel = Instance.new("TextLabel", tag)
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- خلفية سوداء
            nameLabel.BackgroundTransparency = 0.4
            nameLabel.BorderSizePixel = 0
            nameLabel.Text = player.Name
            nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- أحمر
            nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) -- حدود سوداء
            nameLabel.TextStrokeTransparency = 0
            nameLabel.TextScaled = true
            nameLabel.Font = Enum.Font.SourceSansBold
        end
    end
end

local function RemoveESPFromPlayer(player)
    if player.Character then
        for _, obj in pairs(player.Character:GetDescendants()) do
            if obj:IsA("Highlight") and obj.Name == "ESP_HL" then
                obj:Destroy()
            elseif obj:IsA("BillboardGui") and obj.Name == "ESP_Name" then
                obj:Destroy()
            end
        end
    end
    allESPList[player] = nil
end

PD:addToggle("كشف الكل | ESP ALL", function(state)
    allESPActive = state
    if state then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then AddESPToPlayer(p) end
        end

        -- تحديث مستقبلي
        Players.PlayerAdded:Connect(function(p)
            p.CharacterAdded:Connect(function()
                wait(1)
                if allESPActive then AddESPToPlayer(p) end
            end)
        end)

        for _, p in ipairs(Players:GetPlayers()) do
            p.CharacterAdded:Connect(function()
                wait(1)
                if allESPActive then AddESPToPlayer(p) end
            end)
        end
    else
        for _, p in pairs(Players:GetPlayers()) do
            RemoveESPFromPlayer(p)
        end
    end
end)

PD:addButton("RESET | ريسيت", function()
    if LocalPlayer.Character then
        local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h.Health = 0 end
    end
end)

-- 🛡️ صفحة الحماية-- صفحة الحماية | Protection (معدلة حسب طلبك فقط بدون رموز)
local SK = UI:addPage("الحمايه | Protection", 2, true, 6)

local protection = {
    Bang = false,
    Fling = false,
    AFK = false,
    Sit = false,
    BangV2 = false,
}

local function Notify(txt)
    StarterGui:SetCore("SendNotification", {
        Title = "مضاد الحماية",
        Text = txt,
        Duration = 3
    })
end

-- Bang V1 مضاد اغتصاب
RunService.Heartbeat:Connect(function()
    if protection.Bang then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.Sit then
            hum.Sit = false
        end
    end
end)

-- Fling مضاد فلنق
RunService.Heartbeat:Connect(function()
    if protection.Fling then
        local char = LocalPlayer.Character
        if char then
            for _, obj in pairs(char:GetDescendants()) do
                if obj:IsA("BodyVelocity") or obj:IsA("BodyAngularVelocity") then
                    obj:Destroy()
                end
            end
        end
    end
end)

-- AFK مضاد افك
LocalPlayer.Idled:Connect(function()
    if protection.AFK then
        VirtualUser:Button2Down(Vector2.new(0,0))
        wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0))
    end
end)

-- Sit مضاد جلوس
RunService.Heartbeat:Connect(function()
    if protection.Sit then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.Sit then
            hum.Sit = false
        end
    end
end)

-- التوقلات

SK:addToggle("مضاد اغتصاب | Bang", function(v)
    protection.Bang = v
    Notify(v and "تم تفعيل مضاد الاغتصاب" or "تم إيقاف مضاد الاغتصاب")
end)

SK:addToggle("مضاد فلنق | Fling", function(v)
    protection.Fling = v
    Notify(v and "تم تفعيل مضاد الفلنق" or "تم إيقاف مضاد الفلنق")
end)

SK:addToggle("مضاد افك | AFK", function(v)
    protection.AFK = v
    Notify(v and "تم تفعيل مضاد AFK" or "تم إيقاف مضاد AFK")
end)

SK:addToggle("مضاد جلوس | Sit", function(v)
    protection.Sit = v
    Notify(v and "تم تفعيل مضاد الجلوس" or "تم إيقاف مضاد الجلوس")
end)

-- 👾 صفحة الكريدت
local LND = UI:addPage("Credits | الحقوق ", 6, true, 3)
LND:addLabel("مطور السكربت | Developer Script ", "isxwp")
LND:addButton("نسخ رابط سيرفر الدسكورد | Discord Link Copy ", function()
    setclipboard("https://discord.gg/cJUqwf2SFs")
    StarterGui:SetCore("SendNotification", {Title = "تم النسخ", Text = "✅"})
end)
LND:addButton("نسخ يوزر المطور دسكورد | Credits", function()
    setclipboard("isxwp")
    StarterGui:SetCore("SendNotification", {Title = "تم النسخ", Text = "✅"})
end)

LND:addButton("Rejoin | إعادة دخول السيرفر", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

