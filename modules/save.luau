local SaveModule = {}

local serde = require("@lune/serde")
local fs = require("@lune/fs")
local process = require("@lune/process")

local saveFolder = "./data"
local saveFile = `{saveFolder}/save.toml`

export type SaveData = {
    inventory: { string },
    endings: { string },

    checkPoint: number,
    porkCoin: number
}

local DefaultSaveData = {
    inventory = {},
    endings = {},

    checkPoint = 1,
    porkCoin = 1
} :: SaveData

function SaveModule.ensureSave()
    if not fs.isDir(saveFolder) then
        fs.writeDir(saveFolder)
    end

    if not fs.isFile(saveFile) then
        SaveModule.writeSave(DefaultSaveData)
    end
    
    SaveModule.reconcile()
end

function SaveModule.reconcile()
    local saveData = SaveModule.readSave()

    for key, value in pairs(DefaultSaveData) do
        if saveData[key] == nil then
            saveData[key] = value
        end
    end

    SaveModule.writeSave(saveData)
end

function SaveModule.writeSave(save: SaveData): boolean
    local ok = pcall(function()
        fs.writeFile(saveFile, serde.encode("toml", save))
    end)

    if not ok then
        warn("Failed to write save!")

        task.wait(1)
        return SaveModule.writeSave(DefaultSaveData)
    end

    return true
end

function SaveModule.readSave(): SaveData
    return serde.decode("toml", fs.readFile(saveFile))
end

function SaveModule.incrementPorkCoin(amount: number)
    local saveData = SaveModule.readSave()
    saveData.porkCoin += amount
    SaveModule.writeSave(saveData)
end

function SaveModule.decrementPorkCoin(amount: number)
    local saveData = SaveModule.readSave()
    saveData.porkCoin -= amount
    SaveModule.writeSave(saveData)
end

function SaveModule.addItem(item: string)
    local saveData = SaveModule.readSave()
    table.insert(saveData.inventory, item)
    SaveModule.writeSave(saveData)
end

function SaveModule.removeItem(item: string)
    local saveData = SaveModule.readSave()
    table.remove(saveData.inventory, table.find(saveData.inventory, item))
    SaveModule.writeSave(saveData)
end

function SaveModule.hasItem(item: string): boolean
    local found = table.find(SaveModule.readSave().inventory, item)

    if not found or found <= 0 then
        return false
    else
        return true
    end
end

return SaveModule