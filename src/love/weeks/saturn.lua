local song, difficulty

local stageBack

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend

		stageBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("saturn/TailsBG")))

		--I CHANGED BF GUYS!!!!!!!!! THAT'S SO COOL RIGHT?!?!?!?!?!?!?!?!
		enemy = love.filesystem.load("sprites/saturn/tails doll.lua")()
		boyfriend = love.filesystem.load("sprites/saturn/saturnfriend.lua")()

		enemy.x, enemy.y = -380, -50
		boyfriend.x, boyfriend.y = 360, 100

		--I don't know how to change BF's icon
		enemyIcon:animate("doll", false)

		self:load()
	end,

	load = function(self)
		weeks:load()

		inst = love.audio.newSource("music/saturn/Inst.ogg", "stream")
		voices = love.audio.newSource("music/saturn/Voices.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes(love.filesystem.load("charts/saturn/sunshine.lua")())
	end,

	update = function(self, dt)
		weeks:update(dt)

		--Borrowed code that makes Tails Doll float, I stole it from GuglioIsStupid#8008 on the FNFR Discord (his name is actually just a demon emoji)
		enemy.y = enemy.y + math.sin(love.timer.getTime())

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

--Codename is a reference to the system Sonic R was originally released on, the Sega Saturn