local song, difficulty

local stageBack, bush2, bush1, stageFront, mbFront, mbBack, majinFG1, majinFG2, threefun, twofun, onefun, gofun

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend
		cam.sizeX, cam.sizeY = 0.85, 0.85

		--The nightman cometh
		offx, offy = 9999, 9999
		threefun = graphics.newImage(love.graphics.newImage(graphics.imagePath("fun/three")))
		twofun = graphics.newImage(love.graphics.newImage(graphics.imagePath("fun/two")))
		onefun = graphics.newImage(love.graphics.newImage(graphics.imagePath("fun/one")))
		gofun = graphics.newImage(love.graphics.newImage(graphics.imagePath("fun/gofun")))
		--go to ultrakill land
		threefun.x, threefun.y = offx, offy
		twofun.x, twofun.y = offx, offy
		onefun.x, onefun.y = offx, offy
		gofun.x, gofun.y = offx, offy

		stageBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("fun/sonicFUNsky")))
		bush2 = graphics.newImage(love.graphics.newImage(graphics.imagePath("fun/Bush2")))
		bush1 = graphics.newImage(love.graphics.newImage(graphics.imagePath("fun/Bush1")))
		stageFront = graphics.newImage(love.graphics.newImage(graphics.imagePath("fun/floorBG")))

		bush2.x, bush2.y = -50, -20
		bush1.y = -80
		stageFront.y = 100

		--Your Blue now, that's my attack
		enemy = love.filesystem.load("sprites/fun/majin.lua")()
		boyfriend = love.filesystem.load("sprites/fun/bluefriend.lua")()

		majinFG1 = love.filesystem.load("sprites/fun/majin fg1.lua")()
		majinFG2 = love.filesystem.load("sprites/fun/majin fg2.lua")()
		mbFront = love.filesystem.load("sprites/fun/majin bop front.lua")()
		mbBack = love.filesystem.load("sprites/fun/majin bop back.lua")()

		enemy.x, enemy.y = -450, -160
		boyfriend.x, boyfriend.y = 260, 0
		majinFG1.x, majinFG1.y = 260, 400
		majinFG2.x, majinFG2.y = -450, 400
		mbFront.x, mbFront.y = 0, -500
		mbBack.x, mbBack.y = 0, -600

		enemyIcon:animate("majin", false)
		majinFG1:animate("anim", true)
		majinFG2:animate("anim", true)
		mbFront:animate("anim", true)
		mbBack:animate("anim", true)

		self:load()
	end,

	load = function(self)
		weeks:load()


		inst = love.audio.newSource("music/fun/Inst.ogg", "stream")
		voices = love.audio.newSource("music/fun/Voices.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		--I had to reconstruct this entire fucking chart
		--idk why it just DIDNT work before i did so
		weeks:generateNotes(love.filesystem.load("charts/fun/endless.lua")())
	end,

	update = function(self, dt)
		weeks:update(dt)
		majinFG1:update(dt)
		majinFG2:update(dt)
		mbFront:update(dt)
		mbBack:update(dt)

		--that mid-song 321 go
		--wild YanDev sighting *real* *not clickbait*
		--why am i making it do the math when i can just do it myself wth
		--like its not important that it does that
		if musicTime >= 85900 then
			if musicTime <= 85900 + 400 then
				threefun.x, threefun.y = cam.x - 700, cam.y - 500
				threefun.sizeX, threefun.sizeY = 0.5, 0.5
				--this is where I would put my Fade Out code... IF I HAD ONE
			else
				threefun.x, threefun.y = offx, offy
			end
			if musicTime >= 86300 then
				if musicTime <= 86300 + 400 then
					twofun.x, twofun.y = cam.x - 700, cam.y - 500
				else
					twofun.x, twofun.y = offx, offy
				end
			end
			if  musicTime >= 86700 then
				if musicTime <= 86700 + 400 then
					onefun.x, onefun.y = cam.x - 700, cam.y - 500
					onefun.sizeX, onefun.sizeY = 1.5, 1.5
				else
					onefun.x, onefun.y = offx, offy
				end
			end
			if musicTime >=  87100 then
				if musicTime <= 87100 + 400 then
					gofun.x, gofun.y = cam.x - 700, cam.y - 500
					gofun.sizeX, gofun.sizeY = 2, 2
				else
					gofun.x, gofun.y = offx, offy
				end
			end
		end

		if health >= 80 then
			if enemyIcon:getAnimName() == "majin" then
				enemyIcon:animate("majin losing", false)
			end
		else
			if enemyIcon:getAnimName() == "majin losing" then
				enemyIcon:animate("majin", false)
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
				bush2:draw()
				mbBack:draw()
				bush1:draw()
				mbFront:draw()
				stageFront:draw()

			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)

				enemy:draw()
				boyfriend:draw()
				majinFG1:draw()
				majinFG2:draw()
				threefun:draw()
				twofun:draw()
				onefun:draw()
				gofun:draw()
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
		mbBack = nil
		bush2 = nil
		bush1 = nil
		mbFront = nil
		stageFront = nil
		majinFG1 = nil
		majinFG2 = nil
		threefun = nil
		twofun = nil
		onefun = nil
		gofun = nil

		weeks:leave()
	end
}

--Codename is pretty obvious, isn't it? It's the word associated with Majin and his screen, translated as ""Fun is infinite" -Majin/The Devil"