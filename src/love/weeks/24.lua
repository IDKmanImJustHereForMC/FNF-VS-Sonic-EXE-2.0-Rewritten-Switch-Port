local song, difficulty

local perfectFuckingCell

--Free-4-Me Parts
local floor1, sky1, backobjects1, backobjects2, trees1, foreground1, beginAnim, water1, cutsceneVid, playWitBro

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend

		playerZoom = 0.7
		enemyZoom = 0.7

		playedBeginningAnim = false
		firstEvent = false
		secondEvent = false
		vidStarted = false
		thirdEvent = false
		evilLebaronRedCircle = false
		fourthEvent = false

		screenwidth = love.graphics.getWidth()
		screenheight = love.graphics.getHeight()

		enemy = love.filesystem.load("sprites/24/sonic.lua")() 

		girlfriend.x, girlfriend.y = 30, -90
		enemy.x, enemy.y = -550, -10
		boyfriend.x, boyfriend.y = 370, 100

		--Free-4-Me Parts
		floor1 = graphics.newImage(love.graphics.newImage(graphics.imagePath("24/stage/good/ground")))
		sky1 = graphics.newImage(love.graphics.newImage(graphics.imagePath("24/stage/good/whatsupthesky")))
		backobjects1 = graphics.newImage(love.graphics.newImage(graphics.imagePath("24/stage/good/backrocks")))
		backobjects2 = graphics.newImage(love.graphics.newImage(graphics.imagePath("24/stage/good/biggerbackrocks")))
		trees1 = graphics.newImage(love.graphics.newImage(graphics.imagePath("24/stage/good/mmmpalms")))
		foreground1 = graphics.newImage(love.graphics.newImage(graphics.imagePath("24/stage/good/frontobjects")))
		playWitBro = graphics.newImage(love.graphics.newImage(graphics.imagePath("24/stage/good/playwithHim"))) --yeah idk how to use alphabet.png so i just made it an image

		beginAnim = love.filesystem.load("sprites/24/beginAnimSonic.lua")() 
		water1 = love.filesystem.load("sprites/24/agua.lua")()

		cutsceneVid = love.graphics.newVideo("videos/24cutscene.ogv")

		floor1.x, floor1.y = -100, 400
		sky1.x, sky1.y = -150, -350
		backobjects2.x, backobjects2.y = 0, -300
		backobjects1.x, backobjects1.y = -100, -250
		trees1.y = -380
		foreground1.x, foreground1.y = 120, 200
		beginAnim.sizeX = 0.00000001
		beginAnim.x, beginAnim.y = enemy.x - 47, enemy.y - 3
		water1.x, water1.y = -13, -290
		playWitBro.sizeX = 0.000000001

		enemyStatus = "Normal"
		charSection = "REALsonic"
		enemyIcon:animate("24"..charSection..enemyStatus , false)
		iconShouldAnimate = "WinLoss"

		perfectFuckingCell = graphics.newImage(love.graphics.newImage(graphics.imagePath("24/stage/good/perfectFuckingCell")))
		perfectFuckingCell.x = 99999 --you will never find him

		self:load()
	end,

	load = function(self)
		weeks:load()


		inst = love.audio.newSource("music/24/Inst.ogg", "stream")
		voices = love.audio.newSource("music/24/Voices.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes(love.filesystem.load("charts/24/obituary.lua")()) --NYI
	end,

	update = function(self, dt)
		weeks:update(dt)

		beginAnim:update(dt)
		water1:update(dt)

		if health >= 80 then
			enemyStatus = "Losing"
		else
			enemyStatus = "Normal"
		end

		if iconShouldAnimate == "WinLoss" then
			enemyIcon:animate("24"..charSection..enemyStatus , false)
		elseif iconShouldAnimate == "Static" then --I only use this one for the final part
			enemyIcon:animate("24"..charSection.."Normal" , false)
		end

		--Beginning Cutscene/Anim Event
		if not firstEvent then
			if musicTime <= 10000 then
				if musicTime >= 0 then
					if musicTime <= 50 then
						cam.sizeX, cam.sizeY = 1.25, 1.25
					end
					cam.x, cam.y = -enemy.x, enemy.y + 25
					camScale.x, camScale.y = cam.sizeX, cam.sizeY
					if cam.sizeX > 1.05 then
						cam.sizeX, cam.sizeY = cam.sizeX - 0.001, cam.sizeY - 0.001
					end
					if not playedBeginningAnim then
						enemy.sizeX = 0.000000001
						beginAnim.sizeX = 1
						beginAnim:animate("anim", false)
						playedBeginningAnim = true
					end
				end
			else
				enemy.sizeX = 1
				beginAnim.sizeX = 0.00000001
				firstEvent = true
			end
		end

		--WOW! YOU DIDS IT!
		if firstEvent and not secondEvent then
			if musicTime >= 84500 then
				enemy.sizeX = 0.000000001
				boyfriend.sizeX = 0.000000001
				trees1.sizeX = 0.000000001
				foreground1.sizeX = 0.000000001
				floor1.sizeX = 0.000000001
				sky1.sizeX = 0.000000001
				water1.sizeX = 0.000000001
				backobjects1.sizeX = 0.000000001
				backobjects2.sizeX = 0.000000001
				if not vidStarted then
					cam.x, cam.y = 310, 910
					cutsceneVid:play()
					vidStarted = true
				end
				secondEvent = true
			end
		end

		--(It's Legacay Obituary, actually!!!!)
		if secondEvent and not thridEvent then
			if musicTime >= 91600 then
				cutsceneVid:pause() --stop is not a thing apparently
				cutsceneVid:seek(0)
				enemy.sizeX = 1
				camScale.x, camScale.y = cam.sizeX, cam.sizeY
				cam.x, cam.y = -enemy.x, enemy.y + 50
				if musicTime <= 91900 then
					cam.sizeX, cam.sizeY = 1.5, 1.5
				end
				if cam.sizeX < 1.49 then
					cam.sizeX, cam.sizeY = cam.sizeX - 0.0005, cam.sizeY - 0.0005
				end
				if not evilLebaronRedCircle then
					animInterrupts = false
					enemy:animate("IMTURNINGEVIL", false)
					evilLebaronRedCircle = true
				end
			end
			if cam.sizeX >= 1.48 and evilLebaronRedCircle then
				thirdEvent = true
			end
		end

		--do yuo wana play wit me??/?? :)
		if thirdEvent and not fourthEvent then
			if musicTime >= 92500 then
				cam.sizeX, cam.sizeY = 0.7, 0.7
				enemy.sizeX = 0.000000001
				playWitBro.sizeX = 1
				playWitBro.x, playWitBro.y = cam.x + (screenheight / 6), cam.y + (screenheight / 2.3) --The amount of times i tweaked this is absurd
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

				love.graphics.draw(cutsceneVid, -999, -1299)

				sky1:draw()
				backobjects2:draw()
				backobjects1:draw()
				water1:draw()
				trees1:draw()
				floor1:draw()

				beginAnim:draw()
				enemy:draw()
				boyfriend:draw()
				foreground1:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)

			love.graphics.pop()
			weeks:drawRating(0.9)
		love.graphics.pop()

		weeks:drawUI()
		perfectFuckingCell:draw()
		playWitBro:draw()
	end,

	leave = function(self)
		sky1 = nil
		sky1 = nil
		backobjects1 = nil
		backobjects2 = nil
		trees1 = nil
		beginAnim = nil
		water1 = nil
		cutsceneVid = nil
		playWitBro = nil
		perfectFuckingCell = nil

		weeks:leave()
	end
}

--2Torial and Free-4-Me use 2 and 4 specifically to make 24, and the 24th letter of the alphabet is X, foreshadowing the Legacy part of RodenTrap
--thanks funkipedia