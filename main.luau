local core = require("core.luau")

local last = 1

repeat
    last = core.init(last)
until false