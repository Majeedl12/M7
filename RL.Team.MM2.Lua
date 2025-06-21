-- إشعار تنفيذ السكربت
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Script Executed",
    Text = "تم تفعيل قائمة MM2",
    Duration = 6,
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- مكتبة RedLine UI
local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/aaaa"))()
local UI = GUI:CreateWindow("RL Team | MM2", "RedLine")

-- 🌐 صفحة MM2
local MM2 = UI:addPage("Home | الصفحه الرئيسيه ", 2, true, 6)

-- دالة إشعار
local function Message(title, text, duration)
    StarterGui:SetCore("SendNotification", { Title = title, Text = text, Duration = duration })
end

-- دالة للعثور على اللاعب حسب سلاحه
local function findRolePlayer(role)
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and (p.Backpack:FindFirstChild(role) or (p.Character and p.Character:FindFirstChild(role))) then
            return p
        end
    end
    return nil
end

-- كشف القاتل (أحمر)
MM2:addToggle("ESP Murder | كشف القاتل", function(state)
    local p = findRolePlayer("Knife")
    if p and p.Character then
        local hl = p.Character:FindFirstChild("ESP") or Instance.new("Highlight", p.Character)
        hl.Name = "ESP"
        hl.FillColor = Color3.fromRGB(255, 0, 0)
        hl.OutlineColor = Color3.fromRGB(0, 0, 0)
        hl.FillTransparency = 0.4
        hl.OutlineTransparency = 0
        hl.Enabled = state
        if not state then
            hl:Destroy()
        end
    else
        if not state then return end
        Message("❌ خطأ", "لم يتم العثور على القاتل", 3)
    end
end)

-- كشف الشرف (أزرق)
MM2:addToggle("ESP Sheriff | كشف الشرف", function(state)
    local p = findRolePlayer("Gun")
    if p and p.Character then
        local hl = p.Character:FindFirstChild("ESP") or Instance.new("Highlight", p.Character)
        hl.Name = "ESP"
        hl.FillColor = Color3.fromRGB(0, 100, 255)
        hl.OutlineColor = Color3.fromRGB(0, 0, 0)
        hl.FillTransparency = 0.4
        hl.OutlineTransparency = 0
        hl.Enabled = state
        if not state then
            hl:Destroy()
        end
    else
        if not state then return end
        Message("❌ خطأ", "لم يتم العثور على الشرف", 3)
    end
end)

-- طير القاتل
local killerFlingConn
MM2:addToggle("Fling Murder | طير القاتل", function(state)
    if killerFlingConn then
        killerFlingConn:Disconnect()
        killerFlingConn = nil
    end
    if state then
        local killer = findRolePlayer("Knife")
        if killer and killer.Character and killer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            killerFlingConn = RunService.Heartbeat:Connect(function()
                local localHRP = LocalPlayer.Character.HumanoidRootPart
                local killerHRP = killer.Character.HumanoidRootPart
                localHRP.CFrame = killerHRP.CFrame
                localHRP.Velocity = Vector3.new(1e5, 1e5, 1e5)
            end)
        else
            Message("❌ خطأ", "ما تم العثور على قاتل", 3)
        end
    end
end)

-- طير الشرف
local sheriffFlingConn
MM2:addToggle("Fling Sheriff | طير الشرف", function(state)
    if sheriffFlingConn then
        sheriffFlingConn:Disconnect()
        sheriffFlingConn = nil
    end
    if state then
        local sheriff = findRolePlayer("Gun")
        if sheriff and sheriff.Character and sheriff.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            sheriffFlingConn = RunService.Heartbeat:Connect(function()
                local localHRP = LocalPlayer.Character.HumanoidRootPart
                local sheriffHRP = sheriff.Character.HumanoidRootPart
                localHRP.CFrame = sheriffHRP.CFrame
                localHRP.Velocity = Vector3.new(1e5, 1e5, 1e5)
            end)
        else
            Message("❌ خطأ", "ما تم العثور على شرف", 3)
        end
    end
end)

local autoGrabGun = false
local autoGrabConn

MM2:addToggle("Auto Grab Gun | أوتو أخذ المسدس", function(state)
    autoGrabGun = state

    if autoGrabConn then
        autoGrabConn:Disconnect()
        autoGrabConn = nil
    end

    if state then
        autoGrabConn = RunService.Heartbeat:Connect(function()
            local gunDrop = workspace:FindFirstChild("GunDrop")
            local character = LocalPlayer.Character
            local hrp = character and character:FindFirstChild("HumanoidRootPart")

            if gunDrop and hrp then
                local originalPos = hrp.CFrame
                local killer = findRolePlayer("Knife")
                local killerHRP = killer and killer.Character and killer.Character:FindFirstChild("HumanoidRootPart")

                if killerHRP then
                    local distance = (killerHRP.Position - gunDrop.Position).Magnitude

                    if distance < 4 then
                        Message("⚠️ القاتل مكمبر بالسلاح", "انتظر حتى يروح", 3)
                        return
                    elseif distance < 15 then
                        hrp.CFrame = gunDrop.CFrame
                        task.wait(0.1)
                        hrp.CFrame = originalPos
                        return
                    end
                end

                hrp.CFrame = gunDrop.CFrame
            end
        end)
    end
end)

-- زر طير الجميع (بكودك الأصلي)
MM2:addButton("Fling All | طير الجميع", function()
    StarterGui:SetCore("SendNotification", {
        Title = "Script Executed",
        Text = "Fling All",
        Duration = 6,
    })

    local Targets = {"All"}
    local Player = Players.LocalPlayer
    local AllBool = false

    local function GetPlayer(Name)
        Name = Name:lower()
        if Name == "all" then
            AllBool = true
            return
        end
    end

    local function SkidFling(TargetPlayer)
        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local TCharacter = TargetPlayer.Character
        local THumanoid = TCharacter and TCharacter:FindFirstChildOfClass("Humanoid")
        local TRootPart = TCharacter and TCharacter:FindFirstChild("HumanoidRootPart")

        if Character and RootPart and TRootPart and Humanoid then
            getgenv().OldPos = RootPart.CFrame

            local function FPos(BasePart, Pos, Ang)
                RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
            end

            local function SFBasePart(BasePart)
                local Time = tick()
                local Angle = 0
                repeat
                    Angle += 100
                    FPos(BasePart, CFrame.new(0, 1.5, 0), CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                until tick() > Time + 2
            end

            local BV = Instance.new("BodyVelocity")
            BV.Name = "EpixVel"
            BV.Parent = RootPart
            BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
            BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

            if TRootPart then
                SFBasePart(TRootPart)
            end

            BV:Destroy()
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)

            repeat
                RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                task.wait()
            until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        end
    end

    for _, x in next, Targets do GetPlayer(x) end
    if AllBool then
        for _, x in next, Players:GetPlayers() do
            if x ~= Player then
                SkidFling(x)
            end
        end
    end
end)

-- صفحة التنقل Teleport
local TeleportPage = UI:addPage("الاماكن | Teleport", 2, true, 6)

TeleportPage:addButton("تنقل الى القاتل | TP Murder", function()
    local killer = findRolePlayer("Knife")
    if killer and killer.Character and killer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = killer.Character.HumanoidRootPart.CFrame
    else
        Message("خطأ", "لم يتم العثور على القاتل", 3)
    end
end)

TeleportPage:addButton("تنقل الى الشرف | TP Sheriff", function()
    local sheriff = findRolePlayer("Gun")
    if sheriff and sheriff.Character and sheriff.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = sheriff.Character.HumanoidRootPart.CFrame
    else
        Message("خطأ", "لم يتم العثور على الشرف", 3)
    end
end)

-- 🎯 صفحة المستهدف
local PD = UI:addPage("TargetInfo | المستهدف", 3, true, 6)
local selectedPlayerObject = nil
local flingConnection = nil

PD:addTextBox("اختيار اللاعب | Select Player", "اكتب اول حرف من اسمه", function(input)
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():sub(1, #input) == input:lower() then
            selectedPlayerObject = p
            StarterGui:SetCore("SendNotification", {
                Title = "تم تحديد اللاعب",
                Text = p.Name,
                Duration = 3,
            })
            -- ربط إشعار خروج اللاعب
            p.AncestryChanged:Connect(function()
                if not p:IsDescendantOf(game) then
                    StarterGui:SetCore("SendNotification", {
                        Title = "🚫 اللاعب خرج",
                        Text = p.Name .. " غادر السيرفر",
                        Duration = 4,
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
    if selectedPlayerObject and selectedPlayerObject.Character and selectedPlayerObject.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = selectedPlayerObject.Character.HumanoidRootPart.CFrame + Vector3.new(2, 0, 2)
    else
        Message("خطأ", "لم يتم تحديد المستهدف أو لا يملك جسم", 3)
    end
end)

PD:addToggle("طير المستهدف | Fling Target", function(state)
    if flingConnection then
        flingConnection:Disconnect()
        flingConnection = nil
    end
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
        if tick() - lastSwitch >= 0.05 then
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
end

local function StartGetBanged()
    if not selectedPlayerObject or not selectedPlayerObject.Character then return end
    local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local targetHRP = selectedPlayerObject.Character:FindFirstChild("HumanoidRootPart")
    if not myHRP or not targetHRP then return end
    GetBangedActive = true
    local forward, lastSwitch = true, tick()
    GetBangedConnection = RunService.Heartbeat:Connect(function()
        if not GetBangedActive then return end
        if tick() - lastSwitch >= 0.05 then
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

PD:addToggle("يغتصب اللاعب | Bang", function(state)
    if selectedPlayerObject then
        if state then
            StartBang()
        else
            StopBang()
        end
    end
end)

PD:addToggle("يغتصبك | GetBanged", function(state)
    if selectedPlayerObject then
        if state then
            StartGetBanged()
        else
            StopGetBanged()
        end
    end
end)

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
        elseif not state and old then
            old:Destroy()
        end
    end
end)

-- كشف الكل (ESP) مع الألوان والتنسيق حسب طلبك
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
            tag.Adornee = head
            tag.Size = UDim2.new(0, 100, 0, 30)
            tag.StudsOffset = Vector3.new(0, 2.5, 0)
            tag.AlwaysOnTop = true

            local label = Instance.new("TextLabel", tag)
            label.Name = "Label"
            label.Text = player.Name
            label.TextColor3 = Color3.fromRGB(255, 0, 0) -- أحمر
            label.BackgroundTransparency = 1
            label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            label.TextStrokeTransparency = 0
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Font = Enum.Font.SourceSansBold
            label.TextScaled = true
        end
    end
end

local function RemoveESPFromPlayer(player)
    if player.Character then
        local hl = player.Character:FindFirstChild("ESP_HL")
        if hl then
            hl:Destroy()
            allESPList[player] = nil
        end

        local head = player.Character:FindFirstChild("Head")
        if head then
            local tag = head:FindFirstChild("ESP_Name")
            if tag then
                tag:Destroy()
            end
        end
    end
end

local function UpdateAllESP(state)
    allESPActive = state
    if state then
        for _, p in pairs(Players:GetPlayers()) do
            AddESPToPlayer(p)
        end
    else
        for _, p in pairs(Players:GetPlayers()) do
            RemoveESPFromPlayer(p)
        end
    end
end

local ESPToggle = UI:addPage("ESP All | كشف الكل", 5, true, 6)
ESPToggle:addToggle("Toggle ESP الكل", function(state)
    UpdateAllESP(state)
end)

Players.PlayerRemoving:Connect(function(p)
    RemoveESPFromPlayer(p)
end)

-- صفحة الحماية مع إضافة Anti Camper و Anti Kick

local Protection = UI:addPage("Protection | الحماية", 4, true, 6)

local antiCamperEnabled = false
local camperCheckConnection

function startAntiCamper()
    local stuckTime = 0
    local threshold = 2 -- ثانيتين

    camperCheckConnection = RunService.Heartbeat:Connect(function(dt)
        if not antiCamperEnabled or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
        local hrp = LocalPlayer.Character.HumanoidRootPart

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if dist < 5 then -- ملتصق
                    stuckTime = stuckTime + dt
                    if stuckTime >= threshold then
                        hrp.CFrame = CFrame.new(0, 10, 0) -- مكان آمن
                        stuckTime = 0
                        Message("Anti Camper", "تم كشف التكمبر، تم نقلك لمكان آمن", 4)
                    end
                    return
                end
            end
        end

        stuckTime = 0
    end)
end

function stopAntiCamper()
    if camperCheckConnection then
        camperCheckConnection:Disconnect()
        camperCheckConnection = nil
    end
end

local antiKickEnabled = false
local humanoidDiedConnection

function startAntiKick()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    humanoidDiedConnection = humanoid.Died:Connect(function()
        if antiKickEnabled then
            task.spawn(function()
                task.wait(1)
                if LocalPlayer.Character then
                    LocalPlayer.Character:BreakJoints()
                end
            end)
            Message("Anti Kick", "تم منع طردك، حاول تحمي نفسك", 4)
        end
    end)
end

function stopAntiKick()
    if humanoidDiedConnection then
        humanoidDiedConnection:Disconnect()
        humanoidDiedConnection = nil
    end
end

Protection:addToggle("Anti Camber | منع التكمبر", function(state)
    antiCamperEnabled = state
    if state then
        startAntiCamper()
    else
        stopAntiCamper()
    end
end)

Protection:addToggle("Anti Kick | منع الطرد", function(state)
    antiKickEnabled = state
    if state then
        startAntiKick()
    else
        stopAntiKick()
    end
end)


local LND = UI:addPage("Credits | الحقوق ", 6, true, 5)
LND:addLabel("مطور السكربت | Developer Script ", "Majed627")
LND:addButton("نسخ رابط سيرفر الدسكورد | Discord Link Copy ", function()
    setclipboard("https://discord.gg/aDexK56tau")
    StarterGui:SetCore("SendNotification", {Title = "تم النسخ", Text = "✅"})
end)
LND:addButton("نسخ يوزر المطور دسكورد | Credits", function()
    setclipboard("Majed627")
    StarterGui:SetCore("SendNotification", {Title = "تم النسخ", Text = "✅"})
end)

LND:addButton("Rejoin | إعادة دخول السيرفر", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)
