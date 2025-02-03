local song, difficulty

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend
		cam.sizeX, cam.sizeY = 0.85, 0.85

		love.graphics.setBackgroundColor(255, 255, 255)

		enemy = love.filesystem.load("sprites/0K_Fe/coldsteel.lua")()

		girlfriend.x, girlfriend.y = 30, -90
		enemy.x, enemy.y = -510, -10
		boyfriend.x, boyfriend.y = 280, 120

		enemyIcon:animate("coldsteel", false)

		self:load()
	end,

	load = function(self)
		weeks:load()


		inst = love.audio.newSource("music/0K_Fe/Inst.ogg", "stream")
		voices = love.audio.newSource("music/0K_Fe/Voices.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes(love.filesystem.load("charts/0K_Fe/personel.lua")())
	end,

	update = function(self, dt)
		weeks:update(dt)

		if health >= 80 then
			if enemyIcon:getAnimName() == "coldsteel" then
				enemyIcon:animate("coldsteel losing", false)
			end
		else
			if enemyIcon:getAnimName() == "coldsteel losing" then
				enemyIcon:animate("coldsteel", false)
			end
		end



		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) then
			love.graphics.setBackgroundColor(0, 0, 0)

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

				girlfriend:draw()
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

		weeks:leave()
	end
}

--0 Kelvin, Absolute Zero. Fe, element symbol for Iron. Absolute Zero is cold, REALLY cold, Iron is often represented as Steel. ColdSteel.
--Included because my friend told me to do it