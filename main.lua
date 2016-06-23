local tween = require 'tween'
require 'categories'
require 'featured'

function lutro.conf(t)
	t.width  = 1440
	t.height = 900
end

function lutro.load()
	c = { x = 120, y = 900, vol = 0 }

	tweens = {}

	categories = newCategories()
	featured = newFeatured()

	bg = lutro.graphics.newImage("assets/bg.png")
	logo = lutro.graphics.newImage("assets/logo.png")
	title = lutro.graphics.newImage("assets/title.png")

	lutro.graphics.setBackgroundColor(44, 62, 80)
	font = lutro.graphics.newImageFont("assets/font.png",
		" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/")
	sofia = lutro.graphics.newImageFont("assets/sofia.png",
		" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")

	lutro.graphics.setFont(sofia)

	bgm   = lutro.audio.newSource("assets/bgmusic.wav")
	bgm:setVolume(c.vol)
	bgm:setLooping(true)
	hover = lutro.audio.newSource("assets/blip_click.wav")

	state = "categories"
	cur_y = 1

	table.insert(tweens, tween.new(0.5, c, { y = 270 }, "outQuad"))
	table.insert(tweens, tween.new(10, c, { vol = 0.5 }, "outQuad"))

	lutro.audio.play(bgm)
end

function lutro.gamepadpressed(i, k)
	if state == "categories" then
		categories:gamepadpressed(i, k)
	elseif state == "featured" then
		featured:gamepadpressed(i, k)
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

	categories:draw()
	featured:draw()
end
