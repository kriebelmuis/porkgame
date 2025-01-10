local gamble = {}

local stdio = require("@lune/stdio")

local symbols = {
    "7",
    "Bar", 
    "Cherry",
    "Lemon",
    "Orange"
}

local symbolCount = #symbols

function gamble.init()
    while true do
        local reels = {
            math.random(1, symbolCount),
            math.random(1, symbolCount),
            math.random(1, symbolCount)
        }

        for i, reel in reels do
            stdio.write(symbols[reel])

            if i == 2 or i == 1 then
                stdio.write(" | ")
            end
        end

        stdio.write("\n")

        local ok = stdio.prompt("select", "Choose", { "Spin", "Exit" }) == 1

        stdio.write("\x1b[2J\x1b[H") -- clear term
        if not ok then
            break
        end
    end
end

return gamble