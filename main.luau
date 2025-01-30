local task = require("@lune/task")

local core = require("./core.luau")

local ok, err = pcall(function()
    core.waterMark()
    
    task.wait(3)
    core.init()
end)

if not ok then
    warn(`An fatal error occoured!\n\n{err}`)
end
