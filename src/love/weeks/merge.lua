--By Default
local song, difficulty

--Stage Assets
local stageBack, stageFront, curtains, FishOnDaFlo, TheOtherFlo, TALISDED, viginette, AMYISDED, KNUXISDED, itsOnlyOneColorWhyIsItAnImage

--Finale Stage Assets, separated so stage assets line isnt a bajillion words long
local finalEXEfloor

--A good chunk of this is recycled from Black Sun's file, or vice versa
--Behold, my Magnum Opus
--All my skills and learning has all come to this moment
--And multiple epiphanies on what I was doing before being stupid and what I'm doing now being ingenius (it's not)
--This is so long that it physically lags my computer when i load the song
return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend

		timeTillHealthDrain = 2000 --Placeholder value that does nothing for now
		cap = 100

		closeOnDeath = true
		songFunVal = love.math.random(1, 7)

		--Event Flags
		--Don't mess with these unless you WANT your game to lag or bug out
		healthGimmickInit = false
		eventOnePassed = false
		eventTwoPassed = false
		eventThreePassed = false
		eventFourPassed = false
		eventFivePassed = false
		eventSixPassed = false
		eventSevenPassed = false
		eventEightPassed = false
		eventNinePassed = false
		eventTenPassed = false
		eventElevenPassed = false
		eventTwelvePassed = false
		eventThirteenPassed = false

		--Forced Settings Flags
		fuckedWithYou = false
		swappedUpscroll = false
		swappedDownscroll = false

		--FUCK YOU HAHAHAHAHAHAHAHAHAHAHHAHHAAHHA
		if settings.kadeInput then
			settings.kadeInput = false
			fuckedWithYou = true
		end
		--force middlescroll
		if settings.downscroll then
			settings.downscroll = false
			settings.middlescroll = true
			swappedDownscroll = true
		elseif not settings.downscroll and not swappedDownscroll and not settings.middlescroll then
			settings.middlescroll = true
			swappedUpscroll = true
		end

		isReallyCool = false --All this flag does is change BF's icon to the red ver.

		fakeEnemiesPresent = true --Fake Enemy/Player settings
		fakeEnemyTypeEM = true
		fakePlayersPresent = true
		fakePlayersCount = 1

		--Must Hit Section variables
		enemyCamOffsetY = 135 --This doesn't work how i'd want it to but ok
		playerZoom = 0.9
		enemyZoom = 0.6

		--This is a surprise tool to help us later
		love.graphics.setBackgroundColor(255, 0, 0)

		--Static Stage Assets
		--all this time and knowledge and i still haven't changed the Week1 asset names...
		itsOnlyOneColorWhyIsItAnImage = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/secret/stage/Background")))
		viginette = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/secret/stage/black_vignette")))
		--I altered the black sun image so the sun wouldnt just appear cut off if any area above it was shown.
		stageBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/secret/stage/The-Black-Sun")))
		stageFront = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/secret/stage/Clouds")))
		curtains = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/secret/stage/Background_Mountains")))
		FishOnDaFlo = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/secret/stage/Middle-Ground")))
		TheOtherFlo = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/secret/stage/Stage")))
		TALISDED = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/secret/stage/Corpses/Tails")))
		AMYISDED = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/secret/stage/Corpses/Amy")))
		KNUXISDED = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/secret/stage/Corpses/Knuckles")))
		finalEXEfloor = graphics.newImage(love.graphics.newImage(graphics.imagePath("sun/secret/stage/persp/Parts/EXE_Platform")))

		--Setting Enemies and Fakes
		enemy = love.filesystem.load("sprites/sun/secret/exe phase1.lua")() --Phase 1
		fakeEnemy1 = love.filesystem.load("sprites/sun/secret/exe phase2.lua")() --Phase 2
		fakeEnemy2 = love.filesystem.load("sprites/sun/secret/exe phase2alt.lua")() --Phase 2 ALT
		fakeEnemy3 = love.filesystem.load("sprites/sun/secret/exe phase2 epicpart.lua")() --RW
		fakeEnemy4 = love.filesystem.load("sprites/sun/secret/exe phase3.lua")() --Final
		fakePlayer1 = love.filesystem.load("sprites/sun/secret/bf EXEMERGE epicpart.lua")() --RW BF

		--i created so many wierd logics and variables specifically for this
		--Not that I mind, it was fun creating and adding all the wierd shit I did
		traditionalGF = false
		BFcanDie = false
		girlfriend = love.filesystem.load("sprites/sun/secret/gf EXEMERGE.lua")()
		boyfriend = love.filesystem.load("sprites/sun/secret/bf EXEMERGE.lua")()

		--Positioning etc.
		finalEXEfloor.x, finalEXEfloor.y = -380, 150
		finalEXEfloor.sizeX = 0.00000001
		stageBack.x, stageBack.y = 0, -250
		stageFront.x, stageFront.t = 0, 0
		curtains.x, curtains.y = 0, -150
		TheOtherFlo.x, TheOtherFlo.y = 0, -100
		FishOnDaFlo.x, FishOnDaFlo.y = 0, -150
		TALISDED.x, TALISDED.y = 100, -100
		AMYISDED.x, AMYISDED.y = 150, -125
		KNUXISDED.x, KNUXISDED.y = 75, -150
		viginette.sizeX, viginette.sizeY = 4, 4
		girlfriend.x, girlfriend.y = 250, -150
		enemy.x, enemy.y = -380, -50
		--enemy.sizeX = 0.000000001 --Only if I ever need to test a fake Enemy
		fakeEnemy1.x, fakeEnemy1.y = -380, -50 --PROBABLY could've just did enemy.x, enemy.y but whatever
		fakeEnemy1.sizeX = 0.000000001 --Be invisible
		fakeEnemy2.x, fakeEnemy2.y = -380, -50
		fakeEnemy2.sizeX = 0.000000001
		fakeEnemy3.x, fakeEnemy3.y = -380, -50
		fakeEnemy3.sizeX = 0.000000001
		fakeEnemy4.x, fakeEnemy4.y = -380, -50
		fakeEnemy4.sizeX = 0.000000001
		fakePlayer1.x, fakePlayer1.y = 650, 300
		fakePlayer1.sizeX = 0.000000001
		--fakePlayer2.x, fakePlayer2.y = -380, 550
		--fakePlayer2.sizeX = 0.00000001
		boyfriend.x, boyfriend.y = 650, 300

		itsOnlyOneColorWhyIsItAnImage.sizeX, itsOnlyOneColorWhyIsItAnImage.sizeY = 999999999, 999999999

		--Icon related strings
		enemyStatus = "Normal"
		enemyDirection = "idle"
		enemyPhase = "PHASEONE"
		enemyIcon:animate("EXEmerge"..enemyDirection..enemyStatus..enemyPhase , false) --Fully animates as EXEmergeidleNormalPHASEONE
		iconShouldAnimate = "WinLoss"
		playerAddon = "" --Icon addon string for the player, tacks onto the end

		self:load()
	end,

	load = function(self)
		weeks:load()

		inst = love.audio.newSource("music/sun/secretInst.ogg", "stream")
		voices = love.audio.newSource("music/sun/secretVoices.ogg", "stream")

		youDidIt = love.audio.newSource("sounds/ring.ogg", "stream")
		youDidIt:setVolume(2)

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self) --Actually what the hell else am i supposed to do in here
		weeks:initUI()

		weeks:generateNotes(love.filesystem.load("charts/sun/black-sun-mrg.lua")())
	end,

	update = function(self, dt)
		weeks:update(dt)

		--TECHINCAL STUFF/MECHANICS

		--Funny part is I can't even tell if this works or not
		--probably not
		viginette.x, viginette.y = cam.x, cam.y

		--New icon system specifically for this one song
		--Sets the enemies status for easy interchangability later
		--Why doesn't base FNFR just do something like this again?
		if health <= 20 then
			enemyStatus = "Winning"
			if isReallyCool then
				playerAddon = " awesome losing"
			else
				playerAddon = " losing"
			end
		else
			enemyStatus = "Normal"
			if isReallyCool then
				playerAddon = " awesome"
			else
				playerAddon = ""
			end
		end

		--Gets the name of the animation the opponent is using, for application later.
		--I have a strange feeling that i will need to do it like this
		if musicTime >= 0 then
			enemyDirection = enemy:getAnimName() --This is always being tracked even tho it's only used in 2 phases, one of which is on and off
		else
			enemyDirection = "idle" --Failsafe, not like this needs one
		end

		--Applies everything to the icon
		if iconShouldAnimate == "Full" then --Direction Anims + Winning/Losing
			enemyIcon:animate("EXEmerge"..enemyDirection..enemyStatus..enemyPhase , false) --only ever used for phase 1 sadge
		elseif iconShouldAnimate == "WinLoss" then --Winning/Losing ONLY
			enemyIcon:animate("EXEmergeidle"..enemyStatus..enemyPhase , false) --also only used for phase 1
		elseif iconShouldAnimate == "Static" then --NOTHING, absolutely NO fun
			enemyIcon:animate("EXEmergeidleNormal"..enemyPhase , false)
		end

		boyfriendIcon:animate("bf EXEmerge"..playerAddon, false)

		drainAmount = 2

		--Old health Drain Stuff
		--I originally couldn't figure out how Black Sun's health drain worked, so I made the usual variation of health drain
		--Uncomment the code to enable it, but if you do, best advised to comment the current health drain and set drainAmount to 0.35

		--Checks if the enemy's ARROWS are pressed instead of if they play an animation like last time.
		--Done this way so the amount of health that drains is shorter than if it were like how it were before.
		--These are made seperate so multiple arrows in quick succession works how it should.
		--[[if health >= 20 then
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
		end]]

		--Health Drain code (current)
		if not healthGimmickInit then
			if musicTime >= 0 then --Sets variables mid-song so they can actually be used as intended
				health = 100
				healthGainAMT = 0
				timeTillHealthDrain = bpm --Was 250, but subbed in for bpm cus thats better i think
				healthGimmickInit = true
			end
		end
		if healthGimmickInit then
			timeTillHealthDrain = timeTillHealthDrain - 1
			if timeTillHealthDrain <= 0 then
				if health > 20 then --Remove when done testing
					health = health - drainAmount --Leftover from old health drain, was simply made for interchangability
				end
				timeTillHealthDrain = bpm
			end
		end

		--Health GAIN code
		--Doing it like this cus I dunno how to add custom notetypes
		if healthBurstCount >= cap then
			health = health + 15
			youDidIt:play() --This is more to notify the player it happened and why rather than to imitate ring notes
			cap = health
			healthBurstCount = 0
		end

		--EVENTS

		--First Event/Icon Starts Animating
		if musicTime <= 25700 then
			if musicTime >= 25600 then
				iconShouldAnimate = "Full"
				eventOnePassed = true
			end
		end

		--Second Event/Icon STOPS Animating
		if eventOnePassed and not eventTwoPassed then --Only start checking after the first event passed, hopefully to reduce stress
			if musicTime <= 52000 then
				if musicTime >= 51200 then
					iconShouldAnimate = "WinLoss"
					eventTwoPassed = true
				end
			end
		end

		--Third Event/Icon Starts Animating... Again...
		if eventTwoPassed and not eventThreePassed then
			if musicTime <= 64050 then
				if musicTime >= 64000 then
					iconShouldAnimate = "Full"
					eventThreePassed = true
				end
			end
		end

		--Icon stops animating again
		if eventThreePassed and not eventFourPassed then
			if musicTime <= 89650 then
				if musicTime >= 89600 then
					iconShouldAnimate = "WinLoss"
					eventFourPassed = true
				end
			end
		end

		--"Character Change" to phase 2
		if eventFourPassed and not eventFivePassed then --This is a recurring theme
			if musicTime <= 96500 then
				if musicTime >= 96000 then
					iconShouldAnimate = "Static"
					enemyPhase = "PHASETWO"
					enemy.sizeX = 0.000000001
					fakeEnemy1.sizeX = 1
					health = health + 10
					eventFivePassed = true
				end
			end
		end

		--Alt Anims Toggle
		if eventFivePassed and not eventSixPassed then
			if musicTime <= 140850 then
				if musicTime >= 140799 then
					fakeEnemy1.sizeX = 0.000000001
					fakeEnemy2.sizeX = 1
					eventSixPassed = true
				end
			end
		end

		--Normal Anims Toggle
		if eventSixPassed and not eventSevenPassed then
			if musicTime <= 141740 then
				if musicTime >= 141692 then
					fakeEnemy1.sizeX = 1
					fakeEnemy2.sizeX = 0.000000001
					eventSevenPassed = true
				end
			end
		end

		--Alt Anims Toggle again
		if eventSevenPassed and not eventEightPassed then
			if musicTime <= 160054 then
				if musicTime >= 160004 then
					fakeEnemy1.sizeX = 0.000000001
					fakeEnemy2.sizeX = 1
					eventEightPassed = true
				end
			end
		end

		--THAT ONE REALLY COOL PART I LOVE
		if eventEightPassed and not eventNinePassed then
			if musicTime <= 172850 then
				if musicTime >= 172800 then
					enemyPhase = "PHASERED"
					isReallyCool = true -- :D
					health = health + 10
					playerZoom = 0.45
					enemyZoom = 0.45
					--Size Changes
					stageBack.sizeX = 0.000000001
					stageFront.sizeX = 0.000000001
					curtains.sizeX = 0.000000001
					FishOnDaFlo.sizeX = 0.000000001
					TheOtherFlo.sizeX = 0.000000001
					TALISDED.sizeX = 0.000000001
					AMYISDED.sizeX = 0.000000001
					KNUXISDED.sizeX = 0.000000001
					itsOnlyOneColorWhyIsItAnImage.sizeX = 0.000000001
				end
				if musicTime >= 172802 then --Seperated cus it cant handle everything at once.
					girlfriend.sizeX = 0.000000001
					fakeEnemy1.sizeX = 0.000000001
					fakeEnemy2.sizeX = 0.000000001
					fakeEnemy3.sizeX = 1
					boyfriend.sizeX = 0.000000001
					fakePlayer1.sizeX = 1
					viginette.sizeX = 0.000000001
					camBumpRate = 15 --it dont work
					eventNinePassed = true
				end
			end
		end

		--Exit the really cool awesome epic part and return to normal
		if eventNinePassed and not eventTenPassed then
			if musicTime >= 203200 then
				enemyPhase = "PHASETWO"
				isReallyCool = false
				playerZoom = 0.9
				enemyZoom = 0.7
				stageBack.sizeX = 1
				stageFront.sizeX = 1
				curtains.sizeX = 1
				FishOnDaFlo.sizeX = 1
				TheOtherFlo.sizeX = 1
				TALISDED.sizeX = 1
				AMYISDED.sizeX = 1
				KNUXISDED.sizeX = 1
				itsOnlyOneColorWhyIsItAnImage.sizeX = 999999999
			end
			if musicTime >= 203202 then
				girlfriend.sizeX = 1
				fakeEnemy1.sizeX = 1
				fakeEnemy3.sizeX = 0.000000001
				boyfriend.sizeX = 1
				fakePlayer1.sizeX = 0.000000001
				viginette.sizeX = 4
				camBumpRate = 60 --dunno why im resetting it, cus it still dont work
				eventTenPassed = true
			end
		end

		if eventTenPassed and not eventElevenPassed then
			if musicTime >= 211204 then
				fakeEnemy4.sizeX = 1
				fakeEnemy1.sizeX = 0.000000001
				boyfriend.sizeX = 0.000000001
				boyfriend.x, boyfriend.y = -380, 550
				--fakePlayer2.sizeX = 1
				playerZoom = 0.7
			end
			if musicTime >= 211205 then
				finalEXEfloor.sizeX = 1
				--finalBFfloor.sizeX = 1
				stageFront.sizeX = 0.000000001
				curtains.sizeX = 0.000000001
				FishOnDaFlo.sizeX = 0.000000001
				TheOtherFlo.sizeX = 0.000000001
				TALISDED.sizeX = 0.000000001
				AMYISDED.sizeX = 0.000000001
				KNUXISDED.sizeX = 0.000000001
			end
		end

		--EXTRA

		--You cannot exit the song without closing your game lmao
		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) then
			if fuckedWithYou then
				settings.kadeInput = true
			end
			if swappedDownscroll then
				settings.middlescroll = false
				settings.downscroll = true
			elseif swappedUpscroll then
				settings.middlescroll = false
			end

			if songFunVal == 1 then
				love.window.showMessageBox("THANKS FOR PLAYING", "YOU STILL GET NO BITCHES")
			elseif songFunVal == 2 then
				love.window.showMessageBox("OOF", "YOU STILL GET NO CHEZBURGERS")
			elseif songFunVal == 3 then
				love.window.showMessageBox(":)", "how jooyoouse= : )")
			elseif songFunVal == 4 then
				love.window.showMessageBox(":(", "Foiled once again...")
			elseif songFunVal == 5 then
				love.window.showMessageBox("OH HELL NO", "I DEMAND A REMATCH, SAME TIME SAME PLACE")
			elseif songFunVal == 6 then
				love.window.showMessageBox("I", "I")
			elseif songFunVal == 7 then
				love.window.showMessageBox("WILL THIS GUY SHUT UP", "OH MY GOD PLEASE KILL YOURSELF")
			end

			love.event.quit()
		end

		weeks:updateUI(dt)
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			love.graphics.scale(cam.sizeX, cam.sizeY)

			love.graphics.push()
				love.graphics.translate(cam.x * 0.9, cam.y * 0.9)

				itsOnlyOneColorWhyIsItAnImage:draw()
				stageBack:draw()
				stageFront:draw()
				curtains:draw()
				FishOnDaFlo:draw()
				TheOtherFlo:draw()

				girlfriend:draw()
				TALISDED:draw()
				AMYISDED:draw()
				KNUXISDED:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)

				finalEXEfloor:draw()

				fakeEnemy1:draw()
				fakeEnemy2:draw()
				fakeEnemy3:draw()
				fakeEnemy4:draw()
				enemy:draw()
				fakePlayer1:draw()
				boyfriend:draw()

				viginette:draw()

			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)

			love.graphics.pop()
			weeks:drawRating(0.9)
		love.graphics.pop()

		weeks:drawUI()
	end,

	--You can't exit the song without closing the game so why do I even bother.
	leave = function(self)
		stageBack = nil
		stageFront = nil
		curtains = nil
		FishOnDaFlo = nil
		TheOtherFlo = nil
		TALISDED = nil
		viginette = nil
		AMYISDED = nil
		KNUXISDED = nil
		itsOnlyOneColorWhyIsItAnImage = nil
		finalEXEfloor = nil

		weeks:leave()
	end
}

--EXEmerge | BLACK SUN | Neutroa, ft. Sturm
--Go give the og mod a try !!!!!!!!