Liquid = {}
Liquid.__index = Liquid
function Liquid:create(x,y,w,h)
	local liquid = {}
	setmetatable(liquid, Liquid)
	liquid.x = x
	liquid.y = y
	liquid.w = w
	liquid.h = h
	return liquid
end

function Liquid:isInside(objects)
	local xc = objects.location.x
	local yc = objects.location.y
	if (xc > self.x and xc < self.x + self.w and
		yc > self.y and yc < self.y + self.h) then
			return true
	end
	return false
end

function  Liquid:draw()
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0, 119/255, 100/255, 0.5)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
	love.graphics.setColor(r, g, b, a)

end