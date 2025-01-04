local module = {}

-- std
local stdio = require("@lune/stdio")
local task = require("@lune/task")
local fs = require("@lune/fs")
local process = require("@lune/process")

local data = require("data.luau")

local inventoryFile = "save/inventory.txt"

function module.init(startAt: number): number?
    if startAt ~= 1 then
        local confirmed = stdio.prompt("confirm", `Save found. Continue from last save? (Progression: {module.calculateProgress(startAt)}%)`, { "Yes", "No" })
        if not confirmed then
            startAt = 1
        end
    end

    for i = startAt, #data do
        local dialogData = data[i]

        if typeof(dialogData) == "string" then
            module.typeWrite(string.format(dialogData, process.env["USERNAME"]:lower()))
        elseif typeof(dialogData) == "table" then
            local options = {}

            for option, messages in pairs(dialogData.options) do
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
                    for i, message in pairs(optionData.messages[2]) do
                        module.typeWrite(message)
                    end

                    module.addItem(optionData.required)

                    printed = true
                else
                    for i, message in pairs(optionData.messages[1]) do
                        module.typeWrite(message)
                    end

                    if optionData.dead then
                        module.init(1)
                        return 1
                    end
                end
            elseif optionData.item then
                if optionData.cannotSkip then
                    local hasItem = module.hasItem(optionData.item)
                    if hasItem then
                        for i, message in pairs(optionData.messages[2]) do
                            module.typeWrite(message)
                        end
                    else
                        for i, message in pairs(optionData.messages[1]) do
                            module.typeWrite(message)
                        end
    
                        module.addItem(optionData.item)
                    end
                else
                    for i, message in pairs(optionData.messages) do
                        module.typeWrite(message)
                    end

                    module.addItem(optionData.item)
                end

                printed = true
            end
            
            if optionData.dead then
                for i, message in pairs(optionData.messages) do
                    module.typeWrite(message)
                end

                module.init(1)
                return 1
            end

            if not printed then
                for i, message in pairs(optionData) do
                    module.typeWrite(message)
                end
            end

            if not module.hasItem(optionData.required) then
                module.init(i)
                return i
            end
        end

        task.wait(1)
        fs.writeFile("save/last.txt", tostring(i))
    end

    return nil
end

function module.calculateProgress(progress: number): number
    return math.floor(progress / #data * 100)
end

function module.typeWrite(text: string)
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

function module.write(data: { string })
    warn("writing")
    fs.writeFile(inventoryFile, table.concat(data, "&"))
end

function module.read() : { string }
    warn("reading")
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