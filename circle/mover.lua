Mover = {}
Mover.__index = Mover

function Mover:create(x,y)
	local mover = {}
	setmetatable(mover, Mover)
	mover.location = location
	mover.velocity = velocity
	return mover
end

function Mover:draw()
	love.graphics.circle("fill", self.location.x, self.location.y, 20)
end
