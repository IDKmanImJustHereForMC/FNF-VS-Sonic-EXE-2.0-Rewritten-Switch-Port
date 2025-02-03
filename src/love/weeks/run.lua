local song, difficulty

local stageBack, backtrees, trees, stageFront, IntroCircle, IntroText, cinema

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend

		screenwidth = love.graphics.getWidth()
		screenheight = love.graphics.getHeight()

		--Jesus why was I so stubborn on keeping the Week 1 BG asset names.
		stageBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("run/sky")))
		backtrees = graphics.newImage(love.graphics.newImage(graphics.imagePath("run/backtrees")))
		trees = graphics.newImage(love.graphics.newImage(graphics.imagePath("run/trees")))
		stageFront = graphics.newImage(love.graphics.newImage(graphics.imagePath("run/ground")))
		IntroCircle = graphics.newImage(love.graphics.newImage(graphics.imagePath("run/CircleYouCantRun")))
		IntroText = graphics.newImage(love.graphics.newImage(graphics.imagePath("run/TextYouCantRun")))
		cinema = graphics.newImage(love.graphics.newImage(graphics.imagePath("slow/cinema")))

		enemy = love.filesystem.load("sprites/run/angry-sonic.lua")()

		girlfriend.x, girlfriend.y = 30, -90
		enemy.x, enemy.y = -450, -80
		boyfriend.x, boyfriend.y = 260, 100
		IntroCircle.y, IntroCircle.x = cam.y + 300,  cam.x - 400
		IntroText.y, IntroText.x = cam.y + 300, cam.x + 1700
		cinema.x, cinema.y = cam.x + screenwidth/2, cam.y + screenheight/2

		enemyIcon:animate("sonic angry", false)

		self:load()
	end,

	load = function(self)
		weeks:load()


		inst = love.audio.newSource("music/run/Inst.ogg", "stream")
		voices = love.audio.newSource("music/run/Voices.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes(love.filesystem.load("charts/run/you-cant-run.lua")())
	end,

	update = function(self, dt)
		weeks:update(dt)

		--Intro stuff I just copy pasted from Too Slow
		--Wait this works why did i need to do what i did in too slow AFTER this
		--framerate dependent????????????
		if musicTime <= 3000 then
			if musicTime >= 0 then
				if musicTime <= 1121 then
					IntroCircle.x = IntroCircle.x + 15
					IntroText.x = IntroText.x - 15
				end
				if musicTime >= 1621 then
					if musicTime <= 3000 then
						IntroCircle.x = IntroCircle.x + 15
						IntroText.x = IntroText.x - 15
						if cinema.sizeY <= 4 then
							cinema.sizeY = cinema.sizeY + 0.01
						end		
					end
				end
			end
		end

		if health >= 80 then
			if enemyIcon:getAnimName() == "sonic angry" then
				enemyIcon:animate("sonic angry losing", false)
			end
		else
			if enemyIcon:getAnimName() == "sonic angry losing" then
				enemyIcon:animate("sonic angry", false)
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
				backtrees:draw()
				trees:draw()
				stageFront:draw()

				girlfriend:draw()
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
		cinema:draw()
		IntroCircle:draw()
		IntroText:draw()
	end,

	leave = function(self)
		stageBack = nil
		backtrees = nil
		trees = nil
		stageFront = nil
		IntroText = nil
		IntroCircle = nil
		cinema = nil

		weeks:leave()
	end
}

--Codename is yet again obvious, just the run in "You Can't Run"