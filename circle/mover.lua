Mover = {}
Mover.__index = Mover

function Mover:create(x,y)
	local mover = {}
	setmetatable(mover, Mover)
	mover.location = location
	mover.velocity = velocity
	mover.acceleration = Vector:create(0.0)
	return mover
end

function Mover:draw()
	love.graphics.circle("fill", self.location.x, self.location.y, 20)
end

function  Mover:update()
	self.velocity = self.velocity + self.acceleration
	self.location = self.location + self.velocity
end
