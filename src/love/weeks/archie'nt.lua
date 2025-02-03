local song, difficulty

local stageBack, floor, chamber, beam, emeralds

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend

		--Gave up adding all these fucking animated sprites, because literally the entire stage is comprised of them
		stageBack = love.filesystem.load("sprites/archie'nt/wall.lua")()
		stageBack:animate("broken", false)
		floor = love.filesystem.load("sprites/archie'nt/floor.lua")()
		floor:animate("yellow", false)
		--I'm not doing the pre-song animation fuck you and fuck that
		chamber = love.filesystem.load("sprites/archie'nt/chamber.lua")()
		chamber:animate("hedied", false)
		beam = love.filesystem.load("sprites/archie'nt/emerald beam.lua")()
		beam:animate("anim", true)
		emeralds = love.filesystem.load("sprites/archie'nt/emeralds.lua")()
		emeralds:animate("anim", true)

		enemy = love.filesystem.load("sprites/archie'nt/fleetway.lua")()

		enemy.x, enemy.y = -500, -600
		boyfriend.x, boyfriend.y = 360, 100
		floor.y = 300
		stageBack.y = -200
		chamber.x, chamber.y = 100, -30
		chamber.sizeX, chamber.sizeY = 0.75, 0.75
		beam.x, beam.y = 100, -700
		beam.sizeX, beam.sizeY = 0.75, 0.75
		emeralds.x, emeralds.y = 100, -500
		emeralds.sizeX, emeralds.sizeY = 0.75, 0.75

		enemyIcon:animate("fleetway", false)

		self:load()
	end,

	load = function(self)
		weeks:load()

		inst = love.audio.newSource("music/archie'nt/Inst.ogg", "stream")
		voices = love.audio.newSource("music/archie'nt/Voices.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		--Had to reconstruct this one too
		--ALERT: If Fleetway is reported to not flip you off during one of his dialouges, smash your monitor, this is a crime.
		weeks:generateNotes(love.filesystem.load("charts/archie'nt/chaos.lua")())
	end,

	update = function(self, dt)
		weeks:update(dt)

		--Return of the stolen code (x2)
		enemy.y = enemy.y + math.sin(love.timer.getTime())
		emeralds.y = emeralds.y + math.sin(love.timer.getTime())

		if health >= 80 then
			if enemyIcon:getAnimName() == "fleetway" then
				enemyIcon:animate("fleetway losing", false)
			end
		else
			if enemyIcon:getAnimName() == "fleetway losing" then
				enemyIcon:animate("fleetway", false)
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
			--Cam Size!!!!!!!!!!! Stolen from the Mario Madness FNFR port
			cam.sizeX, cam.sizeY = 0.75, 0.75
			camScale.x, camScale.y = 0.75, 0.75

			love.graphics.push()
				love.graphics.translate(cam.x * 0.9, cam.y * 0.9)

				stageBack:draw()
				floor:draw()
				beam:draw()
				chamber:draw()
				emeralds:draw()

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
		floor = nil
		chamber = nil
		beam = nil
		emeralds = nil

		weeks:leave()
	end
}

--Codename is a joke, Fleetway Super Sonic is from the Fleetway comics, which isn't the Archie comics, thus Archie'nt.