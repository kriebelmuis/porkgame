local task = require("@lune/task")

local core = require("./modules/core.luau")

local ok, err = pcall(function()
    core.waterMark()
    core.init()
end)

if not ok then
    warn(`An fatal error occoured!\n\n{err}`)
end
