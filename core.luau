local module = {}

-- std
local stdio = require("@lune/stdio")
local task = require("@lune/task")
local fs = require("@lune/fs")
local process = require("@lune/process")
local serde = require("@lune/serde")

local data = require("./data.luau")

local saveFile = "save.toml"

local DefaultSaveData = {
    inventory = {},
    endings = {},
    checkPoint = 1
} :: SaveData

type SaveData = {
    inventory: { string },
    endings: { string },
    checkPoint: number
}

local ongoing = false

function module.init(): number
    module.ensureSave()

    local startAt = tonumber(module.readSave().checkPoint) or 1

    if startAt == 0 then
        module.typeWrite({
            "Game over.",
            "\n"
        })
    end

    if startAt > 1 and not ongoing then
        local confirmed = stdio.prompt("select", `Current save progression: {module.calculateProgress(startAt)}%`, { "Continue", "New Game" }) == 1
        if not confirmed then
            startAt = 1
        end
    end

    ongoing = true

    for i = startAt, #data do
        local dialogData = data[i]

        if typeof(dialogData) == "string" then
            module.typeWrite({
                string.format(dialogData, process.env["USERNAME"]:lower())
            })
        elseif typeof(dialogData) == "table" then
            local options = {}
            for option, _ in dialogData.options do
                table.insert(options, option)
            end

            stdio.write("\n")

            local input = stdio.prompt("select", dialogData.dialog, options)
            local optionData = dialogData.options[options[input]]

            stdio.write("\n")

            local printed = false

            if optionData.required then
                local hasItem = module.hasItem(optionData.required)
                if hasItem then
                    module.typeWrite(optionData.messages[2])
                    module.addItem(optionData.required)

                    printed = true
                else
                    module.typeWrite(optionData.messages[1])
                end
            elseif optionData.item then
                if optionData.cannotSkip then
                    local hasItem = module.hasItem(optionData.item)
                    if hasItem then
                        module.typeWrite(optionData.messages[2])
                    else
                        module.typeWrite(optionData.messages[1])
                        module.addItem(optionData.item)
                    end
                else
                    module.typeWrite(optionData.messages)
                    module.addItem(optionData.item)
                end

                printed = true
            elseif optionData.ending then
                module.typeWrite(optionData.messages)

                local saveData = module.readSave()
                local gotEnding = table.find(saveData.endings, optionData.ending)

                if not gotEnding or gotEnding <= 0 then
                    table.insert(saveData.endings, optionData.ending)

                    module.typeWrite({
                        "\n",
                        `Je hebt het einde "{optionData.ending}" bereikt`
                    })
                else
                    module.typeWrite({
                        "\n",
                        "Je hebt dit einde al bereikt"
                    })
                end

                saveData.checkPoint = 1
                saveData.inventory = {}

                module.writeSave(saveData)
                return 0
            end

            if not printed then
                module.typeWrite(optionData)
            end

            if optionData.required and not module.hasItem(optionData.required) then
                warn"no item"
                return i
            end
        end

        task.wait(1)
        local saveData = module.readSave()
        saveData.checkPoint = i

        module.writeSave(saveData)
    end

    warn("Mogelijk foutje opgetreden")
    return 1
end

function module.ensureSave()
    if not fs.isFile(saveFile) then
        module.writeSave(DefaultSaveData)
    end
end

function module.calculateProgress(progress: number): number
    return math.floor(progress / #data * 100)
end

function module.typeWrite(messages: { string })
    for i, text in ipairs(messages) do
        local characters = text:split("")
        local wordCount = #text:split(" ")
    
        local waitTime = 0.05
        local firstChar = string.sub(text, 1, 1)
    
        if firstChar == "." then
            waitTime = 0.5
        end
    
        if firstChar == "*" then
            stdio.write("! ")
        else
            stdio.write("> ")
        end
    
        for i, char in pairs(characters) do
            stdio.write(char)
            
            if char ~= " " then
                task.wait(waitTime)
            end
        end
    
        stdio.write("\n")
        task.wait(wordCount / 40)
    end
end

function module.writeSave(save: SaveData)
    fs.writeFile(saveFile, serde.encode("toml", save))
end

function module.readSave(): SaveData
    return serde.decode("toml", fs.readFile(saveFile))
end

function module.addItem(item: string)
    local saveData = module.readSave()
    table.insert(saveData.inventory, item)
    module.writeSave(saveData)
end

function module.removeItem(item: string)
    local saveData = module.readSave()
    table.remove(saveData.inventory, table.find(saveData.inventory, item))
    module.writeSave(saveData)
end

function module.hasItem(item: string): boolean
    local found = table.find(module.readSave().inventory, item)

    if not found or found <= 0 then
        return false
    else
        return true
    end
end

return module