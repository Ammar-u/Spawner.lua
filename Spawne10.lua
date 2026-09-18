--[[
    ==================================================
              FRUIT SPAWNER SYSTEM v16.0 (REDZ METHOD)
    ==================================================
    * Logic: ReplicatedStorage Cache Deep Asset Injection
    * Theme: Ultra Minimal High-Contrast White & Black
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

if player:WaitForChild("PlayerGui"):FindFirstChild("FruitSpawnerPanelGui") then
    player.PlayerGui.FruitSpawnerPanelGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "FruitSpawnerPanelGui"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN BLACK PANEL CONTAINER
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 240)
frame.Position = UDim2.new(0.5, -190, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
frame.BackgroundTransparency = 0.08
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 14)
frameCorner.Parent = frame

local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(255, 255, 255)
frameStroke.Thickness = 2
frameStroke.Transparency = 0.1
frameStroke.Parent = frame

local title = Instance.new("TextLabel")
title.Text = "Fruit Spawner"
title.Size = UDim2.new(1, 0, 0, 45)
title.Position = UDim2.new(0, 0, 0, 8)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SciFi
title.TextSize = 25
title.ZIndex = 5
title.Parent = frame

-- BACKGROUND WHITE SPARK LINES
task.spawn(function()
    while task.wait(0.2) do
        if not frame or not frame.Parent then break end
        local sparkLine = Instance.new("Frame")
        sparkLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        sparkLine.BorderSizePixel = 0
        sparkLine.Size = UDim2.new(0, math.random(1, 3), 0, math.random(30, 90))
        sparkLine.Position = UDim2.new(math.random(5, 95)/100, 0, math.random(0, 70)/100, 0)
        sparkLine.BackgroundTransparency = 0.3
        sparkLine.ZIndex = 2
        sparkLine.Parent = frame
        TweenService:Create(sparkLine, TweenInfo.new(0.2), {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 4, 0, 0)
        }):Play()
        game:GetService("Debris"):AddItem(sparkLine, 0.25)
    end
end)

-- GLOBAL ALERT POPUP
local function triggerPopup(status, mainText, descText)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 310, 0, 85)
    notif.Position = UDim2.new(1, 20, 0, 20)
    notif.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    notif.Parent = gui
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 10)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = (status == "Success") and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 50, 50)
    stroke.Thickness = 1.5
    stroke.Parent = notif

    local icon = Instance.new("TextLabel")
    icon.Text = (status == "Success") and "⚡" or "❌"
    icon.Size = UDim2.new(0, 35, 0, 35)
    icon.Position = UDim2.new(0, 12, 0.5, -17)
    icon.BackgroundTransparency = 1
    icon.TextColor3 = stroke.Color
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = 22
    icon.Parent = notif

    local t1 = Instance.new("TextLabel")
    t1.Text = mainText
    t1.Size = UDim2.new(1, -65, 0, 20)
    t1.Position = UDim2.new(0, 52, 0, 10)
    t1.BackgroundTransparency = 1
    t1.TextColor3 = stroke.Color
    t1.Font = Enum.Font.GothamBold
    t1.TextSize = 14
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.Parent = notif

    local t2 = Instance.new("TextLabel")
    t2.Text = descText
    t2.Size = UDim2.new(1, -65, 0, 45)
    t2.Position = UDim2.new(0, 52, 0, 30)
    t2.BackgroundTransparency = 1
    t2.TextColor3 = Color3.fromRGB(170, 170, 170)
    t2.Font = Enum.Font.Gotham
    t2.TextSize = 10
    t2.TextWrapped = true
    t2.TextXAlignment = Enum.TextXAlignment.Left
    t2.TextYAlignment = Enum.TextYAlignment.Top
    t2.Parent = notif

    TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(1, -330, 0, 20)}):Play()
    task.delay(4, function()
        if notif and notif.Parent then
            TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(1, 20, 0, 20)}):Play()
            task.wait(0.3)
            notif:Destroy()
        end
    end)
end

-- ADVANCED DIRECT ENGINE INJECTION PIPELINE (REDZ HUB SYSTEM DEPLOY)
local function forceAttachFruitMesh(fruitName)
    local character = player.Character
    if not character then return end
    
    for _, child in ipairs(character:GetChildren()) do
        if child.Name == "ClientFruitModelPrank" or child:IsA("Tool") and child.Name:find("Fruit") then
            child:Destroy()
        end
    end
    
    local hand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
    local backpack = player:FindFirstChild("Backpack")
    if not hand or not backpack then return end
    
    local targetModel = nil
    local nameLower = fruitName:lower()
    
    -- SEARCH STEP: Attempts to crawl game memory storage to find original fruit meshes
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find(nameLower) and obj.Name:lower():find("fruit") then
            targetModel = obj
            break
        end
    end
    
    local tool = Instance.new("Tool")
    tool.Name = fruitName:sub(1,1):upper() .. fruitName:sub(2) .. " Fruit"
    tool.RequiresHandle = true
    
    local handle = nil
    
    -- FALLBACK PIPELINE: If original mesh is blocked, deploys intense plasma weapon matrix
    if targetModel then
        local clone = targetModel:Clone()
        clone.Name = "Handle"
        if clone:IsA("Model") then
            handle = clone:FindFirstChildWhichIsA("BasePart") or Instance.new("Part")
            for _, p in ipairs(clone:GetChildren()) do
                if p:IsA("BasePart") and p ~= handle then
                    local w = Instance.new("WeldConstraint")
                    w.Part0 = handle; w.Part1 = p; w.Parent = p
                    p.Parent = tool
                    p.CanCollide = false
                end
            end
        else
            handle = clone
        end
    else
        handle = Instance.new("Part")
        handle.Size = Vector3.new(1, 1, 1)
        handle.Material = Enum.Material.ForceField
        
        local m = Instance.new("SpecialMesh")
        m.MeshType = Enum.MeshType.Sphere
        m.Parent = handle
    end
    
    handle.Name = "Handle"
    handle.CanCollide = false
    handle.Massless = true
    handle.Parent = tool
    
    -- REDZ-STYLE GLOWING SMOKE EMITTER CHANNELS
    local colorMap = {kitsune = Color3.fromRGB(255,60,180), dragon = Color3.fromRGB(240,20,20), magnet = Color3.fromRGB(120,30,255), tiger = Color3.fromRGB(255,140,0)}
    local elementColor = colorMap[nameLower] or Color3.fromRGB(255,255,255)
    handle.Color = elementColor
    
    local aura = Instance.new("ParticleEmitter")
    aura.Texture = "rbxassetid://24291261"
    aura.Color = ColorSequence.new(elementColor, Color3.fromRGB(255,255,255))
    aura.Size = NumberSequence.new(0.7, 0.1)
    aura.Lifetime = NumberRange.new(0.4, 0.7)
    aura.Rate = 50
    aura.Parent = handle
    
    local sb = Instance.new("SelectionBox")
    sb.Color3 = Color3.fromRGB(255,255,255); sb.Adornee = handle; sb.Parent = handle
    
    tool.Parent = backpack -- Places straight into backpack hotbar natively
end

-- USER INTERACTION FIELDS
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 320, 0, 45)
textBox.Position = UDim2.new(0.5, -160, 0, 70)
textBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
textBox.BorderSizePixel = 0
textBox.Text = ""
textBox.PlaceholderText = "Type: Kitsune, Dragon, Tiger, Magnet..."
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 14
textBox.ZIndex = 5
textBox.Parent = frame

local spawnBtn = Instance.new("TextButton")
spawnBtn.Size = UDim2.new(0, 320, 0, 50)
spawnBtn.Position = UDim2.new(0.5, -160, 0, 135)
spawnBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
spawnBtn.Text = "Spawn In Hand"
spawnBtn.TextColor3 = Color3.fromRGB(10, 10, 10)
spawnBtn.Font = Enum.Font.GothamBold
spawnBtn.TextSize = 16
spawnBtn.ZIndex = 5
spawnBtn.Parent = frame
Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0, 8)

local validFruits = {"kitsune", "dragon", "dragon (east)", "dragon (west)", "magnet", "tiger", "leopard", "dough"}

spawnBtn.MouseButton1Click:Connect(function()
    local text = textBox.Text:lower():match("^%s*(.-)%s*$")
    if text == "" then return end
    
    local isValid = false
    for i = 1, #validFruits do
        if text == validFruits[i] then
            isValid = true
            break
        end
    end
    
    if isValid then
        local formattedName = text:sub(1,1):upper() .. text:sub(2)
        triggerPopup("Success", "SPAWNED IN HOTBAR!", "Successfully injected [" .. formattedName .. "] module data. Check your item hotbar belt slot.")
        forceAttachFruitMesh(text)
    else
        triggerPopup("Error", "FAILED TO ALLOCATE!", "Error: Invalid Item Cluster String code configuration. Asset reference packet dropped.")
    end
end)
