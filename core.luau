local module = {}

-- std
local stdio = require("@lune/stdio")
local task = require("@lune/task")
local process = require("@lune/process")

-- components
local save = require("./modules/save.luau")
local data = require("./modules/data.luau")

local ascii_art =                                                                                                                                       { {0x2588, 0x2588, 0x2588, 0x2557, 0x2591, 0x2591, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x2591, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x2591, 0x2588, 0x2588, 0x2557, 0x2591, 0x2591, 0x2588, 0x2588, 0x2557}, {0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x2591, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2550, 0x2550, 0x255D, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2550, 0x2550, 0x255D, 0x2591, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2588, 0x2588, 0x2557, 0x255A, 0x2550, 0x2550, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x255D, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2550, 0x2550, 0x255D, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2551, 0x2591, 0x2591, 0x2588, 0x2588, 0x2551}, {0x2588, 0x2588, 0x2554, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x2591, 0x2591, 0x2588, 0x2588, 0x2551, 0x2591, 0x2591, 0x2588, 0x2588, 0x2557, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2554, 0x255D, 0x2588, 0x2588, 0x2551, 0x2591, 0x2591, 0x2588, 0x2588, 0x2551, 0x2591, 0x2591, 0x2591, 0x2588, 0x2588, 0x2551, 0x2591, 0x2591, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x2591, 0x2591, 0x2588, 0x2588, 0x2551, 0x2591, 0x2591, 0x255A, 0x2550, 0x255D, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2551}, {0x2588, 0x2588, 0x2551, 0x255A, 0x2588, 0x2588, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x255D, 0x2591, 0x2591, 0x2588, 0x2588, 0x2551, 0x2591, 0x2591, 0x255A, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2551, 0x2591, 0x2591, 0x2588, 0x2588, 0x2551, 0x2591, 0x2591, 0x2591, 0x2588, 0x2588, 0x2551, 0x2591, 0x2591, 0x2591, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x255D, 0x2591, 0x2591, 0x2588, 0x2588, 0x2551, 0x2591, 0x2591, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2588, 0x2588, 0x2551}, {0x2588, 0x2588, 0x2551, 0x2591, 0x255A, 0x2588, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x255A, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2554, 0x255D, 0x2588, 0x2588, 0x2551, 0x2591, 0x2591, 0x2588, 0x2588, 0x2551, 0x255A, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2554, 0x255D, 0x2591, 0x2591, 0x2591, 0x2588, 0x2588, 0x2551, 0x2591, 0x2591, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x255A, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2554, 0x255D, 0x2588, 0x2588, 0x2551, 0x2591, 0x2591, 0x2588, 0x2588, 0x2551}, {0x255A, 0x2550, 0x255D, 0x2591, 0x2591, 0x255A, 0x2550, 0x2550, 0x255D, 0x255A, 0x2550, 0x2550, 0x2550, 0x2550, 0x2550, 0x2550, 0x255D, 0x2591, 0x255A, 0x2550, 0x2550, 0x2550, 0x2550, 0x2550, 0x255D, 0x2591, 0x255A, 0x2550, 0x255D, 0x2591, 0x2591, 0x255A, 0x2550, 0x255D, 0x2591, 0x255A, 0x2550, 0x2550, 0x2550, 0x2550, 0x255D, 0x2591, 0x2591, 0x2591, 0x2591, 0x255A, 0x2550, 0x255D, 0x2591, 0x2591, 0x2591, 0x255A, 0x2550, 0x2550, 0x2550, 0x2550, 0x2550, 0x2550, 0x255D, 0x2591, 0x255A, 0x2550, 0x2550, 0x2550, 0x2550, 0x255D, 0x2591, 0x255A, 0x2550, 0x255D, 0x2591, 0x2591, 0x255A, 0x2550, 0x255D} }
local dialogInstances = #data

local ongoing = false

function module.init(): number
    module.waterMark()
    save.ensureSave()

    -- start bij de laatst opgeslagen checkpoint
    local startAt = tonumber(save.readSave().checkPoint) or 1
    if startAt == 0 then
        module.typeWrite({
            "Game over.",
            "\n"
        })
    end

    -- klein wachtje voor het watermarkje of net dood was gegaan
    task.wait(3)

    -- als de speler al een keer is begonnen, vraag of hij verder wilt gaan
    if startAt > 1 and not ongoing then
        local confirmed = stdio.prompt("select", `Current save progression: {module.calculateProgress(startAt)}%`, { "Continue", "New Game" }) == 1
        if not confirmed then
            startAt = 1
        end
    end

    module.clearConsole()

    ongoing = true

    -- main loop
    for i = startAt, dialogInstances do
        local dialogData = data[i]

        -- simpele dialog
        if typeof(dialogData) == "string" then
            -- typeWrite functie is eigenlijk gemaakt voor meer dan 1 string, maar dit is een uitzondering
            -- string.format gebruik ik om de naam van de gebruiker te krijgen in data.luau

            module.typeWrite({
                string.format(dialogData, process.env["USERNAME"]:lower())
            })

        -- geavanceerde dialog
        elseif typeof(dialogData) == "table" then
            local options = {}
            for option, _ in dialogData.options do
                table.insert(options, option)
            end

            stdio.write("\n")

            -- selectie prompt van de runtime (GEEN EXTERNAL LIBRARY)
            local input = stdio.prompt("select", dialogData.dialog, options)
            local optionData = dialogData.options[options[input]]

            module.clearConsole()

            local printed = false

            -- deze actie vereist een item om in de inventory te hebben
            if optionData.required then
                local hasItem = save.hasItem(optionData.required)
                if hasItem then
                    module.typeWrite(optionData.messages[2])
                    save.addItem(optionData.required)

                    printed = true
                else
                    module.typeWrite(optionData.messages[1])
                end

            -- deze actie geeft een item aan de speler
            elseif optionData.item then
                if optionData.cannotSkip then
                    local hasItem = save.hasItem(optionData.item)

                    -- laat een generiek berichtje zien als de speler het item al heeft
                    if hasItem then
                        module.typeWrite(optionData.messages[2])
                    else
                        module.typeWrite(optionData.messages[1])

                        module.typeWrite({
                            `* Je hebt een {optionData.item} gevonden, +2 PorkCoin! *`
                        })
                        save.incrementPorkCoin(2)
                        save.addItem(optionData.item)
                    end
                -- ... hier is dat niet nodig met skippable items (speler komt maar 1x langs)
                else
                    module.typeWrite(optionData.messages)
                    save.addItem(optionData.item)
                end

                printed = true

            -- deze actie geeft een eind van het spel aan
            elseif optionData.ending then
                module.typeWrite(optionData.messages)

                local saveData = save.readSave()
                local gotEnding = table.find(saveData.endings, optionData.ending)

                if not gotEnding or gotEnding <= 0 then
                    -- voeg ending toe aan array, ook een porkcoin voor gokken
                    table.insert(saveData.endings, optionData.ending)
                    saveData.porkCoin += 5

                    module.typeWrite({
                        "\n",
                        `Je hebt het einde "{optionData.ending}" bereikt`,
                        "+5 PorkCoin! Sucess met gokken!"
                    })

                    task.wait(3)
                else
                    -- einde al bereikt, geen beloning
                    module.typeWrite({
                        "\n",
                        "Je hebt dit einde al bereikt"
                    })
                end

                -- reset belangrijke informatie
                saveData.checkPoint = 1
                saveData.inventory = {}

                save.writeSave(saveData)
                return 0
            end

            -- geen bijzondere actie, print de array van messages
            if not printed then
                module.typeWrite(optionData)
                return i
            end

            -- blijkbaar was er bij deze actie een item nodig, omdat de gebruiker deze niet had, geef hem weer de kans om te kiezen
            if optionData.required and not save.hasItem(optionData.required) then
                return i
            end
        end

        task.wait(1)

        -- save progressie
        local saveData = save.readSave()
        saveData.checkPoint = i

        save.writeSave(saveData)
    end

    return 1
end

-- de linter deze walgelijke string laten toestaan
-- selene: allow(bad_string_escape)
function module.clearConsole()
    stdio.write("\x1b[2J\x1b[H")
end

function module.waterMark()    
    stdio.write(`{stdio.color("green")}\n`)
    
    for _, spaced in ascii_art do
        for _, character in spaced do
            stdio.write(utf8.char(character))
        end
    
        stdio.write("\n")
    end
    
    stdio.write(stdio.style("bold"))
    
    stdio.write("\n© 2025 NegroTech Egypt, (Inc, LLC, Corp). All rights reserved. \n\n")
    
    stdio.write(stdio.color("reset"))
    
    stdio.write("####################################################################\n\n")
    stdio.write(stdio.style("reset"))
end

function module.calculateProgress(progress: number): number
    return math.floor(progress / dialogInstances * 100)
end

function module.typeWrite(messages: { string })
    for _, text in messages do
        local characters = text:split("")
        local wordCount = #text:split(" ")
    
        local waitTime = 0.05
        local firstChar = string.sub(text, 1, 1)
    
        if firstChar == "." then
            waitTime = 0.5
        end
    
        if firstChar == "*" then
            stdio.write(`{stdio.color("red")}\n! {stdio.color("reset")}`)
        else
            stdio.write("> ")
        end
    
        for _, char in pairs(characters) do
            stdio.write(char)
            
            if char ~= " " then
                task.wait(waitTime)
            end
        end
    
        stdio.write("\n")
        task.wait(wordCount / 40)
    end
end

return module
