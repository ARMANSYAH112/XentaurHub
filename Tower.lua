-- Tower.lua
-- XentaurHub Tower/Parkour UI

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

-- ==== SCREEN GUI ====
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "XentaurHubTower"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 400, 0, 320)
Main.Position = UDim2.new(0.5, -200, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local UIStroke = Instance.new("UIStroke", Main)
UIStroke.Thickness = 3
UIStroke.Color = Color3.fromRGB(0, 255, 150)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "XentaurHub - Tower/Parkour"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.BackgroundTransparency = 1

-- Minimizable logo
local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -35, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
MinBtn.Text = "≡"
MinBtn.TextColor3 = Color3.fromRGB(0,0,0)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18

local minimized = false
local FullUI = {}
for _, v in pairs(Main:GetChildren()) do
    if v ~= MinBtn then
        table.insert(FullUI, v)
    end
end

MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    for _, v in pairs(FullUI) do
        v.Visible = not minimized
    end
    Main.Size = minimized and UDim2.new(0,50,0,50) or UDim2.new(0,400,0,320)
end)

-- Fungsi buat toggle
local function createToggle(name, pos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, pos, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.Text = name .. ": OFF"

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. ": " .. (state and "ON" or "OFF")
        callback(state)
    end)
end

-- ==== FEATURE TOGGLES ====

-- Extended Hitbox
createToggle("Extended Hitbox", 0.18, function(state)
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            v.Character.HumanoidRootPart.Size = state and Vector3.new(10,10,10) or Vector3.new(2,2,1)
            v.Character.HumanoidRootPart.Transparency = state and 0.5 or 1
            v.Character.HumanoidRootPart.CanCollide = false
        end
    end
end)

-- Teleport to Player
createToggle("Teleport to Player", 0.3, function(state)
    if state then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                player.Character:MoveTo(v.Character.HumanoidRootPart.Position + Vector3.new(0,3,0))
                break
            end
        end
    end
end)

-- Jump Boost
createToggle("Jump Boost", 0.42, function(state)
    hum.UseJumpPower = true
    hum.JumpPower = state and 120 or 50
end)

-- Speed Hack
createToggle("Speed Hack", 0.54, function(state)
    hum.WalkSpeed = state and 80 or 16
end)

-- Invisible
createToggle("Invisible", 0.66, function(state)
    for _, p in pairs(char:GetDescendants()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
            p.Transparency = state and 1 or 0
        end
    end
end)

-- UI Hapus Part
local PartBtn = Instance.new("TextButton", Main)
PartBtn.Size = UDim2.new(0.9, 0, 0, 30)
PartBtn.Position = UDim2.new(0.05,0,0.8,0)
PartBtn.BackgroundColor3 = Color3.fromRGB(255,0,0)
PartBtn.TextColor3 = Color3.fromRGB(255,255,255)
PartBtn.Font = Enum.Font.GothamBold
PartBtn.TextSize = 16
PartBtn.Text = "Buka UI Hapus Part"

PartBtn.MouseButton1Click:Connect(function()
    local DelGui = Instance.new("ScreenGui", player.PlayerGui)
    local Btn = Instance.new("TextButton", DelGui)
    Btn.Size = UDim2.new(0,200,0,50)
    Btn.Position = UDim2.new(0.5,-100,0.1,0)
    Btn.BackgroundColor3 = Color3.fromRGB(0,255,150)
    Btn.Text = "Klik untuk hapus part (radius 15)"
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 18

    Btn.MouseButton1Click:Connect(function()
        for _, v in pairs(workspace:GetChildren()) do
            if (v:IsA("Part") or v:IsA("MeshPart")) and (v.Position - char.HumanoidRootPart.Position).Magnitude < 15 then
                v:Destroy()
            end
        end
    end)
end)
