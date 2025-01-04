local module = {}

-- std
local stdio = require("@lune/stdio")
local task = require("@lune/task")
local fs = require("@lune/fs")
local process = require("@lune/process")

local data = require("data.luau")

local inventoryFile = "save/inventory.txt"
local progressFile = "save/last.txt"

local ongoing = false

function module.init(): number
    module.ensureSave()

    local startAt = tonumber(fs.readFile(progressFile))

    if startAt == 0 then
        module.typeWrite({
            "Game over.",
            "\n"
        })
    end

    if startAt > 1 and not ongoing then
        local confirmed = stdio.prompt("confirm", `Save found. Continue from last save? (Progression: {module.calculateProgress(startAt)}%)`, { "Yes", "Restart" })
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
                module.typeWrite({
                    "\n",
                    `Je heb een nieuw eind bereikt: {optionData.ending}!`
                })

                module.resetSave()
                return 0
            end

            if not printed then
                module.typeWrite(optionData)
            end

            if optionData.required and not module.hasItem(optionData.required) then
                return i
            end
        end

        task.wait(1)
        fs.writeFile(progressFile, tostring(i))
    end

    warn("Mogelijk foutje opgetreden")
    return 1
end

function module.resetSave()
    fs.writeFile(progressFile, "0")
    fs.writeFile(inventoryFile, "")
end

function module.ensureSave()
    if not fs.isDir("save") then
        fs.writeDir("save")
    end

    if not fs.isFile(inventoryFile) then
        fs.writeFile(inventoryFile, "")
    end

    if not fs.isFile(progressFile) then
        fs.writeFile(progressFile, "1")
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

function module.write(data: { string })
    fs.writeFile(inventoryFile, table.concat(data, "&"))
end

function module.read() : { string }
    return string.split(tostring(fs.readFile(inventoryFile)), "&")
end

function module.addItem(item: string)
    local inventory = module.read()
    table.insert(inventory, item)
    module.write(inventory)
end

function module.removeItem(item: string)
    local inventory = module.read()
    table.remove(inventory, table.find(inventory, item))
    module.write(inventory)
end

function module.hasItem(item: string)
    local found = table.find(module.read(), item)

    if not found or found <= 0 then
        return false
    else
        return true
    end
end

return module