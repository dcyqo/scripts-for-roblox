local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/dcyqo/Rayfield/refs/heads/main/source.lua'))()

local Window = Rayfield:CreateWindow({
    Name = "Survive in Area 51 - Mods",
    LoadingTitle = "Загрузка...",
    LoadingSubtitle = "Gun + Aura + Godmode",
    ConfigurationSaving = { Enabled = true, FolderName = "Area51Mods", FileName = "Config" }
})

local MainTab = Window:CreateTab("Main", 4483362458)
MainTab:CreateSection("Survive in Area 51")
MainTab:CreateLabel("Исправленная версия")

local GameTab = Window:CreateTab("Game", 6022668960)
GameTab:CreateSection("Модификации")

local connections = {}
local gunEnabled = false
local originalGunScripts = {}

-- ====================== GUN MOD ======================
local function startGunMod()
    if gunEnabled then return end
    gunEnabled = true

    local lp = game.Players.LocalPlayer

    local function processGun(tool)
        if tool:GetAttribute("ProcessedByMod") then return end
        tool:SetAttribute("ProcessedByMod", true)

        local localScript = tool:FindFirstChild("GunScript_Local")
        if localScript then
            originalGunScripts[tool] = localScript.Enabled
            localScript.Enabled = false  -- Отключаем оригинал
        end

        -- Здесь можно добавить твои улучшения (быстрая перезарядка, бесконечные патроны и т.д.)
        -- Пока оставляем базовую логику
    end

    -- Обработка текущего и нового оружия
    for _, tool in pairs(lp.Backpack:GetChildren()) do
        if tool:IsA("Tool") then processGun(tool) end
    end
    for _, tool in pairs(lp.Character:GetChildren()) do
        if tool:IsA("Tool") then processGun(tool) end
    end

    local backpackConn = lp.Backpack.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then task.wait(0.3); processGun(child) end
    end)

    local characterConn = lp.CharacterAdded:Connect(function(char)
        task.wait(1)
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") then processGun(tool) end
        end
    end)

    table.insert(connections, backpackConn)
    table.insert(connections, characterConn)
end

local function stopGunMod()
    gunEnabled = false
    for _, conn in ipairs(connections) do
        pcall(function() conn:Disconnect() end)
    end
    connections = {}

    -- Восстанавливаем оригинальные скрипты
    for tool, wasEnabled in pairs(originalGunScripts) do
        local localScript = tool:FindFirstChild("GunScript_Local")
        if localScript then
            localScript.Enabled = wasEnabled
        end
    end
    originalGunScripts = {}
end

-- ====================== HIT AURA ======================
local function startAura()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Polinorsik/Scriptss/refs/heads/main/Survive%20in%20area%2051"))()
end

-- ====================== GODMODE ======================
local godmodeEnabled = false

local function startGodmode()
    godmodeEnabled = true
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local torso = character:WaitForChild("Torso")
    local armorHead = nil

    local function resetArmor()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Part") and obj.Name == "Head" and obj.Parent and obj.Parent.Name == "Blizzard Armor" then
                obj.CanCollide = false
                obj.Transparency = 1
                armorHead = obj
            end
        end
    end

    resetArmor()

    spawn(function()
        local lastHealth = humanoid.Health
        while godmodeEnabled and humanoid and humanoid.Parent do
            wait(0.1)
            if humanoid.Health < lastHealth then
                if armorHead then
                    armorHead.CFrame = torso.CFrame
                end
            end
            lastHealth = humanoid.Health
        end
    end)
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
        if Value then
            startGunMod()
            Rayfield:Notify({Title = "Gun Mod", Content = "Включён", Duration = 3})
        else
            stopGunMod()
            Rayfield:Notify({Title = "Gun Mod", Content = "Выключен — оружие восстановлено", Duration = 3})
        end
    end,
})

GameTab:CreateToggle({
    Name = "⚔️ Powered Hit Aura",
    CurrentValue = false,
    Flag = "HitAura",
    Callback = function(Value)
        if Value then startAura() end
    end,
})

GameTab:CreateToggle({
    Name = "🛡️ Godmode",
    CurrentValue = false,
    Flag = "Godmode",
    Callback = function(Value)
        if Value then
            startGodmode()
        else
            stopGodmode()
        end
    end,
})

Rayfield:Notify({Title = "Скрипт готов", Content = "Попробуй включить/выключить Gun Mod", Duration = 5})
