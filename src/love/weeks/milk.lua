local song, difficulty

local stageBack

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend
		cam.sizeX, cam.sizeY = 0.85, 0.85

		stageBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("milk/SunkBG")))

		enemy = love.filesystem.load("sprites/milk/sunky.lua")()

		enemy.x, enemy.y = -380, 220
		boyfriend.x, boyfriend.y = 260, 260

		enemyIcon:animate("sunky", false)

		self:load()
	end,

	load = function(self)
		weeks:load()

		--a a a e a, e e e o e, a a a e a, e ee o e
		inst = love.audio.newSource("music/milk/Inst.ogg", "stream")
		voices = love.audio.newSource("music/milk/Voices.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes(love.filesystem.load("charts/milk/milk.lua")())
	end,

	update = function(self, dt)
		weeks:update(dt)

		if health >= 80 then
			if enemyIcon:getAnimName() == "sunky" then
				enemyIcon:animate("sunky losing", false)
			end
		else
			if enemyIcon:getAnimName() == "sunky losing" then
				enemyIcon:animate("sunky", false)
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
		stageBack = nil

		weeks:leave()
	end
}

--Codename is both the name of this song and "Milk and Cereal"