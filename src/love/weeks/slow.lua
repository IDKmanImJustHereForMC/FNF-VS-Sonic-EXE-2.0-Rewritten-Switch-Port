--For whats supposed to be optimized, this is not well optimized
local song, difficulty

local wayBack, stageBack, stageMid, stageFront, curtains, egg, knuck, tail, jumpscaryalert, jumpy, IntroCircle, IntroText

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend
		cam.sizeX, cam.sizeY = 0.85, 0.85

		wayBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("slow/SKY")))
		stageBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("slow/HILLS")))
		stageMid = graphics.newImage(love.graphics.newImage(graphics.imagePath("slow/FLOOR2")))
		stageFront = graphics.newImage(love.graphics.newImage(graphics.imagePath("slow/FLOOR1")))
		curtains = graphics.newImage(love.graphics.newImage(graphics.imagePath("slow/frontgrass")))
		egg = graphics.newImage(love.graphics.newImage(graphics.imagePath("slow/EGGMAN")))
		knuck = graphics.newImage(love.graphics.newImage(graphics.imagePath("slow/KNUCKLE")))
		tail = graphics.newImage(love.graphics.newImage(graphics.imagePath("slow/TAIL")))
		jumpscaryalert = graphics.newImage(love.graphics.newImage(graphics.imagePath("slow/OOGABOOGA")))
		IntroCircle = graphics.newImage(love.graphics.newImage(graphics.imagePath("slow/CircleTooSlow")))
		IntroText = graphics.newImage(love.graphics.newImage(graphics.imagePath("slow/TextTooSlow")))
		

		wayBack.y = 20
		stageBack.y = 20
		stageMid.y = 50
		stageFront.y = 50
		curtains.y = 50
		egg.x, egg.y = -30, 50
		knuck.x, knuck.y = 400, 50
		tail.y = 50
		--Why is it like this
		IntroCircle.y, IntroCircle.x = cam.y + 300,  cam.x - 400
		IntroText.y, IntroText.x = cam.y + 300, cam.x + 1700
		

		--Off to the void with ye!!!!
		offx = 999999
		offy = 999999
		jumpscaryalert.x, jumpscaryalert.y = offx, offy

		enemy = love.filesystem.load("sprites/slow/sonic.lua")()
		tails = love.filesystem.load("sprites/slow/tails.lua")()
		tails:animate("anim", true)
		tails.sizeX, tails.sizeY = 1.25, 1.25
		jumpy = love.filesystem.load("sprites/slow/jumpy.lua")()
		jumpy:animate("anim", true)

		girlfriend.x, girlfriend.y = 30, -90
		enemy.x, enemy.y = -380, 100
		jumpy.x, jumpy.y = offx, offy
		tails.x, tails.y = -800, -80
		boyfriend.x, boyfriend.y = 360, 200

		enemyIcon:animate("sonic", false)

		self:load()
	end,

	load = function(self)
		weeks:load()


		inst = love.audio.newSource("music/slow/too-slow-inst.ogg", "stream")
		voices = love.audio.newSource("music/slow/too-slow-voices.ogg", "stream")
		oogabooga = love.audio.newSource("sounds/OOGABOOGA.ogg", "static")
		jump_sound = love.audio.newSource("sounds/jumpy.ogg", "static")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes(love.filesystem.load("charts/slow/too-slow.lua")())
	end,

	update = function(self, dt)
		weeks:update(dt)
		tails:update(dt)

	--Intro stuff????
	--No don't run every frame
	if musicTime <= 8000 then
		if musicTime >= 0 then
			if musicTime <= 4000 then
				IntroCircle.x = IntroCircle.x + 15
				IntroText.x = IntroText.x - 15
			end
			if musicTime >= 4500 then
				if musicTime <= 8000 then
					IntroCircle.x = IntroCircle.x + 15
					IntroText.x = IntroText.x - 15
				end
			end
		end
	end

	--JUMPSCARES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	--There has to be a cleaner way to do it, but better dusty than completely covered in mud
	if musicTime >= (97700) then
			if musicTime <= (97700 + 300) then

			oogabooga:play()
			jumpscaryalert.x, jumpscaryalert.y = cam.x + 1000, cam.y + 500

			else

			jumpscaryalert.x, jumpscaryalert.y = offx, offy

		end 
	end 

	if musicTime >= (118990) then
			if musicTime <= (118990 + 300) then

			oogabooga:play()
			jumpscaryalert.x, jumpscaryalert.y = cam.x + 1000, cam.y + 500

			else

			jumpscaryalert.x, jumpscaryalert.y = offx, offy

		end 
	end

	if musicTime >= (132250) then
			if musicTime <= (132250 + 300) then

			oogabooga:play()
			jumpscaryalert.x, jumpscaryalert.y = cam.x + 1000, cam.y + 500

			else

			jumpscaryalert.x, jumpscaryalert.y = offx, offy

		end 
	end

	--It works, but not well
	if musicTime >= (164000) then
		if musicTime <= (164000 + 1000) then

			jump_sound:play()
			jumpy.sizeX, jumpy.sizey = 1, 2
			jumpy.x, jumpy.y = cam.x - 300, cam.y + 500

			else

			jumpy.x, jumpy.y = offx, offy

		end
	end

		if health >= 80 then
			if enemyIcon:getAnimName() == "sonic" then
				enemyIcon:animate("sonic losing", false)
			end
		else
			if enemyIcon:getAnimName() == "sonic losing" then
				enemyIcon:animate("sonic", false)
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

				wayBack:draw()
				stageBack:draw()
				stageMid:draw()
				stageFront:draw()

				girlfriend:draw()
				tail:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)

				enemy:draw()
				egg:draw()
				tails:draw()
				boyfriend:draw()
				knuck:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)

				curtains:draw()
				
			love.graphics.pop()
			weeks:drawRating(0.9)
		love.graphics.pop()

		weeks:drawUI()
		jumpscaryalert:draw()
		jumpy:draw()
		IntroCircle:draw()
		IntroText:draw()
	end,

	leave = function(self)
		wayBack = nil
		stageBack = nil
		stageMid = nil
		stageFront = nil
		curtains = nil
		egg = nil
		knuck = nil
		tail = nil
		jumpy = nil
		IntroCircle = nil
		IntroText = nil

		weeks:leave()
	end
}

--Codename is self explanatory, Too "Slow"
--It is very clear that this is the first song I ported