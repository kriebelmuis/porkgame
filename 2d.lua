local renderer = {}

local stdio = require("@lune/stdio")
local task = require("@lune/task")

type Entity = {
    position: { number },
    symbol: string
}

local entities = {
    {
        position = { 10, 5 },
        symbol = "A"
    },
    {
        position = { 15, 8 },
        symbol = "B"
    },
    {
        position = { 30, 12 },
        symbol = "C"
    },
    {
        position = { 25, 10 },
        symbol = "X"
    }
}

local sizeX = 50
local sizeY = 20

local frameDuration = 1 / 120
local frames = 0
local fps = 0

function renderer.moveEntity(entity: Entity, x: number, y: number)
    entity.position[1] = x
    entity.position[2] = y
end

function renderer.init()
    task.spawn(function()
        while true do
            fps = frames
            frames = 0

            task.wait(1)
        end
    end)

    while true do
        for _, entity in entities do
            local direction = math.random(1, 4)

            local x = entity.position[1]
            local y = entity.position[2]

            if direction == 1 then
                x += 1
            elseif direction == 2 then
                y += 1
            elseif direction == 3 then
                x -= 1
            elseif direction == 4 then
                y -= 1
            end

            renderer.moveEntity(entity, x, y)
        end

        local start = os.clock()

        local entityPositions = {}
        for _, entity in ipairs(entities) do
            entityPositions[`{entity.position[1]},{entity.position[2]}`] = entity.symbol
        end

        local outputBuffer = {}

        for y = 1, sizeY do
            for x = 1, sizeX do
                local key = `{x},{y}`
                if entityPositions[key] then
                    table.insert(outputBuffer, entityPositions[key])
                else
                    table.insert(outputBuffer, " ")
                end
            end
            table.insert(outputBuffer, "\n")
        end

        stdio.write(table.concat(outputBuffer))
        frames += 1

        local sleepTime = frameDuration - (os.clock() - start)
        if sleepTime > 0 then
            task.wait(sleepTime)
        end
        
        stdio.write(`{fps} fps`)
    end
end

renderer.init()

return renderer
