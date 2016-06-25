if love ~= nil then
	lutro = love
end

function lutro.conf(t)
	-- Adapt whichever configuration we use.
	-- @see https://github.com/libretro/libretro-lutro/issues/58
	if t.window ~= nil then
		t.window.width  = 1440
		t.window.height = 900
	else
		t.width = 1440
		t.height = 900
	end
end
