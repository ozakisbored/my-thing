local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "ScriptToggler"
mainGui.ResetOnSpawn = false

local toggleButton = Instance.new("TextButton", mainGui)
toggleButton.Size = UDim2.new(0, 120, 0, 30)
toggleButton.Position = UDim2.new(0, 20, 0, 100)
toggleButton.Text = "Open Menu"
toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.Active = true
toggleButton.Draggable = true

local menu = Instance.new("Frame", mainGui)
menu.Size = UDim2.new(0, 270, 0, 500)
menu.Position = UDim2.new(0, 150, 0, 100)
menu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menu.Visible = false
menu.Active = true
menu.Draggable = true

local uiList = Instance.new("UIListLayout", menu)
uiList.Padding = UDim.new(0, 6)
uiList.FillDirection = Enum.FillDirection.Vertical
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiList.VerticalAlignment = Enum.VerticalAlignment.Top

local toggles = {
    chests = false,
    playtime = false,
    bubble = false,
    doggy = false,
    shard = false,
    reroll = false,
    alien = false,
}

if getgenv().togglesConfig then
    for k, v in pairs(getgenv().togglesConfig) do
        if toggles[k] ~= nil then
            toggles[k] = v
        end
    end
end

local buttons = {}

local function createToggle(name, key, onToggle)
    local btn = Instance.new("TextButton", menu)
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Text = name .. ": " .. (toggles[key] and "ON" or "OFF")
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.AutoButtonColor = true

    btn.MouseButton1Click:Connect(function()
        toggles[key] = not toggles[key]
        btn.Text = name .. ": " .. (toggles[key] and "ON" or "OFF")

        if toggles[key] and onToggle then
            spawn(onToggle)
        end
    end)

    buttons[key] = btn
end

createToggle("Chests", "chests", function()
    local remote = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event")
    while toggles.chests do
        remote:FireServer("ClaimChest", "Giant Chest", true)
        wait(1)
        remote:FireServer("ClaimFreeWheelSpin")
        wait(1)
        remote:FireServer("ClaimChest", "Void Chest", true)
        wait(1)
    end
end)

createToggle("Playtime", "playtime", function()
    local remoteFunction = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Function")
    while toggles.playtime do
        for i = 1, 9 do
            remoteFunction:InvokeServer("ClaimPlaytime", i)
        end
        wait(10)
    end
end)

createToggle("Bubble", "bubble", function()
    local remote = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event")
    spawn(function()
        while toggles.bubble do
            remote:FireServer("SellBubble")
            wait(0.1)
        end
    end)
    spawn(function()
        while toggles.bubble do
            remote:FireServer("BlowBubble")
            wait(0.1)
        end
    end)
end)

createToggle("Doggy", "doggy", function()
    local remote = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event")
    while toggles.doggy do
        remote:FireServer("DoggyJumpWin", 3)
        wait(0.1)
    end
end)

createToggle("Alien Shop", "alien", function()
    local remote = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event")
    while toggles.alien do
        for i = 1, 3 do
            remote:FireServer("BuyShopItem", "alien-shop", i)
            wait(0.1)
        end
    end
end)

createToggle("Shard Shop", "shard", function()
    local remote = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event")
    while toggles.shard do
        for i = 1, 3 do
            remote:FireServer("BuyShopItem", "shard-shop", i)
            wait(0.1)
        end
    end
end)

createToggle("Free Reroll", "reroll", function()
    local remote = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event")
    while toggles.reroll do
        remote:FireServer("ShopFreeReroll", "alien-shop")
        wait(0.1)
    end
end)

local saveButton = Instance.new("TextButton", menu)
saveButton.Size = UDim2.new(1, -10, 0, 40)
saveButton.Text = "Save Config"
saveButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
saveButton.TextColor3 = Color3.new(1, 1, 1)
saveButton.AutoButtonColor = true

saveButton.MouseButton1Click:Connect(function()
    getgenv().togglesConfig = toggles
    saveButton.Text = "Saved!"
    wait(1)
    saveButton.Text = "Save Config"
end)

toggleButton.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
    toggleButton.Text = menu.Visible and "Close Menu" or "Open Menu"
end)

task.delay(1, function()
    for key, btn in pairs(buttons) do
        if toggles[key] then
            btn:MouseButton1Click()
        end
    end
end)
