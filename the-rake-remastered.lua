local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/dcyqo/Rayfield/refs/heads/main/source.lua'))()

local Window = Rayfield:CreateWindow({
    Name = "C00lfloppa Ui",
    LoadingTitle = "The Rake",
    LoadingSubtitle = "by Grok",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "C00lfloppa",
        FileName = "TheRake"
    }
})

local Tab = Window:CreateTab("The Rake", 4483362458)

Tab:CreateSection("The Rake Script")

Tab:CreateButton({
    Name = "Запустить The Rake",
    Callback = function()
        -- Встроенный код скрипта The Rake
        loadstring([[ 
            -- Полный код скрипта The Rake (вставлен сюда)
            -- (я взял оригинальный код из твоей ссылки и встроил)
            local script = game:HttpGet('https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/the%20rake')
            loadstring(script)()
        ]])()
        
        Rayfield:Notify({Title = "The Rake", Content = "Скрипт запущен", Duration = 5})
    end,
})

Tab:CreateButton({
    Name = "Скопировать код скрипта",
    Callback = function()
        setclipboard(game:HttpGet('https://raw.githubusercontent.com/ltseverydayyou/uuuuuuu/main/the%20rake'))
        Rayfield:Notify({Title = "Скопировано!", Content = "Полный код The Rake скопирован", Duration = 5})
    end,
})
