local song, difficulty

local stageBack

local tooFestDeathVid

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend
		cam.sizeX, cam.sizeY = 0.85, 0.85
		tooFestDeath = true

		tooFestDeathVid = love.graphics.newVideo("videos/BfFuckingDies.ogv")

		stageBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("fest/sanicbg")))

		enemy = love.filesystem.load("sprites/fest/sanic.lua")()

		enemy.x, enemy.y = -380, 100
		enemy.sizeX, enemy.sizeY = 0.35, 0.35
		boyfriend.x, boyfriend.y = 500, 240
		boyfriend.sizeX = 1

		stageBack.sizeX, stageBack.sizeY = 1.5, 1.5

		enemyIcon:animate("sanic", false)

		self:load()
	end,

	load = function(self)
		weeks:load()


		inst = love.audio.newSource("music/fest/Inst.ogg", "stream")
		voices = love.audio.newSource("music/fest/Voices.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		--Chart was so goddamn fast that the notes wouldnt detect despite you hitting them, I changed that :)
		weeks:generateNotes(love.filesystem.load("charts/fest/too-fest.lua")())
	end,

	update = function(self, dt)
		weeks:update(dt)

		if health >= 80 then
			if enemyIcon:getAnimName() == "sanic" then
				enemyIcon:animate("sanic losing", false)
			end
		else
			if enemyIcon:getAnimName() == "sanic losing" then
				enemyIcon:animate("sanic", false)
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
				stageBack:draw()

			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)

				enemy:draw()
				boyfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)

			love.graphics.pop()
			weeks:drawRating(0.9)
		love.graphics.pop()

		weeks:drawUI()
	end,

	leave = function(self)
		tooFestDeath = false
		stageBack = nil

		weeks:leave()
	end
}

--Codename is obvious, song title is Too Fest