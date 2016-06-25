if love ~= nil then
	lutro = love
end

tween = require 'tween'
require 'categories'
require 'featured'
require 'content'
require 'contentlist'
-- Include "conf.lua"
-- @see https://github.com/libretro/libretro-lutro/issues/67
require 'conf'

function lutro.load()
	c = { x = 120, y = 900, vol = 0 }

	tweens = {}

	categories = newCategories()
	featured = newFeatured()
	content = newContent()
	contentlist = newContentlist()

	bg = lutro.graphics.newImage("assets/bg.png")
	mask = lutro.graphics.newImage("assets/mask.png")
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

	page = "main"
	subpage = "featured"
	focus = "categories"
	cur_y = 1
	tm = 0.0
	glowing = 255

	table.insert(tweens, tween.new(0.5, c, { y = 270 }, "outQuad"))
	table.insert(tweens, tween.new(10, c, { vol = 0.5 }, "outQuad"))

	lutro.audio.play(bgm)
end

function lutro.gamepadpressed(i, k)
	tm = 0
	if page == "main" then
		if focus == "categories" then
			categories:gamepadpressed(i, k)
		elseif focus == "featured" then
			featured:gamepadpressed(i, k)
		elseif focus == "contentlist" then
			contentlist:gamepadpressed(i, k)
		end
	elseif page == "content" then
		content:gamepadpressed(i, k)
	end
end

function lutro.gamepadreleased(i, k)

end

function lutro.update(dt)
	tm = tm + 0.2
	glowing = (math.cos(tm)/2+0.5)*255;

	for _,t in ipairs(tweens) do
		t:update(dt)
	end

	bgm:setVolume(c.vol)
end

function lutro.draw()
	lutro.graphics.clear()
	lutro.graphics.draw(bg, 0, 0)

	categories:draw()
	if subpage == "featured" then
		featured:draw()
	elseif subpage == "contentlist" then
		contentlist:draw()
	end

	content:draw()

	lutro.graphics.draw(mask, 0, 0)
	lutro.graphics.draw(logo, c.x, c.y - 100)
	lutro.graphics.draw(title, c.x + 60, c.y - 91)
end
