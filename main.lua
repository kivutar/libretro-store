local tween = require 'tween'

function lutro.conf(t)
	t.width  = 1440
	t.height = 900
end

function lutro.load()
	c = { x = 120, y = 900, vol = 0 }

	tweens = {}

	zones = {
		nav = {
			{ x = 0, y =   0, w = 250, h = 45, r = 41, g = 128, b = 185, },
			{ x = 0, y =  50, w = 250, h = 45, r = 41, g = 128, b = 185, },
			{ x = 0, y = 100, w = 250, h = 45, r = 41, g = 128, b = 185, },
			{ x = 0, y = 150, w = 250, h = 45, r = 41, g = 128, b = 185, },
			{ x = 0, y = 200, w = 250, h = 45, r = 41, g = 128, b = 185, },
			{ x = 0, y = 250, w = 250, h = 45, r = 41, g = 128, b = 185, },
			{ x = 0, y = 300, w = 250, h = 45, r = 41, g = 128, b = 185, },
			{ x = 0, y = 350, w = 250, h = 45, r = 41, g = 128, b = 185, },
			{ x = 0, y = 400, w = 250, h = 45, r = 41, g = 128, b = 185, },
			{ x = 0, y = 450, w = 250, h = 45, r = 41, g = 128, b = 185, },
		},
		content = {
			{ x = 255, y =   0, w = 480, h = 320, img = lutro.graphics.newImage("assets/dino.png") },
			{ x = 255, y = 325, w = 480, h = 170, img = lutro.graphics.newImage("assets/cs.png") },
			{ x = 740, y =   0, w = 480, h = 495, img = lutro.graphics.newImage("assets/sienna.png") },

		}
	}

	bg = lutro.graphics.newImage("assets/bg.png")
	logo = lutro.graphics.newImage("assets/logo.png")
	title = lutro.graphics.newImage("assets/title.png")

	lutro.graphics.setBackgroundColor(44, 62, 80)
	font = lutro.graphics.newImageFont("assets/font.png",
		" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/")
	lutro.graphics.setFont(font)

	bgm   = lutro.audio.newSource("assets/bgmusic.wav")
	bgm:setVolume(c.vol)
	bgm:setLooping(true)
	hover = lutro.audio.newSource("assets/blip_click.wav")

	cur_col = zones.nav
	cur_y = 1

	table.insert(tweens, tween.new(0.5, c, { y = 270 }, "outQuad"))
	table.insert(tweens, tween.new(10, c, { vol = 0.5 }, "outQuad"))

	lutro.audio.play(bgm)
end

function lutro.gamepadpressed(i, k)
	if k == "down" then
		if cur_y < #cur_col then
			cur_y = cur_y + 1
			--lutro.audio.play(hover)
		end
	elseif k == "up" then
		if (cur_y > 1) then
			cur_y = cur_y - 1
			--lutro.audio.play(hover)
		end
	elseif k == "right" then
		if cur_col == zones.nav then
			cur_y = 1
			cur_col = zones.content
			--lutro.audio.play(hover)
		end
	elseif k == "left" then
		if cur_col == zones.content then
			cur_y = 1
			cur_col = zones.nav
			--lutro.audio.play(hover)
		end
	elseif k == "a" then

	end
end

function lutro.gamepadreleased(i, k)

end

function lutro.update(dt)
	for _,t in ipairs(tweens) do
		t:update(dt)
	end

	bgm:setVolume(c.vol)
end

function lutro.draw()
	lutro.graphics.clear()
	lutro.graphics.draw(bg, 0, 0)

	lutro.graphics.draw(logo, c.x, c.y - 100)
	lutro.graphics.draw(title, c.x + 60, c.y - 91)

	for i,ni in ipairs(zones.nav) do
		if cur_col == zones.nav and i == cur_y then
			lutro.graphics.setColor(255, 255, 255)
			lutro.graphics.rectangle("fill", ni.x + c.x - 1, ni.y + c.y - 1, ni.w + 2, ni.h + 2)
			lutro.graphics.setColor(ni.r + 40, ni.g + 40, ni.b + 40)
		else
			lutro.graphics.setColor(ni.r, ni.g, ni.b)
		end
		lutro.graphics.rectangle("fill", ni.x + c.x, ni.y + c.y, ni.w, ni.h)
	end

	for j,ci in ipairs(zones.content) do
		if cur_col == zones.content and j == cur_y then
			lutro.graphics.setColor(255, 255, 255)
			lutro.graphics.rectangle("fill", ci.x + c.x - 1, ci.y + c.y - 1, ci.w + 2, ci.h + 2)
			lutro.graphics.setColor(255, 166, 74)
		else
			lutro.graphics.setColor(230, 126, 34)
		end
		lutro.graphics.rectangle("fill", ci.x + c.x, ci.y + c.y, ci.w, ci.h)
		lutro.graphics.draw(ci.img, ci.x + c.x, ci.y + c.y)
	end

	--lutro.graphics.print("Hello world!", 3, 1)
end
