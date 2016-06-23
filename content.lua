local content = {}
content.__index = content

function newContent()
	local n = {}

	n.cursor = 1

	return setmetatable(n, content)
end

function content:gamepadpressed(i, k)
	if k == "b" then
		table.insert(tweens, tween.new(0.5, c, { x = c.x + 1440 }, "outQuad"))
		page = "main"
		focus = subpage
	end
end

function content:update(dt)
end

function content:draw()
	lutro.graphics.setColor(255, 255, 255)
	lutro.graphics.rectangle("fill", c.x + 1440, c.y, 320, 240)
	lutro.graphics.rectangle("fill", c.x + 1440, c.y + 245, 320, 240)

	lutro.graphics.print("Dinothawr is a block pushing puzzle game on slippery surfaces. \
	Our hero is a dinosaur whose friends are trapped in ice. \
	Through puzzles it is your task to free the dinos from their ice prison.", c.x + 1440 + 340, c.y)
end


