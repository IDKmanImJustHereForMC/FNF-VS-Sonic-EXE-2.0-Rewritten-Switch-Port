local song, difficulty

local stageBack, stageFront, curtains, floor, flower, small1, tree, small2

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend
		cam.sizeX, cam.sizeY = 0.85, 0.85

		--This Stage is so goddamn EMPTY without the animated bg stuff
		stageBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("pc/sky")))
		stageFront = graphics.newImage(love.graphics.newImage(graphics.imagePath("pc/hills1")))
		curtains = graphics.newImage(love.graphics.newImage(graphics.imagePath("pc/hills2")))
		floor = graphics.newImage(love.graphics.newImage(graphics.imagePath("pc/floor")))
		flower = graphics.newImage(love.graphics.newImage(graphics.imagePath("pc/flower")))
		small1 = graphics.newImage(love.graphics.newImage(graphics.imagePath("pc/smallflower")))
		tree = graphics.newImage(love.graphics.newImage(graphics.imagePath("pc/tree")))
		small2 = graphics.newImage(love.graphics.newImage(graphics.imagePath("pc/smallflowe2")))

		enemy = love.filesystem.load("sprites/pc/lord-x.lua")()

		girlfriend.x, girlfriend.y = 30, -90
		enemy.x, enemy.y = -510, -10
		boyfriend.x, boyfriend.y = 280, 120

		enemyIcon:animate("lord x", false)

		self:load()
	end,

	load = function(self)
		weeks:load()


		inst = love.audio.newSource("music/pc/Inst.ogg", "stream")
		voices = love.audio.newSource("music/pc/Voices.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes(love.filesystem.load("charts/pc/cycles.lua")())
	end,

	update = function(self, dt)
		weeks:update(dt)

		if health >= 80 then
			if enemyIcon:getAnimName() == "lord x" then
				enemyIcon:animate("lord x losing", false)
			end
		else
			if enemyIcon:getAnimName() == "lord x losing" then
				enemyIcon:animate("lord x", false)
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
				stageFront:draw()
				curtains:draw()
				floor:draw()
				flower:draw()
				small1:draw()
				tree:draw()
				small2:draw()

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
		stageFront = nil
		curtains = nil
		floor = nil
		flower = nil
		small1 = nil
		tree = nil
		small2 = nil

		weeks:leave()
	end
}

--Codename is a reference to the title of the game Lord X comes from, Sonic PC Port... or smth like that.