--By Default
local song, difficulty

--Static Stage Assets
local stageBack, stageFront, curtains, FishOnDaFlo, TheOtherFlo, TALISDED

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend

		--One of these mf's was animated, but the poor things a still image now
		stageBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/sky")))
		stageFront = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/backtrees")))
		curtains = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/trees")))

		--Well this looks like ya mom
		FishOnDaFlo = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/ground")))
		TheOtherFlo = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/ExeBG_Assets")))
		TALISDED = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/TailsCorpse")))

		TheOtherFlo.x, TheOtherFlo.y = 500, -150
		TALISDED.x, TALISDED.y = 650, 100

		enemy = love.filesystem.load("sprites/sun/exe.lua")()
		girlfriend = love.filesystem.load("sprites/fake/faker gf.lua")()

		girlfriend.x, girlfriend.y = 350, 50

		--I'm not even sure if he's supposed to go here, I just know he's close
		enemy.x, enemy.y = -380, -50
		boyfriend.x, boyfriend.y = 650, 250

		enemyIcon:animate("exe", false)

		self:load()
	end,

	load = function(self)
		weeks:load()

		inst = love.audio.newSource("music/sun/Inst.ogg", "stream")
		voices = love.audio.newSource("music/sun/Voices.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes(love.filesystem.load("charts/sun/black-sun.lua")())
	end,

	update = function(self, dt)
		weeks:update(dt)

		--Did the thing where he doesn't actually have a losing icon, but a winning one
		if health <= 20 then
			if enemyIcon:getAnimName() == "exe" then
				enemyIcon:animate("exe winning", false)
			end
		else
			if enemyIcon:getAnimName() == "exe winning" then
				enemyIcon:animate("exe", false)
			end
		end

		--Health drain code. (Sorry Controller ppl!)
		--Did normal opponent health drain cus I can't figure out Black Sun's ACTUAL hp mechanic.

		--Setting the amount of health drain this way simply so it's easier to mess with.
		if musicTime <= (95000) then
			drainAmount = 0.2
		else
			drainAmount = 0.4
		end

		--Checks if the enemy's ARROWS are pressed instead of if they play an animation like last time.
		--Done this way so the amount of health that drains is shorter than if it were like how it were before.
		--These are made seperate so multiple arrows in quick succession works how it should.
		if health >= 20 then
			if enemyArrows[1]:getAnimName() == "confirm" then
				health = health - drainAmount
			end
			if enemyArrows[2]:getAnimName() == "confirm" then
				health = health - drainAmount
			end
			if enemyArrows[3]:getAnimName() == "confirm" then
				health = health - drainAmount
			end
			if enemyArrows[4]:getAnimName() == "confirm" then
				health = health - drainAmount
			end
		end

		--I was trying to add a cam follw thingy, but it turned into a hilarious mess and i cant stop laughing at it
		--For best experience, crank up to 1.25

		--[[ if not mustHitSection then
			if enemy:getAnimName() == "down" then
				camTimer = Timer.tween(0.75, cam, {x = -enemy.x - 100, y = -enemy.y + 50}, "out-quad")
			end
			if enemy:getAnimName() == "up" then
				camTimer = Timer.tween(0.75, cam, {x = -enemy.x - 100, y = -enemy.y + 100}, "out-quad")
			end
			if enemy:getAnimName() == "left" then
				camTimer = Timer.tween(0.75, cam, {x = -enemy.x - 75, y = -enemy.y + 75}, "out-quad")
			end
			if enemy:getAnimName() == "right" then
				camTimer = Timer.tween(0.75, cam, {x = -enemy.x - 125, y = -enemy.y + 75}, "out-quad")
			end
		end ]]--

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
				FishOnDaFlo:draw()
				TheOtherFlo:draw()
				TALISDED:draw()

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
	end,

	leave = function(self)
		stageBack = nil
		stageFront = nil
		curtains = nil
		FishOnDaFlo = nil
		TheOtherFlo = nil
		TALISDED = nil

		weeks:leave()
	end
}

--This codename is self explanatory, literally just the "sun" in Black Sun
