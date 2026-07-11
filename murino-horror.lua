local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/dcyqo/Rayfield/refs/heads/main/source.lua'))()

local Window = Rayfield:CreateWindow({
    Name = "Мурино Хоррор V1.2",
    LoadingTitle = "Мурино Хоррор",
    LoadingSubtitle = "by Grok",
    ConfigurationSaving = {
        Enabled = false,
    },
})

-- ==================== ОСНОВНОЕ ====================
local TabMain = Window:CreateTab("Основное", 4483362458)

TabMain:CreateParagraph({ Title = "ЙОУ😎", Content = "Привет, Друн!\n\nЯ очень благодарен тебе за использование моего скрипта." })
TabMain:CreateParagraph({ Title = "ПРАВИЛА СОГЛАШЕНИЯ", Content = "ЗАПУСКАЯ СКРИПТ ВЫ АВТОМАТИЧЕСКИ СОГЛАШАЕТЕСЬ С ПРАВИЛАМИ..." })
TabMain:CreateParagraph({ Title = "ОБНОВЛЕНИЯ", Content = "Все обновления скрипта будут выходить в Discord сервере." })
TabMain:CreateParagraph({ Title = "❔ВЕРСИЯ", Content = "v0.6 | Alpha script" })
TabMain:CreateLabel("✓ – Значит полностью рабочий.\n× – Значит неполностью/полностью нерабочий")

TabMain:CreateButton({
    Name = "Discord Server",
    Callback = function()
        setclipboard("https://discord.gg/VbwR3pmNAb")
        Rayfield:Notify({
            Title = "Discord",
            Content = "Ссылка скопирована в буфер обмена!",
            Duration = 5
        })
    end
})

-- ==================== ГЛАВНОЕ ====================
local MainTab = Window:CreateTab("Главное", 4483362458)

-- Переменные
local spd = false
local esp = false

-- ==================== СПИДРАНЕР ====================
local SpeedToggle = MainTab:CreateToggle({
    Name = "Спидранер",
    CurrentValue = false,
    Flag = "SpeedToggle",
    Callback = function(Value)
        spd = Value
        Rayfield:Notify({
            Title = "Спидранер",
            Content = spd and "Включён (50 скорости)" or "Выключен",
            Duration = 2,
        })
    end,
})

-- ==================== ESP ====================
local ESPToggle = MainTab:CreateToggle({
    Name = "Ребята я вас вижу",
    CurrentValue = false,
    Flag = "ESPToggle",
    Callback = function(Value)
        esp = Value
        Rayfield:Notify({
            Title = "ESP",
            Content = esp and "Включён" or "Выключен",
            Duration = 2,
        })
    end,
})

-- ==================== НОЧНОЕ ЗРЕНИЕ ====================
MainTab:CreateButton({
    Name = "Зелье ночного зрения (в разработке)",
    Callback = function()
        Rayfield:Notify({
            Title = "В разработке",
            Content = "Зелье ночного зрения пока не готово",
            Duration = 3,
        })
    end,
})

-- ==================== Логика Спидранер ====================
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

-- ==================== Логика ESP ====================
task.spawn(function()
    while task.wait(1.5) do
        pcall(function()
            for _, pl in pairs(game:GetService("Players"):GetPlayers()) do
                if pl \~= game.Players.LocalPlayer and pl.Character then
                    local highlight = pl.Character:FindFirstChild("Highlight")
                    
                    if esp and not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "Highlight"
                        highlight.FillColor = Color3.new(1, 0, 0)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineColor = Color3.new(1, 0, 0)
                        highlight.OutlineTransparency = 0
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.Parent = pl.Character
                    elseif not esp and highlight then
                        highlight:Destroy()
                    end
                end
            end
        end)
    end
end)

Rayfield:Notify({
    Title = "Мурино Хоррор V1.2",
    Content = "Скрипт успешно загружен!",
    Duration = 4,
})
