require("vector")
require("mover")

function love.load()
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()
	love.graphics.setBackgroundColor(128 / 255,
		128/255,
		128/255)

	location = Vector:create(width/ 2, height/2)
	velocity = Vector:create(0,0)
	mover = Mover:create(location, velocity)
	wmover = Mover:create(location, velocity, 5)
	wmover.size = 30

	wind = Vector:create(0.01, 0)
	isWind = false
	gravity = Vector:create(0,0.01)
	isGravity = false
	floating = Vector:create(0,-0.02)
	isFloating = false
end

function love.update()
	if isGravity then
		mover:applyForce(gravity)
		wmover:applyForce(gravity)
	end
	if isWind then
		mover:applyForce(wind)
		wmover:applyForce(wind)
	end
	if isFloating then
		mover:applyForce(floating)
		wmover:applyForce(floating)
	end

	mover:update()
	wmover:update()
	mover:checkBoundaries()
	wmover:checkBoundaries()
end

function love.draw()
	mover:draw()
	wmover:draw()

	love.graphics.print(tostring(mover.velocity),
								mover.location.x + 20,
								mover.location.y)

	love.graphics.print(tostring(wmover.velocity),
								wmover.location.x + 20,
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
