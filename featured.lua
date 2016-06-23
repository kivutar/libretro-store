local featured = {}
featured.__index = featured

function newFeatured()
	local n = {}

	n.list = {
		{ x = 255, y =   0, w = 480, h = 320, img = lutro.graphics.newImage("assets/dino.png") },
		{ x = 255, y = 325, w = 480, h = 170, img = lutro.graphics.newImage("assets/cs.png") },
		{ x = 740, y =   0, w = 480, h = 495, img = lutro.graphics.newImage("assets/sienna.png") },
	}

	n.cursor = 1

	return setmetatable(n, featured)
end

function featured:gamepadpressed(i, k)
	if k == "down" then
		if self.cursor == 1 then
			self.cursor = 2
		end
	elseif k == "up" then
		if self.cursor == 2 then
			self.cursor = 1
		end
	elseif k == "right" then
		self.cursor = 3
	elseif k == "left" then
		self.cursor = 1
	elseif k == "b" then
		focus = "categories"
	elseif k == "a" then
		table.insert(tweens, tween.new(0.5, c, { x = c.x - 1440 }, "outQuad"))
		page = "content"
	end
end

function featured:update(dt)
end

function featured:draw()
	for i,ni in ipairs(self.list) do
		if i == self.cursor then
			if focus == "featured" then
				lutro.graphics.setColor(glowing, glowing, glowing)
				lutro.graphics.rectangle("fill", ni.x + c.x - 1, ni.y + c.y - 1, ni.w + 2, ni.h + 2)
			end
			lutro.graphics.setColor(255, 166, 74)
		else
			lutro.graphics.setColor(230, 126, 34)
		end
		lutro.graphics.rectangle("fill", ni.x + c.x, ni.y + c.y, ni.w, ni.h)
		lutro.graphics.draw(ni.img, ni.x + c.x, ni.y + c.y)
	end
end


