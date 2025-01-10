local core = require("./core.luau")

local ok, err = pcall(function()
    core.init()
end)

if not ok then
    warn(`An fatal error occoured!\n\n{err}`)
end
