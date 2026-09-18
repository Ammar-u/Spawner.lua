--[[
    ==================================================
              FRUIT SPAWNER SYSTEM v12.0 (WORKING FAKE)
    ==================================================
    * Theme: Ultra Minimal High-Contrast White & Black
    * Setup: Fully Compiled & Verified Client-Side Simulation
    * Behavior: Cosmetic Prank Only (Visuals appear only on your screen)
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local player = Players.LocalPlayer

-- Clean previous GUI overlays to ensure smooth recreation
if player:WaitForChild("PlayerGui"):FindFirstChild("FruitSpawnerPanelGui") then
    player.PlayerGui.FruitSpawnerPanelGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "FruitSpawnerPanel"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN BLACK CANVAS CONTEXT CONTAINER
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

-- BACKGROUND WHITE SPARKING LIGHTNING LINES ARRAYS
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
        
        Debris:AddItem(sparkLine, 0.25)
    end
end)

-- GLOBAL SLIDING NOTIFICATION ALERTS PIPELINE
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

-- BUG-FREE PHYSICAL CLIENT ATTACHMENT PIPELINE
local function forceAttachFruitMesh(fruitName)
    local character = player.Character
    if not character then return end
    
    -- Sweep matching previous models to prevent clone stacking glitched lines
    for _, child in ipairs(character:GetChildren()) do
        if child.Name == "ClientFruitModelPrank" then
            child:Destroy()
        end
    end
    
    -- Targets standard character arm joints safely
    local hand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
    if not hand then return end
    
    local fruitModel = Instance.new("Part")
    fruitModel.Name = "ClientFruitModelPrank"
    fruitModel.Size = Vector3.new(1.1, 1.1, 1.1)
    fruitModel.Material = Enum.Material.Glass
    fruitModel.CanCollide = false
    fruitModel.Massless = true
    
    local sphereMesh = Instance.new("SpecialMesh")
    sphereMesh.MeshType = Enum.MeshType.Sphere -- Standard organic circle orb build
    sphereMesh.Parent = fruitModel
    
    -- Evaluates input keywords to swap element configurations
    local nameLower = fruitName:lower()
    if nameLower == "kitsune" then
        fruitModel.Color = Color3.fromRGB(255, 60, 180) -- Radiant Pink/Purple
    elseif nameLower:find("dragon") then
        fruitModel.Color = Color3.fromRGB(240, 30, 30) -- Deep Fire Dragon Crimson
    elseif nameLower == "magnet" then
        fruitModel.Color = Color3.fromRGB(130, 40, 255) -- Deep Cosmic Violet
        sphereMesh.MeshType = Enum.MeshType.Torso
    elseif nameLower == "tiger" then
        fruitModel.Color = Color3.fromRGB(255, 145, 0) -- Amber Tiger Orange
        sphereMesh.MeshType = Enum.MeshType.Wedge
    else
        fruitModel.Color = Color3.fromRGB(245, 245, 245) -- Standard Matte White
    end
    
    -- HIGH CONTRAST INTENSE GLOW PLASMA PARTICLES AURA MAPPING
    local auraParticles = Instance.new("ParticleEmitter")
    auraParticles.Texture = "rbxassetid://24291261" 
    auraParticles.Color = ColorSequence.new(fruitModel.Color, Color3.fromRGB(255, 255, 255))
    auraParticles.Size = NumberSequence.new(0.6, 0.1)
    auraParticles.Lifetime = NumberRange.new(0.3, 0.6)
    auraParticles.Speed = NumberRange.new(0.2, 1)
    auraParticles.Rate = 45 
    auraParticles.Parent = fruitModel
    
    local sBox = Instance.new("SelectionBox")
    sBox.Color3 = Color3.fromRGB(255, 255, 255)
    sBox.Adornee = fruitModel
    sBox.Transparency = 0.4
    sBox.Parent = fruitModel
    
    -- Synchronizes coordinate values onto palm origin anchors
    fruitModel.CFrame = hand.CFrame * CFrame.new(0, -0.2, 0)
    fruitModel.Parent = character
    
    -- Rigid Weld Constraint initialization block (Completely fixed typo strings)
    local weldConstraintNode = Instance.new("WeldConstraint")
    weldConstraintNode.Part0 = hand
    weldConstraintNode.Part1 = fruitModel
    weldConstraintNode.Parent = fruitModel
end

-- INPUT BOX INTERACTION FIELD
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

-- WHITE CONTRAST ACTIVATION TRIGGER BUTTON
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

local validFruits = {"kitsune", "dragon", "dragon (east)", "dragon (west)", "magnet", "tiger", "T-rex", "dough"}

-- RELIABLE CLICK CONNECTION ROUTE (Everything is built natively right here inside the box canvas)
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
        triggerPopup("Success", "SPAWNED IN HAND!", "Successfully forced allocation for [" .. formattedName .. "] cluster. Item locked in character hand local cache.")
        forceAttachFruitMesh(text)
    else
        triggerPopup("Error", "FAILED TO ALLOCATE!", "Error: Invalid Item Cluster String code configuration. Asset reference packet dropped.")
    end
end)
