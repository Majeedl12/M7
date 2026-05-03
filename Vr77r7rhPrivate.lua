-- Saw Script - Transform to fly brainrot

if _G.MajedHubLoaded then
    if _G.MajedMainUI then _G.MajedMainUI:Destroy() end
end
_G.MajedHubLoaded = true

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleBtn = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local LeftScroll = Instance.new("ScrollingFrame")
local RightScroll = Instance.new("ScrollingFrame")
local UIListLayoutLeft = Instance.new("UIListLayout")
local UIListLayoutRight = Instance.new("UIListLayout")
local VerticalLine = Instance.new("Frame")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "Majed_Ultimate_Hub"
_G.MajedMainUI = ScreenGui

-- [ زر SAW ]
ToggleBtn.Name = "SAW_Toggle"
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -30)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Text = "SAW"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 18
ToggleBtn.Draggable = true

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(1, 0)
BtnCorner.Parent = ToggleBtn

local OuterStroke = Instance.new("UIStroke")
OuterStroke.Color = Color3.fromRGB(255, 50, 50)
OuterStroke.Thickness = 1
OuterStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
OuterStroke.Parent = ToggleBtn

-- [ الواجهة الرئيسية ]
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -250, 0.4, -150)
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

Title.Parent = MainFrame
Title.Text = "Saw Script - Transform to fly brainrot"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- [ القسم الأيسر ]
LeftScroll.Parent = MainFrame
LeftScroll.Position = UDim2.new(0, 10, 0, 60)
LeftScroll.Size = UDim2.new(0, 230, 1, -70)
LeftScroll.BackgroundTransparency = 1
LeftScroll.CanvasSize = UDim2.new(0, 0, 2.2, 0)
LeftScroll.ScrollBarThickness = 0
UIListLayoutLeft.Parent = LeftScroll
UIListLayoutLeft.Padding = UDim.new(0, 5)
UIListLayoutLeft.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayoutLeft.SortOrder = Enum.SortOrder.LayoutOrder

local function NewLabel(parent, txt, order)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = parent
    lbl.Text = txt
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.LayoutOrder = order
    return lbl
end

local function NewBtn(parent, txt, color, order, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(0, 200, 0, 35)
    btn.BackgroundColor3 = color or Color3.fromRGB(40, 40, 40)
    btn.Text = txt
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.LayoutOrder = order
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

NewLabel(LeftScroll, "--- قسم التنقل ---", 1)
NewBtn(LeftScroll, "Teleport to Base", nil, 2, function()
    local player = game.Players.LocalPlayer
    local bases = workspace.Bases
    if bases then
        for _, plot in pairs(bases:GetChildren()) do
            if plot:FindFirstChild("Owner") and plot.Owner.Value == player.Name or plot.Name:find(player.Name) then
                local targetPos = plot.PrimaryPart and plot.PrimaryPart.Position or plot:FindFirstChildOfClass("Part").Position
                player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos.X, targetPos.Y + 5, targetPos.Z)
                return
            end
        end
    end
end)

local locs = {
    {"Teleport to Common", CFrame.new(-195.64, 69.49, -384.13)},
    {"Teleport to Uncommon", CFrame.new(-203.89, 510.72, -1808.24)},
    {"Teleport to Rare", CFrame.new(-194.57, 1291.26, -3391.54)},
    {"Teleport to Epic", CFrame.new(-189.21, 2463.57, -5367.44)},
    {"Teleport to Legendary", CFrame.new(-199.22, 5298.15, -8396.62)},
    {"Teleport to Mythical", CFrame.new(-192.17, 6646.61, -12245.18)},
    {"Teleport to Secret", CFrame.new(-194.73, 8433.09, -14828.91)},
    {"Teleport to Celestial", CFrame.new(-191.30, 11682.20, -19459.30)},
    {"Teleport to Evolution", CFrame.new(-151.48, 12940.38, -40552.42)}
}
for i, l in ipairs(locs) do NewBtn(LeftScroll, l[1], nil, i + 2, function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = l[2] end) end

VerticalLine.Parent = MainFrame
VerticalLine.Position = UDim2.new(0.5, 0, 0, 60)
VerticalLine.Size = UDim2.new(0, 2, 1, -80)
VerticalLine.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
VerticalLine.BorderSizePixel = 0

-- [ القسم الأيمن ]
RightScroll.Parent = MainFrame
RightScroll.Position = UDim2.new(0.5, 10, 0, 60)
RightScroll.Size = UDim2.new(0, 230, 1, -70)
RightScroll.BackgroundTransparency = 1
RightScroll.CanvasSize = UDim2.new(0, 0, 4.2, 0)
RightScroll.ScrollBarThickness = 0
UIListLayoutRight.Parent = RightScroll
UIListLayoutRight.Padding = UDim.new(0, 8)
UIListLayoutRight.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayoutRight.SortOrder = Enum.SortOrder.LayoutOrder

NewLabel(RightScroll, "--- شراء السرعة ---", 1)
local SpeedBox = Instance.new("TextBox")
SpeedBox.Parent = RightScroll
SpeedBox.Text = ""
SpeedBox.PlaceholderText = "اكتب الكمية (حدك 10)"
SpeedBox.Size = UDim2.new(0, 200, 0, 35)
SpeedBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.Font = Enum.Font.GothamBold
SpeedBox.TextSize = 13
SpeedBox.LayoutOrder = 2
Instance.new("UICorner", SpeedBox).CornerRadius = UDim.new(0, 6)

NewBtn(RightScroll, "شراء السرعة", Color3.fromRGB(0, 150, 0), 3, function()
    local val = tonumber(SpeedBox.Text)
    if val and val <= 10 then game:GetService("ReplicatedStorage").Remotes.PurchaseSpeed:FireServer(val) end
end)

-- ========== قسم التجميع ==========
NewLabel(RightScroll, "--- قسم التجميع ---", 4)

local originalDurations = {}

local function NewToggle(parent, name, order, onToggle)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = UDim2.new(0, 200, 0, 35)
    frame.BackgroundTransparency = 1
    frame.LayoutOrder = order

    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.Size = UDim2.new(0, 160, 1, 0)
    btn.Position = UDim2.new(0, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = name .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local indicator = Instance.new("Frame")
    indicator.Parent = frame
    indicator.Size = UDim2.new(0, 24, 0, 24)
    indicator.Position = UDim2.new(1, -28, 0.5, -12)
    indicator.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)

    local enabled = false

    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            btn.Text = name .. " [ON]"
            btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            indicator.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            btn.Text = name .. " [OFF]"
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            indicator.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
        onToggle(enabled)
    end)
end

-- Instant Collect
local instantConnection = nil
NewToggle(RightScroll, "Instant collect", 5, function(on)
    if on then
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                originalDurations[v] = v.HoldDuration
                v.HoldDuration = 0
            end
        end
        instantConnection = workspace.DescendantAdded:Connect(function(v)
            if v:IsA("ProximityPrompt") then
                originalDurations[v] = v.HoldDuration
                v.HoldDuration = 0
            end
        end)
    else
        if instantConnection then
            instantConnection:Disconnect()
            instantConnection = nil
        end
        for prompt, origDuration in pairs(originalDurations) do
            if prompt and prompt.Parent then
                prompt.HoldDuration = origDuration
            end
        end
        originalDurations = {}
    end
end)

local descInstant = Instance.new("TextLabel")
descInstant.Parent = RightScroll
descInstant.Text = "اذا فعلته تاخذ البراينروت بضغطه واحده فقط بدال لاتضغط ضغطه مطوله"
descInstant.Size = UDim2.new(0, 200, 0, 30)
descInstant.BackgroundTransparency = 1
descInstant.TextColor3 = Color3.fromRGB(180, 180, 180)
descInstant.Font = Enum.Font.Gotham
descInstant.TextSize = 11
descInstant.LayoutOrder = 6
descInstant.TextWrapped = true

-- زر بيع كل شيء (Sell All brainrots)
NewBtn(RightScroll, "Sell All brainrots", Color3.fromRGB(255, 100, 0), 7, function()
    local args = {
        [1] = "Inventory"
    }
    game:GetService("ReplicatedStorage").Remotes.RequestSell:FireServer(unpack(args))
end)
local descSell = Instance.new("TextLabel")
descSell.Parent = RightScroll
descSell.Text = "يبيع كل البرينروتس اللي في المخزن مرة وحدة"
descSell.Size = UDim2.new(0, 200, 0, 30)
descSell.BackgroundTransparency = 1
descSell.TextColor3 = Color3.fromRGB(180, 180, 180)
descSell.Font = Enum.Font.Gotham
descSell.TextSize = 11
descSell.LayoutOrder = 8 -- خليه بعد الزر
descSell.TextWrapped = true
