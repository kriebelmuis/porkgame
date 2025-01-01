local module = {}

-- std
local stdio = require("@lune/stdio")
local task = require("@lune/task")
local fs = require("@lune/fs")

local data = require("data.luau")

function module.init()
    for i, dialogData in pairs(data) do
        if typeof(dialogData) == "string" then
            stdio.prompt("text", dialogData)
        elseif typeof(dialogData) == "table" then
            local options = {}

            for i, option in pairs(dialogData.options) do
                table.insert(options, option.option)
            end

            local input = stdio.prompt("select", dialogData.dialog, options)
            warn(options)
        end

        task.wait(.5)
    end
end

function module.addItem(item: string)
    stdio.prompt("text", `jij vond een {item}`)
    table.insert(data, item)

    fs.writeFile("inventory.luau", data)
end

function module.removeItem(item: string)
    local inventory = fs.readFile("inventory.luau") :: { string }

    stdio.prompt("text", `{item} gebruikt`)
    table.remove(inventory, table.find(inventory, item))

    fs.writeFile("inventory.luau", inventory)
end

return module