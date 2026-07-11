local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/dcyqo/Rayfield/refs/heads/main/source.lua'))()

local Window = Rayfield:CreateWindow({
    Name = "Murino horror",
    LoadingTitle = "Loading Script..",
    LoadingSubtitle = "by @imfloppa",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "FloppaScripts",
        FileName = "MainConfig"
    },
})

-- ==================== СОЗДАЁМ ВСЕ ТАБЫ СРАЗУ ====================
local TabMain = Window:CreateTab("Основное", 4483362458)
local TabGame = Window:CreateTab("Главное", 4483362458)

-- ==================== ОСНОВНОЕ ====================
TabMain:CreateParagraph({ Title = "ЙОУ😎", Content = "Привет, Друн!\n\nЯ очень благодарен тебе за использование моего скрипта." })
TabMain:CreateParagraph({ Title = "ПРАВИЛА СОГЛАШЕНИЯ", Content = "ЗАПУСКАЯ СКРИПТ ВЫ АВТОМАТИЧЕСКИ СОГЛАШАЕТЕСЬ С ПРАВИЛАМИ..." })
TabMain:CreateParagraph({ Title = "ОБНОВЛЕНИЯ", Content = "Все обновления скрипта будут выходить в Discord сервере." })
TabMain:CreateParagraph({ Title = "❔ВЕРСИЯ", Content = "v1.2 | Alpha script" })
TabMain:CreateLabel("✓ – Значит полностью рабочий.\n× – Значит неполностью/полностью нерабочий")

TabMain:CreateButton({
    Name = "Discord Server",
    Callback = function()
        setclipboard("https://discord.gg/VbwR3pmNAb")
        Rayfield:Notify({
            Title = "Discord",
            Content = "Ссылка скопирована!",
            Duration = 5
        })
    end
})

-- ==================== ГЛАВНОЕ ====================
local spd = false
local esp = false

TabGame:CreateToggle({
    Name = "Спидранер",
    CurrentValue = false,
    Flag = "SpeedrunnerToggle",
    Callback = function(Value)
        spd = Value
        Rayfield:Notify({ Title = "Спидранер", Content = spd and "Включён (50)" or "Выключен", Duration = 2 })
    end,
})

TabGame:CreateToggle({
    Name = "Ребята я вас вижу",
    CurrentValue = false,
    Flag = "ESPToggle",
    Callback = function(Value)
        esp = Value
        Rayfield:Notify({ Title = "ESP", Content = esp and "Включён" or "Выключен", Duration = 2 })
    end,
})

TabGame:CreateButton({
    Name = "Зелье ночного зрения (в разработке)",
    Callback = function()
        Rayfield:Notify({ Title = "В разработке", Content = "Зелье ночного зрения пока не готово", Duration = 3 })
    end,
})

-- Логика Спидранер
task.spawn(function()
    while task.wait(0.3) do
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = spd and 50 or 16
            end
        end)
    end
end)

-- Логика ESP
task.spawn(function()
    while task.wait(1.5) do
        pcall(function()
            for _, pl in pairs(game:GetService("Players"):GetPlayers()) do
                if pl \~= game.Players.LocalPlayer and pl.Character then
                    local h = pl.Character:FindFirstChild("Highlight")
                    if esp and not h then
                        h = Instance.new("Highlight", pl.Character)
                        h.FillColor = Color3.new(1,0,0)
                        h.FillTransparency = 0.5
                        h.OutlineColor = Color3.new(1,0,0)
                        h.OutlineTransparency = 0
                        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    elseif not esp and h then
                        h:Destroy()
                    end
                end
            end
        end)
    end
end)

Rayfield:Notify({
    Title = "Murino horror",
    Content = "Скрипт успешно загружен!",
    Duration = 4,
})
