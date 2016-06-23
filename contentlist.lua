local contentlist = {}
contentlist.__index = contentlist

function newContentlist()
	local n = {}

	n.list = {
		{ x = 255, w = 965, h = 224, img = lutro.graphics.newImage("assets/sonic1.png") },
		{ x = 255, w = 965, h = 224, img = lutro.graphics.newImage("assets/sonic2.png") },
		{ x = 255, w = 965, h = 224, img = lutro.graphics.newImage("assets/sonic3.png") },
		{ x = 255, w = 965, h = 224, img = lutro.graphics.newImage("assets/sonic1.png") },
		{ x = 255, w = 965, h = 224, img = lutro.graphics.newImage("assets/sonic2.png") },
		{ x = 255, w = 965, h = 224, img = lutro.graphics.newImage("assets/sonic3.png") },
	}

	n.y = 0

	n.cursor = 1

	return setmetatable(n, contentlist)
end

function contentlist:gamepadpressed(i, k)
	if k == "down" then
		if self.cursor < #self.list then
			self.cursor = self.cursor + 1
			if self.cursor ~= #self.list then
				table.insert(tweens, tween.new(0.5, self, { y = (-self.cursor+1)*229 }, "outQuad"))
			end
		end
	elseif k == "up" then
		if self.cursor > 1 then
			self.cursor = self.cursor - 1
			table.insert(tweens, tween.new(0.5, self, { y = (-self.cursor+1)*229 }, "outQuad"))
		end
	elseif k == "b" then
		focus = "categories"
	elseif k == "a" then
		table.insert(tweens, tween.new(0.5, c, { x = c.x - 1440 }, "outQuad"))
		page = "content"
	end
end

function contentlist:update(dt)
end

function contentlist:draw()
	for i,ni in ipairs(self.list) do
		if i == self.cursor then
			if focus == "contentlist" then
				lutro.graphics.setColor(glowing, glowing, glowing)
				lutro.graphics.rectangle("fill", ni.x + c.x - 1, 229*(i-1) + c.y - 1 + self.y, ni.w + 2, ni.h + 2)
			end
			lutro.graphics.setColor(43, 61, 81)
		else
			lutro.graphics.setColor(3, 21, 41)
		end
		lutro.graphics.rectangle("fill", ni.x + c.x, 229*(i-1) + c.y + self.y, ni.w, ni.h)
		lutro.graphics.draw(ni.img, ni.x + c.x, 229*(i-1) + c.y + self.y)
	end
end


