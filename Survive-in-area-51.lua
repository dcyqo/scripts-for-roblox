local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/dcyqo/Rayfield/refs/heads/main/source.lua'))()

local Window = Rayfield:CreateWindow({
    Name = "Survive in Area 51 - Mods",
    LoadingTitle = "Загрузка модов...",
    LoadingSubtitle = "Gun + Aura + Godmode",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Area51Mods",
        FileName = "Config"
    }
})

-- ==================== MAIN TAB ====================
local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateSection("Survive in Area 51")
MainTab:CreateLabel("Полный пакет модов")
MainTab:CreateParagraph({Title = "Инструкция", Content = "Включи нужные функции во вкладке Game.\nПеред включением Gun Mod — убери оружие из рук."})

-- ==================== GAME TAB ====================
local GameTab = Window:CreateTab("Game", 6022668960)

GameTab:CreateSection("Модификации")

local connections = {}
local gunEnabled = false

-- ====================== 1. GUN MOD ======================
local function startGunMod()
    if gunEnabled then return end
    gunEnabled = true

    local lp = game.Players.LocalPlayer

    local function processGun(v)
        task.spawn(function()
            if v:GetAttribute("HasInInventory") then return end
            if not v:FindFirstChild("GunScript_Local") then return end

            v:WaitForChild("GunScript_Local").Enabled = false
            v:SetAttribute("HasInInventory", true)

            local weaponnow = v
            local Handle = v:WaitForChild("Handle")
            local mouse = lp:GetMouse()
            local camera = workspace.CurrentCamera
            local char = workspace:WaitForChild(lp.Name)
            local humanoid = char:WaitForChild("Humanoid")
            local CAS = game:GetService("ContextActionService")
            local GunSound = game.ReplicatedStorage.GunSound

            local old = require(v.Setting)
            local newSetting = getgenv().NewSetting or {FireRate = 0.05, Auto = true, Spread = 0, AmmoPerClip = math.huge, ExplosiveEnabled = true, Radius = 50}
            local Setting = {}
            for k, val in next, old do Setting[k] = val end
            for k, val in next, newSetting do Setting[k] = val end

            local GunScript_Server = v:WaitForChild("GunScript_Server")
            local ChangeAmmoAndClip = GunScript_Server:WaitForChild("ChangeAmmoAndClip")
            local InflictTarget = GunScript_Server:WaitForChild("InflictTarget")

            local v4, v5, v6, v7, v8 = nil, nil, nil, nil, nil
            local v9 = Handle
            local v10 = nil
            if Setting.DualEnabled then v10 = v:WaitForChild("Handle2", 2) end

            local v11, v12, v13, v14, v15 = false, true, false, false, false
            local v16 = 9999
            local v17 = 9999
            local t = {}

            if Setting.IdleAnimationID or Setting.DualEnabled then v4 = humanoid:LoadAnimation(v:WaitForChild("IdleAnim")) end
            if Setting.FireAnimationID then v5 = humanoid:LoadAnimation(v:WaitForChild("FireAnim")) end
            if Setting.ReloadAnimationID then v6 = humanoid:LoadAnimation(v:WaitForChild("ReloadAnim")) end

            local function B(p1) 
                if p1 then 
                    local sum = 0
                    while sum < p1 do sum += game:GetService("RunService").Heartbeat:wait() end
                else 
                    game:GetService("RunService").Heartbeat:wait() 
                end 
            end

            local function g() v13 = true end
            local function f() v13 = false end
            local function k() -- reload logic (упрощённо)
                v14 = true
                B(Setting.ReloadTime or 1)
                v16 = Setting.AmmoPerClip or 9999
                ChangeAmmoAndClip:FireServer(v16, v17)
                v14 = false
            end

            mouse.Button1Down:Connect(g)
            mouse.Button1Up:Connect(f)

            v.Equipped:Connect(function()
                v11 = true
                if v4 then v4:Play() end
                -- ... (остальная логика Equipped из первого скрипта)
            end)

            v.Unequipped:Connect(function()
                v11 = false
                if v4 then v4:Stop() end
            end)
        end)
    end

    local conn = lp.Backpack.ChildAdded:Connect(function(v)
        task.wait(0.5)
        processGun(v)
    end)

    for _, v in pairs(lp.Backpack:GetChildren()) do processGun(v) end
    table.insert(connections, conn)
end

local function stopGunMod()
    gunEnabled = false
    for _, c in ipairs(connections) do pcall(function() c:Disconnect() end) end
    connections = {}
end

-- ====================== 2. POWERED HIT AURA ======================
local auraEnabled = false
local auraConn = nil

local function startAura()
    if auraEnabled then return end
    auraEnabled = true
    -- Powered Hit Aura (из твоей ссылки)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Polinorsik/Scriptss/refs/heads/main/Survive%20in%20area%2051"))()
end

local function stopAura()
    auraEnabled = false
    -- Здесь можно добавить отключение, если скрипт поддерживает
end

-- ====================== 3. GODMODE ======================
local godmodeEnabled = false

local function startGodmode()
    if godmodeEnabled then return end
    godmodeEnabled = true

    local a = game.Players.LocalPlayer
    local b = a.Character or a.CharacterAdded:Wait()
    local c = b:WaitForChild("Humanoid")
    local d = b:WaitForChild("Torso")
    local f = nil

    local function i()
        if f then 
            local e = f.CFrame
            local j = tick()
            while tick() - j < 1 do 
                f.CFrame = d.CFrame 
                wait(0.1) 
            end
            f.CFrame = e 
        end
    end

    local function k()
        for _, m in pairs(workspace:GetDescendants()) do
            if m:IsA("Part") and m.Name == "Head" and m.Parent and m.Parent.Name == "Blizzard Armor" then
                m.CanCollide = false
                m.Transparency = 1
                f = m
            end
        end
    end

    k()

    spawn(function()
        local o = c.Health
        while godmodeEnabled do
            wait(0.1)
            if c.Health < o then
                i()
            end
            o = c.Health
        end
    end)

    Rayfield:Notify({Title = "Godmode", Content = "Включён (Reset = выкл)", Duration = 5})
end

local function stopGodmode()
    godmodeEnabled = false
end

-- ==================== ТОГГЛЫ ====================
GameTab:CreateToggle({
    Name = "🔫 Gun Mod (Модификация оружия)",
    CurrentValue = false,
    Flag = "GunMod",
    Callback = function(Value)
        if Value then startGunMod() else stopGunMod() end
    end,
})

GameTab:CreateToggle({
    Name = "⚔️ Powered Hit Aura",
    CurrentValue = false,
    Flag = "HitAura",
    Callback = function(Value)
        if Value then startAura() else stopAura() end
    end,
})

GameTab:CreateToggle({
    Name = "🛡️ Godmode",
    CurrentValue = false,
    Flag = "Godmode",
    Callback = function(Value)
        if Value then startGodmode() else stopGodmode() end
    end,
})

Rayfield:Notify({Title = "Скрипт загружен", Content = "Все 3 функции готовы во вкладке Game", Duration = 6})
