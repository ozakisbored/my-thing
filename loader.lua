local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "ScriptToggler"
mainGui.ResetOnSpawn = false

local toggleButton = Instance.new("TextButton", mainGui)
toggleButton.Size = UDim2.new(0, 100, 0, 30)
toggleButton.Position = UDim2.new(0, 20, 0, 100)
toggleButton.Text = "Open Menu"
toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.Active = true
toggleButton.Draggable = true

local menu = Instance.new("Frame", mainGui)
menu.Size = UDim2.new(0, 250, 0, 220)
menu.Position = UDim2.new(0, 140, 0, 100)
menu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menu.Visible = false
menu.Active = true
menu.Draggable = true

local uiList = Instance.new("UIListLayout", menu)
uiList.Padding = UDim.new(0, 6)
uiList.FillDirection = Enum.FillDirection.Vertical
uiList.SortOrder = Enum.SortOrder.LayoutOrder

local toggles = {
    chests = false,
    playtime = false,
    bubble = false,
    doggy = false,
    shard = false,
    reroll = false,
    alien = false,
    genie = false,
}

local function createToggle(name)
    local btn = Instance.new("TextButton", menu)
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.AutoButtonColor = true

    return btn
end

toggleButton.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
    toggleButton.Text = menu.Visible and "Close Menu" or "Open Menu"
end)

local chestToggle = createToggle("Chests")
chestToggle.MouseButton1Click:Connect(function()
    toggles.chests = not toggles.chests
    chestToggle.Text = "Chests: " .. (toggles.chests and "ON" or "OFF")

    if toggles.chests then
        spawn(function()
            local remote = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event")
            while toggles.chests do
                remote:FireServer("ClaimChest", "Giant Chest", true)
                wait(2)
                remote:FireServer("ClaimFreeWheelSpin")
                wait(2)
                remote:FireServer("ClaimChest", "Void Chest", true)
                wait(2)
            end
        end)
    end
end)

local playtimeToggle = createToggle("Playtime")
playtimeToggle.MouseButton1Click:Connect(function()
    toggles.playtime = not toggles.playtime
    playtimeToggle.Text = "Playtime: " .. (toggles.playtime and "ON" or "OFF")

    if toggles.playtime then
        spawn(function()
            local remoteFunction = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Function")
            while toggles.playtime do
                for i = 1, 9 do
                    remoteFunction:InvokeServer("ClaimPlaytime", i)
                end
                wait(10)
            end
        end)
    end
end)

local bubbleToggle = createToggle("Bubble")
bubbleToggle.MouseButton1Click:Connect(function()
    toggles.bubble = not toggles.bubble
    bubbleToggle.Text = "Bubble: " .. (toggles.bubble and "ON" or "OFF")

    if toggles.bubble then
        spawn(function()
            local remote = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event")
            while toggles.bubble do
                remote:FireServer("BlowBubble")
                wait(0.1)
            end
        end)
    end
end)

local doggyToggle = createToggle("Doggy")
doggyToggle.MouseButton1Click:Connect(function()
    toggles.doggy = not toggles.doggy
    doggyToggle.Text = "Doggy: " .. (toggles.doggy and "ON" or "OFF")

    if toggles.doggy then
        spawn(function()
            local remote = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event")
            local args = {
                [1] = "DoggyJumpWin",
                [2] = 3
            }

            while toggles.doggy do
                remote:FireServer(unpack(args))
                wait(2)
            end
        end)
    end
end)

local alienToggle = createToggle("Alien Shop")
alienToggle.MouseButton1Click:Connect(function()
    toggles.alien = not toggles.alien
    alienToggle.Text = "Alien Shop: " .. (toggles.alien and "ON" or "OFF")

    if toggles.alien then
        spawn(function()
            local remote = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event")
            while toggles.alien do
                for i = 1, 3 do
                    local args = {
                        [1] = "BuyShopItem",
                        [2] = "alien-shop",
                        [3] = i
                    }
                    remote:FireServer(unpack(args))
                    wait(2)
                end
            end
        end)
    end
end)

local shardToggle = createToggle("Shard Shop")
shardToggle.MouseButton1Click:Connect(function()
    toggles.shard = not toggles.shard
    shardToggle.Text = "Shard Shop: " .. (toggles.shard and "ON" or "OFF")

    if toggles.shard then
        spawn(function()
            local remote = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event")
            while toggles.shard do
                for i = 1, 3 do
                    local args = {
                        [1] = "BuyShopItem",
                        [2] = "shard-shop",
                        [3] = i
                    }
                    remote:FireServer(unpack(args))
                    wait(2)
                end
            end
        end)
    end
end)

local rerollToggle = createToggle("Free Reroll")
rerollToggle.MouseButton1Click:Connect(function()
    toggles.reroll = not toggles.reroll
    rerollToggle.Text = "Free Reroll: " .. (toggles.reroll and "ON" or "OFF")

    if toggles.reroll then
        spawn(function()
            local remote = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event")
            local args = {
                [1] = "ShopFreeReroll",
                [2] = "alien-shop"
            }

            while toggles.reroll do
                remote:FireServer(unpack(args))
                wait(30)
            end
        end)
    end
end)

local genieToggle = createToggle("Start Genie Quest")
genieToggle.MouseButton1Click:Connect(function()
    toggles.genie = not toggles.genie
    genieToggle.Text = "Start Genie Quest: " .. (toggles.genie and "ON" or "OFF")

    if toggles.genie then
        spawn(function()
            local remote = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event")
            local args = {
                [1] = "StartGenieQuest",
                [2] = 2
            }

            while toggles.genie do
                remote:FireServer(unpack(args))
                wait(2)
            end
        end)
    end
end)
