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

                        task.wait(.5)
                    end
                else
                    for i, message in pairs(optionData.messages[1]) do
                        stdio.prompt("text", message)

                        task.wait(.5)
                    end
                end
            elseif optionData.item then
                for i, message in pairs(optionData.messages) do
                    stdio.prompt("text", message)

                    task.wait(.5)
                end

                module.addItem(optionData.item)
            else
                for i, message in pairs(optionData) do
                    stdio.prompt("text", message)

                    task.wait(.5)
                end
            end

            if not flag then
                module.init(i)
                return
            end
        end

        task.wait(.5)
    end
end

function module.getInventory()
    local bytecode = luau.compile(`return {tostring(fs.readFile("inventory"))}`)
    local fun = luau.load(bytecode)

    return fun()
end

function module.addItem(item: string)
    local inventory = module.getInventory()

    stdio.prompt("text", `jij vond een {item}`)
    table.insert(inventory, item)

    fs.writeFile("inventory", tostring(inventory))
end

function module.removeItem(item: string)
    local inventory = module.getInventory()

    stdio.prompt("text", `{item} gebruikt`)
    table.remove(inventory, table.find(inventory, item))

    fs.writeFile("inventory", tostring(inventory))
end

function module.hasItem(item: string)
    local inventory = fs.readFile("inventory.luau") :: { string }

    return table.find(inventory, item) and true or false
end

return module