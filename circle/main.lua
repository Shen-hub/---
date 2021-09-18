require("vector")
require("mover")

--Задание. Добавить две области: с положительным трением и отрицательным.

function love.load()
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()
	love.graphics.setBackgroundColor(128 / 255,
		128/255,
		128/255)

	location = Vector:create(width/ 4, height/2)
	velocity = Vector:create(0,0)
	mover = Mover:create(location, velocity)
	wmover = Mover:create(location1, velocity)
	--wmover.size = 30

	wind = Vector:create(0.01, 0)
	isWind = false
	gravity = Vector:create(0,0.01)
	isGravity = false
	floating = Vector:create(0,-0.02)
	isFloating = false
end

function love.update()
	--if isGravity then
	--	mover:applyForce(gravity)
	--	wmover:applyForce(gravity)
	--end
	--if isWind then
	--	mover:applyForce(wind)
	--	wmover:applyForce(wind)
	--end
	--if isFloating then
	--	mover:applyForce(floating)
	--	wmover:applyForce(floating)
	--end

	--Другое
	mover:applyForce(gravity)
	wmover:applyForce(gravity)
	--mover:applyForce(wind)
	--wmover:applyForce(wind)
	if mover.location.x < width/2 then
		friction = (mover.velocity * -1):norm()
		if friction then
			friction:mul(0.005)
			mover:applyForce(friction)
		end
	end

	if mover.location.x > width/2 then
		friction = (mover.velocity):norm()
		if friction then
			friction:mul(0.005)
			wmover:applyForce(friction)
		end
	end

	mover:update()
	wmover:update()
	mover:checkBoundaries()
	wmover:checkBoundaries()
end

function love.draw()
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0, 119/255, 190/ 255, 0.5)
	love.graphics.rectangle("fill", width/2, 0, width/2, height)
	love.graphics.setColor(r,g,b,a)
	mover:draw()
	wmover:draw()

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
