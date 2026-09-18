--[[
    ==================================================
              FRUIT SPAWNER SYSTEM v3.0 (REAL MESH)
    ==================================================
    * Theme: Ultra Minimal High-Contrast White & Black
    * Input: Manual Text String Matrix (Kitsune, Dragon, Tiger, etc.)
    * Logic: Local Client-Side Mesh Instancing (Visible only to you, Cannot store)
    * Effect: Continuous Electrical Lightning Spark Background
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Clean previous GUI builds
if player:WaitForChild("PlayerGui"):FindFirstChild("FruitSpawnerPanelGui") then
    player.PlayerGui.FruitSpawnerPanelGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "FruitSpawnerPanel"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN BLACK CANVAS CONTEXT
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 240)
frame.Position = UDim2.new(0.5, -190, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10) -- Blackout tech base
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
frameStroke.Color = Color3.fromRGB(255, 255, 255) -- Intense pure white border
frameStroke.Thickness = 2
frameStroke.Transparency = 0.1
frameStroke.Parent = frame

-- FLOATING HEAD TEXT
local title = Instance.new("TextLabel")
title.Text = "Fruit Spawner"
title.Size = UDim2.new(1, 0, 0, 45)
title.Position = UDim2.new(0, 0, 0, 8)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SciFi
title.TextSize = 25
title.ZIndex = 5
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = frame

-- ==================================================
-- CONTINUOUS WHITE ELECTRICAL SPARKING ANIMATION
-- ==================================================
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

-- ==================================================
-- SYSTEMATIC CLIENT-SIDE 3D PHYSICAL FRUIT SPAWNER
-- ==================================================
local function spawnFruitInHandPhysical(fruitName)
    local character = player.Character
    if not character or not character:FindFirstChild("RightHand") and not character:FindFirstChild("Right Arm") then 
        return 
    end
    
    -- Creates a real Tool container structure that forces character holding animation
    local fakeTool = Instance.new("Tool")
    fakeTool.Name = fruitName .. " Fruit"
    fakeTool.RequiresHandle = true
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1.2, 1.2, 1.2)
    handle.BrickColor = BrickColor.new("White")
    handle.Material = Enum.Material.Neon -- Makes the object glow brightly in hand
    handle.CanCollide = false
    handle.Parent = fakeTool
    
    -- Puts a decorative spherical fruit structure inside the handle tracking coordinates
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.Sphere -- Base shape representation
    mesh.Scale = Vector3.new(1.1, 1.1, 1.1)
    mesh.Parent = handle
    
    -- Custom SelectionBox highlights around the fruit box grid
    local selectionBox = Instance.new("SelectionBox")
    selectionBox.Color3 = Color3.fromRGB(255, 255, 255)
    selectionBox.Adornee = handle
    selectionBox.Parent = handle

    -- Forces the item straight into character inventory slot local structure
    fakeTool.Parent = character
end

-- ==================================================
-- INTERACTIVE WHITE ALERT SYSTEM (Warning Matrix)
-- ==================================================
local function showSpawnerNotif(fruitName)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 310, 0, 85)
    notif.Position = UDim2.new(1, 20, 0, 20)
    notif.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    notif.Parent = gui
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 10)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1.5
    stroke.Parent = notif

    local icon = Instance.new("TextLabel")
    icon.Text = "⚡"
    icon.Size = UDim2.new(0, 35, 0, 35)
    icon.Position = UDim2.new(0, 12, 0.5, -17)
    icon.BackgroundTransparency = 1
    icon.TextColor3 = Color3.fromRGB(255, 255, 255)
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = 22
    icon.Parent = notif

    local t1 = Instance.new("TextLabel")
    t1.Text = "SPAWNED IN HAND!"
    t1.Size = UDim2.new(1, -65, 0, 20)
    t1.Position = UDim2.new(0, 52, 0, 10)
    t1.BackgroundTransparency = 1
    t1.TextColor3 = Color3.fromRGB(255, 255, 255)
    t1.Font = Enum.Font.GothamBold
    t1.TextSize = 14
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.Parent = notif

    -- SPECIFIC PRANK WARNING TEXT REQUIREMENT
    local t2 = Instance.new("TextLabel")
    t2.Text = "Warning: Client cache inject bypass active. Object verified in hand slot but cannot be stored or viewed by other server nodes."
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
    
    task.delay(5, function()
        if notif and notif.Parent then
            TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 20, 0, 20)}):Play()
            task.wait(0.3)
            notif:Destroy()
        end
    end)
end

-- ==================================================
-- USER INPUT INTERACTIVE FIELDS 
-- ==================================================
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 320, 0, 45)
textBox.Position = UDim2.new(0.5, -160, 0, 70)
textBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
textBox.BorderSizePixel = 0
textBox.Text = ""
textBox.PlaceholderText = "Type: Kitsune, Dragon (east), Magnet..."
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 14
textBox.ZIndex = 5
textBox.Parent = frame

Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 8)
local inputStroke = Instance.new("UIStroke")
inputStroke.Color = Color3.fromRGB(50, 50, 50)
inputStroke.Thickness = 1
inputStroke.Parent = textBox

textBox.Focused:Connect(function() TweenService:Create(inputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 255, 255)}):Play() end)
textBox.FocusLost:Connect(function() TweenService:Create(inputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(50, 50, 50)}):Play() end)

-- MAIN HIGH CONTRAST ACTIVATION TRIGGER
local spawnBtn = Instance.new("TextButton")
spawnBtn.Size = UDim2.new(0, 320, 0, 50)
spawnBtn.Position = UDim2.new(0.5, -160, 0, 135)
spawnBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
spawnBtn.BorderSizePixel = 0
spawnBtn.Text = "Spawn In Hand"
spawnBtn.TextColor3 = Color3.fromRGB(10, 10, 10)
spawnBtn.Font = Enum.Font.GothamBold
spawnBtn.TextSize = 16
spawnBtn.ZIndex = 5
spawnBtn.Parent = frame

Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0, 8)

spawnBtn.MouseButton1Click:Connect(function()
    local text = textBox.Text
    if text ~= "" and text ~= " " then
        -- Formats strings nicely automatically 
        local formattedName = text:sub(1,1):upper() .. text:sub(2)
        
        spawnBtn.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
        task.wait(0.1)
        spawnBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        
        -- EXECUTES DUAL SYSTEM PIPELINES (Spawns 3D Object + Shows Alert Logs)
        spawnFruitInHandPhysical(formattedName)
        showSpawnerNotif(formattedName)
    end
end)
