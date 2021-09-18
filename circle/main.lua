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
end

function love.draw()
	mover:draw()
end
