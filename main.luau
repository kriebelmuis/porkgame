local core = require("core.luau")
local fs = require("@lune/fs")

local last = tonumber(fs.readFile("save/last.txt"))

repeat
    last = core.init(last)
until last == nil
