--[[
    ==================================================
              FRUIT SPAWNER SYSTEM v7.0 (FINAL FIX)
    ==================================================
    * Theme: Ultra Minimal High-Contrast White & Black
    * Logic: Procedural Geometry Compositing (Instant Loading)
    * Features: Particle Plasma Aura Tracking Matrix
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

if player:WaitForChild("PlayerGui"):FindFirstChild("FruitSpawnerPanelGui") then
    player.PlayerGui.FruitSpawnerPanelGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "FruitSpawnerPanel"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN CONTEXT FRAME
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

-- BACKGROUND SPARK ANIMATION
task.spawn(function()
    while task.wait(math.random(10, 25)/100) do
        if not frame or not frame.Parent then break end
        local sparkLine = Instance.new("Frame")
        sparkLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        sparkLine.BorderSizePixel = 0
        sparkLine.Size = UDim2.new(0, math.random(1, 3), 0, math.random(30, 140))
        sparkLine.Position = UDim2.new(math.random(2, 98)/100, 0, math.random(-10, 80)/100, 0)
        sparkLine.BackgroundTransparency = 0.25
        sparkLine.ZIndex = 2
        sparkLine.Parent = frame
        TweenService:Create(sparkLine, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, sparkLine.Size.X.Offset * 3, 0, 0)
        }):Play()
        game:GetService("Debris"):AddItem(sparkLine, 0.25)
    end
end)

-- GLOBAL ALERT COMPONENT
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

    TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -330, 0, 20)}):Play()
    task.delay(4.5, function()
        if notif and notif.Parent then
            TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 20, 0, 20)}):Play()
            task.wait(0.3)
            notif:Destroy()
        end
    end)
end

-- PROCEDURAL FRUIT CORE RENDERING ENGINE (Bypasses Roblox Asset Download Blocks)
local function forceAttachFruitMesh(fruitName)
    local character = player.Character
    if not character then return end
    
    -- Clean previous instances safely
    for _, child in ipairs(character:GetChildren()) do
        if child.Name:find("PhysicalBlock") or child.Name:find("FruitContainer") then
            child:Destroy()
        end
    end
    
    local targetLimb = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
    if not targetLimb then return end
    
    -- Main transparent folder structure inside player workspace layer
    local fruitContainer = Instance.new("Model")
    fruitContainer.Name = fruitName .. "FruitContainer"
    fruitContainer.Parent = character
    
    local baseCore = Instance.new("Part")
    baseCore.Name = "FruitCoreMainPhysicalBlock"
    baseCore.Size = Vector3.new(0.9, 0.9, 0.9)
    baseCore.Material = Enum.Material.Glass
    baseCore.Transparency = 0.1
    baseCore.CanCollide = false
    baseCore.Massless = true
    
    local sphereMesh = Instance.new("SpecialMesh")
    sphereMesh.MeshType = Enum.MeshType.Sphere -- Instant smooth round core shape loading
    sphereMesh.Parent = baseCore
    
    -- Procedural Shape Definition Combinations
    if fruitName:lower() == "kitsune" then
        baseCore.Color = Color3.fromRGB(255, 50, 160) -- Neon Kitsune Purple Pink
        
        -- Generates a complex high-tech particle cross star layer around core
        for i = 1, 3 do
            local spike = Instance.new("Part")
            spike.Size = Vector3.new(1.3, 0.25, 0.25)
            spike.Color = Color3.fromRGB(255, 255, 255)
            spike.Material = Enum.Material.Neon
            spike.CanCollide = false
            spike.Massless = true
            spike.CFrame = targetLimb.CFrame * CFrame.Angles(math.rad(i * 45), math.rad(i * 30), 0)
            spike.Parent = fruitContainer
            
            local w = Instance.new("WeldConstraint")
            wled.Part0 = targetLimb; w.Part1 = spike; w.Parent = spike
        end
        
    elseif fruitName:lower():find("dragon") then
        baseCore.Color = Color3.fromRGB(240, 20, 20) -- Deep Crimson Fire
        
        -- Creates stacked flame block vectors
        for i = 1, 4 do
            local spike = Instance.new("Part")
            spike.Size = Vector3.new(0.6, 0.6, 0.6)
            spike.Color = Color3.fromRGB(255, 100, 0) -- Fire Orange details
            spike.Material = Enum.Material.Neon
            spike.CanCollide = false
            spike.Massless = true
            
            local m = Instance.new("SpecialMesh")
            m.MeshType = Enum.MeshType.Wedge -- Sharp organic dragon scales/horns shape
            m.Parent = spike
            
            spike.CFrame = targetLimb.CFrame * CFrame.new(0,0,0) * CFrame.Angles(0, math.rad(i * 90), math.rad(45))
            spike.Parent = fruitContainer
            local w = Instance.new("WeldConstraint")
            w.Part0 = targetLimb; w.Part1 = spike; w.Parent = spike
        end
    elseif fruitName:lower() == "magnet" then
        baseCore.Color = Color3.fromRGB(120, 30, 255)
        sphereMesh.MeshType = Enum.MeshType.Torso
    else
        baseCore.Color = Color3.fromRGB(245, 245, 245)
    end
    
    -- HIGH CONTRAST GLOW PLASMA PARTICLES AURA
    local auraParticles = Instance.new("ParticleEmitter")
    auraParticles.Texture = "rbxassetid://24291261" 
    auraParticles.Color = ColorSequence.new(baseCore.Color, Color3.fromRGB(255,255,255))
    auraParticles.Size = NumberSequence.new(0.6, 0.1)
    auraParticles.Lifetime = NumberRange.new(0.3, 0.6)
    auraParticles.Speed = NumberRange.new(0.2, 1)
    auraParticles.Rate = 45 -- Intense flow rate looks magical and real
    auraParticles.Parent = baseCore
    
    -- Selection Box highlight border mapping
    local sBox = Instance.new("SelectionBox")
    sBox.Color3 = Color3.fromRGB(255, 255, 255)
    sBox.Adornee = baseCore
    sBox.Transparency = 0.4
    sBox.Parent = baseCore
    
    baseCore.CFrame = targetLimb.CFrame * CFrame.new(0, -0.3, 0)
    baseCore.Parent = fruitContainer
    
    local weld = Instance.new("WeldConstraint")
    weld.Part0 = targetLimb
    weld.Part1 = baseCore
    weld.Parent = baseCore
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
