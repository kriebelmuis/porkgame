local module = {}

-- std
local stdio = require("@lune/stdio")
local task = require("@lune/task")
local process = require("@lune/process")

-- components
local save = require("./save.luau")
local data = require("./data.luau")
local items = require("./items.luau")

local dialogInstances = #data

export type SaveData = {
    inventory: { string },
    endings: { string },

    checkPoint: number,
    porkCoin: number
}

function module.init(startAt: number): number
    module.clearConsole()

    -- main loop
    for i = startAt, dialogInstances do
        local redo = module.handleAction(data[i])
        if redo then
            module.init(i - 1)
            return
        end

        task.wait(1)

        -- save progressie
        local saveData = save.readSave()
        saveData.checkPoint = i

        save.writeSave(saveData)
    end

    return 1
end

function module.handleAction(dialogData, progress): boolean
    -- simpele dialog
    if typeof(dialogData) == "string" then
        -- typeWrite functie is eigenlijk gemaakt voor meer dan 1 string, maar dit is een uitzondering
        -- string.format gebruik ik om de naam van de gebruiker te krijgen in data.luau

        module.typeWrite({
            string.format(dialogData, (process.env["USERNAME"] or process.env["USER"] or ""):lower()),
        })

    -- geavanceerde dialog
    elseif typeof(dialogData) == "table" then
        stdio.write("\n")

        -- lees inventory
        local inventory = save.readSave().inventory
        
        -- print inventory als we items hebben
        if #inventory ~= 0 then
            -- zet om in emojis doormiddel van items table
            for i, item in inventory do
                inventory[i] = items[item]
            end
            
            module.typeWrite({
                `🎒 Inventory: {table.concat(inventory, ", ")}`,
            })
        end

        stdio.write("\n")

        -- zet alle opties in een array
        local options = {}
        for option in dialogData.options do
            table.insert(options, option)
        end

        -- selectie prompt van de runtime (GEEN EXTERNAL LIBRARY)
        local input = stdio.prompt("select", dialogData.dialog, options)
        local optionData = dialogData.options[options[input]]

        module.clearConsole()

        local printed = false

        -- deze actie vereist een item om in de inventory te hebben
        if optionData.required then
            local hasItem = save.hasItem(optionData.required)
            if hasItem then
                module.typeWrite(optionData.messages[1])
                save.removeItem(optionData.required)

                return false -- item hebben we, in geval van nog een ending action beendigen we de action handler
            else
                module.typeWrite(optionData.messages[2])
                    
                -- niet herstarten als er een ending vast aan option zit,
                -- in dat geval is het een einde als je niet item heb
                if not optionData.ending then
                     module.init(progress)
                end
            end

            printed = true
        end

        -- deze actie geeft een item aan de speler
        if optionData.item then
            if not printed then
                module.typeWrite(optionData.messages)
            end

            save.addItem(optionData.item)

            printed = true
        end

        -- deze actie geeft een eind van het spel aan
        if optionData.ending then
            if not printed then
                module.typeWrite(optionData.messages)
            end

            local saveData = save.readSave()
            local gotEnding = table.find(saveData.endings, optionData.ending)

            stdio.write("\n")
            task.wait(3)

            -- als we voldoende porkcoins hebben, kunnen we ons reviven
            if saveData.porkCoin >= 5 then
                local revive = stdio.prompt("confirm", "Wil je 5 PorkCoins gebruiken om jezelf te reviven?")

                -- als we ja zeiden op de prompt, returnen we true zodat we de vorige actie opnieuw kunnen doen
                if revive then
                    saveData.porkCoin -= 5
                    save.writeSave(saveData)
                        
                    return true
                end
            end

            -- geef 5 porkcoins voor het bereiken van een nieuw einde
            if not gotEnding or gotEnding <= 0 then
                -- voeg ending toe aan array, ook een porkcoin voor gokken
                table.insert(saveData.endings, optionData.ending)
                saveData.porkCoin += 5

                module.typeWrite({
                    `Je hebt het einde "{optionData.ending}" bereikt`,
                    "+5 PorkCoin ontvangen voor nieuw eind."
                })
            end

            task.wait(3)

            -- reset belangrijke informatie
            saveData.checkPoint = 1
            saveData.inventory = {}

            save.writeSave(saveData)
            module.init(1)
        end

        -- geen bijzondere actie, print de array van messages
        if not printed then
            module.typeWrite(optionData)
        end

        -- blijkbaar was er bij deze actie een item nodig, omdat de gebruiker deze niet had, geef hem weer de kans om te kiezen
        if optionData.required and not save.hasItem(optionData.required) then
            module.init(progress)
            return false
        end
    end
end

-- de linter deze walgelijke string laten toestaan
-- selene: allow(bad_string_escape)
function module.clearConsole()
    stdio.write("\x1b[2J\x1b[H")
end

function module.waterMark()    
    stdio.write(`{stdio.color("green")}`)
    stdio.write(stdio.style("bold"))
    
    stdio.write("\n© 2025 NegroTech Egypt, (Inc, LLC, Corp). All rights reserved. \n\n")
    
    stdio.write(stdio.color("reset"))
    
    stdio.write("####################################################################\n\n")
    stdio.write(stdio.style("reset"))
end

-- typeWrite functie, simuleert het typen van tekst
function module.typeWrite(messages: { string })
    for _, text in messages do
        local characters = text:split("") -- split elke character doormiddel van een lege string
        local wordCount = #text:split(" ") -- split elke woord doormiddel van een spatie
    
        local waitTime = 0.05
        local firstChar = string.sub(text, 1, 1)
    
        -- als de string een ". . ." is, wacht dan 0.5 seconden voor elk puntje
        if firstChar == "." then
            waitTime = 0.5
        end
    
        -- als de eerste character een * is, print dan een rode uitroepteken voor tekst
        if firstChar == "*" then
            stdio.write(`{stdio.color("red")}\n! {stdio.color("reset")}`)
        else
            stdio.write("> ")
        end
    
        -- loop door de characters en print ze
        for _, char in pairs(characters) do
            stdio.write(char)
            
            -- niet wachten op spaties
            if char ~= " " then
                task.wait(waitTime)
            end
        end
    
        stdio.write("\n")
        task.wait(wordCount / 40)
    end
end

return module
