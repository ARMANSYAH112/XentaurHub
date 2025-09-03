-- index.lua
-- XentaurHub Loader

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XentaurHubUI"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 350, 0, 200)
Frame.Position = UDim2.new(0.5, -175, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

-- Glow effect (neon)
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 255, 150)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = Frame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "XentaurHub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 28
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextStrokeTransparency = 0
Title.Parent = Frame

-- Key input
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.8, 0, 0, 40)
TextBox.Position = UDim2.new(0.1, 0, 0.4, 0)
TextBox.PlaceholderText = "Masukkan key..."
TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 18
TextBox.Parent = Frame

-- Enter Button
local EnterBtn = Instance.new("TextButton")
EnterBtn.Size = UDim2.new(0.35, 0, 0, 35)
EnterBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
EnterBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
EnterBtn.Text = "Enter"
EnterBtn.Font = Enum.Font.GothamBold
EnterBtn.TextSize = 18
EnterBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
EnterBtn.Parent = Frame

-- Get Key Button
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.35, 0, 0, 35)
GetKeyBtn.Position = UDim2.new(0.55, 0, 0.7, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
GetKeyBtn.Text = "Get Key"
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 18
GetKeyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
GetKeyBtn.Parent = Frame

-- SYSTEM
local correctKey = "ArmansyahOfc" -- ganti sesuai key yang kamu mau

EnterBtn.MouseButton1Click:Connect(function()
    if TextBox.Text == correctKey then
        Frame:Destroy()
        -- ambil nama game
        local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        local fileName = gameName:gsub(" ", "_") .. ".lua"
        if isfile(fileName) then
            loadfile(fileName)()
        else
            warn("Script untuk game " .. gameName .. " tidak ditemukan!")
        end
    else
        TextBox.Text = ""
        TextBox.PlaceholderText = "Key salah!"
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/ceJD94MW") -- ganti link ke sistem key kamu
end)
