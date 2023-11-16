local song, difficulty

local video

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend
		cam.sizeX, cam.sizeY = 0.85, 0.85

		--Game breaks if I don't do this
		enemy = love.filesystem.load("sprites/boyfriend.lua")()

		--The video is at an inconsistency with itself, it stutters and sets itself offbeat
		--Would using the original version work?
		video = love.graphics.newVideo("videos/Objection Funk Remastered.ogv")

		enemyIcon:animate("unknown", false)

		self:load()
	end,

	load = function(self)
		weeks:load()


		inst = love.audio.newSource("music/obfun/Inst.ogg", "stream")
		voices = love.audio.newSource("music/obfun/Inst.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes(love.filesystem.load("charts/obfun/obfun.lua")())
	end,

	update = function(self, dt)
		weeks:update(dt)

		--WHY IS THIS SO HARD TO TIME RIGHT
		if musicTime >= (1400) then
			video:play()
		end

		if health >= 80 then
			if enemyIcon:getAnimName() == "unknown" then
				enemyIcon:animate("unknown losing", false)
			end
		else
			if enemyIcon:getAnimName() == "unknown losing" then
				enemyIcon:animate("unknown", false)
			end
		end

		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) then
			status.setLoading(true)

			graphics.fadeOut(
				0.5,
				function()
					Gamestate.switch(menu)

					status.setLoading(false)
				end
			)
		end

		weeks:updateUI(dt)
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			love.graphics.scale(cam.sizeX, cam.sizeY)

			love.graphics.push()
				love.graphics.translate(cam.x * 0.9, cam.y * 0.9)

			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)

				love.graphics.draw(video, cam.x - 775, cam.y - 550, 0, 0.8, 0.8)
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)

			love.graphics.pop()
			weeks:drawRating(0.9)
		love.graphics.pop()

		weeks:drawUI()
	end,

	leave = function(self)

		weeks:leave()
	end
}

--omg Objection Funk hii!!!!!!!!