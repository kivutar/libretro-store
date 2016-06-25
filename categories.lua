local categories = {}
categories.__index = categories

function newCategories()
	local n = {}

	n.list = {
		{ x = 0, w = 250, h = 45, r = 41, g = 128, b = 185, lbl = "Featured Content" },
		{ x = 0, w = 250, h = 45, r = 41, g = 128, b = 185, lbl = "NES Homebrews" },
		{ x = 0, w = 250, h = 45, r = 41, g = 128, b = 185, lbl = "Indie Games" },
		{ x = 0, w = 250, h = 45, r = 41, g = 128, b = 185, lbl = "Demo" },
		{ x = 0, w = 250, h = 45, r = 41, g = 128, b = 185, lbl = "Atari 2600 Homebrews" },
		{ x = 0, w = 250, h = 45, r = 41, g = 128, b = 185, lbl = "SNES Homebrews" },
		{ x = 0, w = 250, h = 45, r = 41, g = 128, b = 185, lbl = "GBA Homebrews" },
		{ x = 0, w = 250, h = 45, r = 41, g = 128, b = 185, lbl = "PSP Homebrews" },
		{ x = 0, w = 250, h = 45, r = 41, g = 128, b = 185, lbl = "Music" },
	}

	n.cursor = 1

	return setmetatable(n, categories)
end

function categories:gamepadpressed(i, k)
	if k == "down" then
		if self.cursor < #self.list then
			self.cursor = self.cursor + 1
			--lutro.audio.play(hover)
		end
	elseif k == "up" then
		if (self.cursor > 1) then
			self.cursor = self.cursor - 1
			--lutro.audio.play(hover)
		end
	elseif k == "a" then
		if self.cursor == 1 then
			subpage = "featured"
			focus = "featured"
		elseif self.cursor == 2 then
			subpage = "contentlist"
			focus = "contentlist"
		end
	end
end

function categories:update(dt)
end

function categories:draw()
	for i,ni in ipairs(self.list) do
		if i == self.cursor then
			if focus == "categories" then
				lutro.graphics.setColor(glowing, glowing, glowing)
				lutro.graphics.rectangle("fill", ni.x + c.x - 1, (i-1)*50 + c.y - 1, ni.w + 2, ni.h + 2)
			end
			lutro.graphics.setColor(ni.r + 40, ni.g + 40, ni.b + 40)
		else
			lutro.graphics.setColor(ni.r, ni.g, ni.b)
		end
		lutro.graphics.rectangle("fill", ni.x + c.x, (i-1)*50 + c.y, ni.w, ni.h)
		lutro.graphics.print(ni.lbl, ni.x + c.x + 10, (i-1)*50 + c.y + 15)
	end
end


