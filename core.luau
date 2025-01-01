local module = {}

-- std
local stdio = require("@lune/stdio")
local task = require("@lune/task")
local fs = require("@lune/fs")
local luau = require("@lune/luau")

local data = require("data.luau")

function module.init(startAt: number)
    for i = startAt, #data do
        local dialogData = data[i]

        if typeof(dialogData) == "string" then
            stdio.prompt("text", dialogData)
        elseif typeof(dialogData) == "table" then
            local flag = false
            local options = {}

            for option, messages in pairs(dialogData.options) do
                table.insert(options, option)
            end

            local input = stdio.prompt("select", dialogData.dialog, options)
            local optionData = dialogData.options[options[input]]

            if optionData.flag then
                flag = true
            end

            if optionData.required then
                local hasItem = module.hasItem(optionData.required)
                if hasItem then
                    for i, message in pairs(optionData.messages[2]) do
                        stdio.prompt("text", message)
                    end
                else
                    for i, message in pairs(optionData.messages[1]) do
                        stdio.prompt("text", message)
                    end
                end
            elseif optionData.item then
                local hasItem = module.hasItem(optionData.item)
                if hasItem then
                    for i, message in pairs(optionData.messages[2]) do
                        stdio.prompt("text", message)
                    end
                else
                    for i, message in pairs(optionData.messages[1]) do
                        stdio.prompt("text", message)
                    end
                end
            else
                for i, message in pairs(optionData) do
                    stdio.prompt("text", message)
                end
            end

            if not flag then
                module.init(i)
                return
            end
        end
    end
end

function module.writeInventory(inventory: { string })
    fs.writeFile("inventory.txt", table.concat(inventory, "&"))
end

function module.getInventory() : { string }
    return string.split(tostring(fs.readFile("inventory.txt")), "&")
end

function module.addItem(item: string)
    local inventory = module.getInventory()
    table.insert(inventory, item)
    module.writeInventory(inventory)
end

function module.removeItem(item: string)
    local inventory = module.getInventory()
    table.remove(inventory, table.find(inventory, item))
    module.writeInventory(inventory)
end

function module.hasItem(item: string)
    if table.find(module.getInventory(), item) <= 0 then
        return false
    else
        return true
    end
end

return module