require("vector")
require("mover")
require("attractor")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    
    G = 0.4

    local location = Vector:create(width / 2 + 100, height / 2)
    attractor = Attractor:create(location, 20)
    local location = Vector:create(50, height / 2)
    attractor1 = Attractor:create(location, 20)
    movers = {}
    for i = 1, 10 do
        local location = Vector:create(math.random(0, width),
            math.random(0, height))
        local velocity = Vector:create(0.1, 0.1)
        mover = Mover:create(location, velocity, 1)
        table.insert(movers, mover)
    end
    --local location = Vector:create(300, 350)
    --local velocity = Vector:create(0.1, 0.1)
    --mover = Mover:create(location, velocity, 1)
end

function love.update()
    for i = 1, 10 do
        movers[i]:update()
        for j = 1, 10 do
            if movers[i] ~= movers[j] then
                movers[i]:attract(movers[j])
            end
        end
        movers[i]:checkBoundaries()
    end
    --attractor:attract(mover)
    --attractor1:attract(mover)
    --mover:update()
end

function love.draw()
    for i = 1, 10 do
        movers[i]:draw()
    end
    --mover:draw()
    --attractor:draw()
    --attractor1:draw()
end