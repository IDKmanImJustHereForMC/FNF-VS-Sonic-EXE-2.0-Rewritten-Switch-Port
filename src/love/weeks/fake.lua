--I found you,Faker!
--Faker? I think you're the fake around here. You're comparing yourself to me?! Ha! You're not even good enough to be my fake.
--I'll make you eat those words!

local song, difficulty

local stageBack, stageFront, curtains, pillar1, pillar2, flower1, flower2, tree1, tree2, plant

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend
		cam.sizeX, cam.sizeY = 0.85, 0.85

		stageBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("fake/sky")))
		stageFront = graphics.newImage(love.graphics.newImage(graphics.imagePath("fake/mountains")))
		curtains = graphics.newImage(love.graphics.newImage(graphics.imagePath("fake/grass")))
		pillar1 = graphics.newImage(love.graphics.newImage(graphics.imagePath("fake/pillar1")))
		pillar2 = graphics.newImage(love.graphics.newImage(graphics.imagePath("fake/pillar2")))
		flower1 = graphics.newImage(love.graphics.newImage(graphics.imagePath("fake/flower1")))
		flower2 = graphics.newImage(love.graphics.newImage(graphics.imagePath("fake/flower2")))
		tree1 = graphics.newImage(love.graphics.newImage(graphics.imagePath("fake/tree1")))
		tree2 = graphics.newImage(love.graphics.newImage(graphics.imagePath("fake/tree2")))
		plant = graphics.newImage(love.graphics.newImage(graphics.imagePath("fake/plant")))

		--The positions aren't even right, but I think the BG goes hard
		curtains.y = -200
		pillar1.x = -150
		pillar2.x = 150
		plant.y = -300
		tree1.x, tree1.y = -200, -300
		tree2.y = -300

		enemy = love.filesystem.load("sprites/fake/faker exe.lua")()
		girlfriend = love.filesystem.load("sprites/fake/faker gf.lua")()

		girlfriend.x, girlfriend.y = 100, -20
		enemy.x, enemy.y = -380, -20
		boyfriend.x, boyfriend.y = 400, 100

		enemyIcon:animate("faker", false)

		self:load()
	end,

	load = function(self)
		weeks:load()


		inst = love.audio.newSource("music/fake/Inst.ogg", "stream")
		voices = love.audio.newSource("music/fake/Voices.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		--WHY DOES THE SONG FUCKING LAG SO BAD ON THE SWITCH
		weeks:generateNotes(love.filesystem.load("charts/fake/faker.lua")())
	end,

	update = function(self, dt)
		weeks:update(dt)

		if health >= 80 then
			if enemyIcon:getAnimName() == "faker" then
				enemyIcon:animate("faker losing", false)
			end
		else
			if enemyIcon:getAnimName() == "faker losing" then
				enemyIcon:animate("faker", false)
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

				--Again, these aren't even in the right positions, but the BG goes hard anyway
				stageBack:draw()
				stageFront:draw()
				curtains:draw()
				tree1:draw()
				tree2:draw()
				flower2:draw()
				plant:draw()

				girlfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)

				enemy:draw()
				boyfriend:draw()
				pillar1:draw()
				flower1:draw()
				pillar2:draw()
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
		pillar1 = nil
		pillar2 = nil
		flower1 = nil
		flower2 = nil
		tree1 = nil
		tree2 = nil
		plant = nil

		weeks:leave()
	end
}

--Codename is obvious, Faker