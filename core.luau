local module = {}

-- std
local stdio = require("@lune/stdio")
local task = require("@lune/task")
local process = require("@lune/process")

-- components
local save = require("./modules/save.luau")
local data = require("./modules/data.luau")

local dialogInstances = #data

local saveFolder = `{process.env["LOCALAPPDATA"]}\\Hit Game Pork Life`
local saveFile = `{saveFolder}\\save.toml`

type SaveData = {
    inventory: { string },
    endings: { string },

    checkPoint: number,
    porkCoin: number
}

local DefaultSaveData = {
    inventory = {},
    endings = {},

    checkPoint = 1,
    porkCoin = 0
} :: SaveData

local ongoing = false

function module.init(startAt: number?): number
    save.ensureSave()

	if not startAt then
		-- start bij de laatst opgeslagen checkpoint
		startAt = tonumber(save.readSave().checkPoint) or 1
		if startAt == 0 then
			module.typeWrite({
				"\n",
				"Game over.",
				"\n",
			})
		end
	end

    -- als de speler al een keer is begonnen, vraag of hij verder wilt gaan
    if startAt > 1 and not ongoing then
        local confirmed = stdio.prompt("select", `Current save progression: {module.calculateProgress(startAt)}%`, { "Continue", "New Game" }) == 1
        if not confirmed then
            save.writeSave(DefaultSaveData)
            startAt = 1
        end
    end

    module.clearConsole()

    ongoing = true

    -- main loop
    for i = startAt, dialogInstances do
        module.handleAction(data[i])
        task.wait(1)

        -- save progressie
        local saveData = save.readSave()
        saveData.checkPoint = i

        save.writeSave(saveData)
    end

    return 1
end

function module.handleAction(dialogData, progress)
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
                    module.typeWrite(optionData.messages[1])
                    save.removeItem(optionData.required)

                    return -- item hebben we, in geval van ending action beendigen we de action handler
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

                if not gotEnding or gotEnding <= 0 then
                    -- voeg ending toe aan array, ook een porkcoin voor gokken
                    table.insert(saveData.endings, optionData.ending)
                    saveData.porkCoin += 5

                    module.typeWrite({
                        `Je hebt het einde "{optionData.ending}" bereikt`,
                        "+5 PorkCoin ontvangen voor nieuw eind."
                    })
                else
                    -- einde al bereikt, geen beloning
                    module.typeWrite({
                        "Je hebt dit einde al bereikt"
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
                return
            end
        end
end

-- de linter deze walgelijke string laten toestaan
-- selene: allow(bad_string_escape)
function module.clearConsole()
    -- stdio.write("\x1b[2J\x1b[H")
end

function module.waterMark()    
    stdio.write(`{stdio.color("green")}`)
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
