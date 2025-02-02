local task = require("@lune/task")
local stdio = require("@lune/stdio")

local save = require("./modules/save.luau")
local core = require("./modules/core.luau")
local data = require("./modules/data.luau")

local dialogInstances = #data

local DefaultSaveData = {
    inventory = {},
    endings = {},

    checkPoint = 1,
    porkCoin = 0
} :: core.SaveData

-- berekent procentage van de progressie
local function calculateProgress(progress: number): number
    return math.floor(progress / dialogInstances * 100)
end

local ok, err = pcall(function()
    save.ensureSave()
    core.waterMark()

    local checkPoint = tonumber(save.readSave().checkPoint) or 1

    local confirmed = stdio.prompt("select", `Current save progression: {calculateProgress(checkPoint)}%`, { "Continue", "New Game" }) == 1
    if not confirmed then
        save.writeSave(DefaultSaveData)
        core.init(1)
    end

    core.init(checkPoint)
end)

if not ok then
    warn(`An fatal error occoured!\n\n{err}`)
end
