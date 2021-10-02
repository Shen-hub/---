require("vector")
require("mover")
require("liquid")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    
    love.graphics.setBackgroundColor(128 / 255, 
                                     128 / 255, 
                                     128 / 255)
    location = Vector:create(width * 0.25, height / 4)
    velocity = Vector:create(0, 0.1)
    mover = Mover:create(location, velocity, 1, {0.5, 0.0, 0.0})
    wlocation = Vector:create(width * 0.75, height / 4)
    wmover = Mover:create(wlocation, velocity, 1, {0.0, 0.5, 0.0})

    
    gravity = Vector:create(0, 0.01)
    liquid = Liquid:create(0, height - height / 4, 400, 300)

end

function love.update()
    mover:applyForce(gravity)
    wmover:applyForce(gravity)

    if liquid:isInside(mover) then
        mag = mover.velocity:mag()
        drag = 0.6 * mag * mag
        --print(mover.velocity:mag())
        dragVec = (mover.velocity * -1):norm()
        dragVec:mul(drag)
        mover:applyForce(dragVec)
    end

    mover:update()
    mover:checkBoundaries()
    wmover:update()
    wmover:checkBoundaries()
end

function love.draw()
    local r, g, b, a = love.graphics.getColor()

    mover:draw()
    wmover:draw()
    liquid:draw()
    love.graphics.print(tostring(mover.velocity),
                                 mover.location.x + mover.size,
                                 mover.location.y)
    love.graphics.print(tostring(wmover.velocity),
                                 wmover.location.x + wmover.size,
                                 wmover.location.y)
    love.graphics.print("w: " .. tostring(isWind) ..
                        " g: " .. tostring(isGravity) ..
                        " f: " .. tostring(isFloating))
end

function love.keypressed(key)
    if key == 'g' then
        isGravity = not isGravity
    end
    if key == 'f' then
        isFloating = not isFloating
    end
    if key == 'w' then
        isWind = not isWind
        if isWind then
            wind = wind * -1
        end
    end
end