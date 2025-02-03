--[[----------------------------------------------------------------------------
Friday Night Funkin' Rewritten v1.1.0 beta 2

Copyright (C) 2021  HTV04

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
------------------------------------------------------------------------------]]

function love.load()
	local curOS = love.system.getOS()

	-- Load libraries
	baton = require "lib.baton"
	ini = require "lib.ini"
	lovesize = require "lib.lovesize"
	Gamestate = require "lib.gamestate"
	Timer = require "lib.timer"

	-- Load modules
	status = require "modules.status"
	audio = require "modules.audio"
	graphics = require "modules.graphics"

	-- Load settings
	settings = require "settings"
	input = require "input"

	-- Load states
	clickStart = require "states.click-start"
	debugMenu = require "states.debug-menu"
	menu = require "states.menu"
	weeks = require "states.weeks"
	weeksPixel = require "states.weeks-pixel"

	-- Load substates
	gameOver = require "substates.game-over"
	gameOverPixel = require "substates.game-over-pixel"

	-- Load week data
	weekData = {
		require "weeks.slow",
		require "weeks.run",
		require "weeks.fun",
		require "weeks.pc",
		require "weeks.milk",
		require "weeks.fest",
		require "weeks.fake",
		require "weeks.sun",
		require "weeks.saturn",
		require "weeks.archie'nt",
		require "weeks.0K_Fe",
		require "weeks.24",
		require "weeks.merge"
	}

	-- LÖVE init
	if curOS == "OS X" then
		love.window.setIcon(love.image.newImageData("icons/macos.png"))
	else
		love.window.setIcon(love.image.newImageData("icons/default.png"))
	end

	lovesize.set(1280, 720)

	-- Variables
	font = love.graphics.newFont("fonts/vcr.ttf", 24)

	weekNum = 1
	songDifficulty = 2

	spriteTimers = {
		0, -- Girlfriend
		0, -- Enemy
		0 -- Boyfriend
	}

	storyMode = false
	countingDown = false

	cam = {x = 0, y = 0, sizeX = 0.9, sizeY = 0.9}
	camScale = {x = 0.9, y = 0.9}
	uiScale = {x = 0.7, y = 0.7}

	musicTime = 0
	health = 0

	healthGainAMT = 1 --Controls health gain
	healthBurstCount = 0

	--custom global variables that should allow for camera zoom in(s) on Must Hit Sections
	playerZoom = 0.9
	enemyZoom = 0.9
	isEnemyTurn = false
	isPlayerTurn = false

	--for use offsetting the y position of the camera for certain characters
	--doesnt work
	playerCamOffsetY = 75
	enemyCamOffsetY = 75

	--Misc Flags
	traditionalGF = true --Used to prevent the sad animation from playing if false.
	BFcanDie = true --If false, prevents death anims playing in the event the character would break once done so. (In short, it's a failsafe for characters who dont have death sprites)
	fakeEnemiesPresent = false --Disable fake enemy logic for songs where there is none.
	fakeEnemyTypeEM = false --Only the amount of Fakes in Triple Trouble by default. Ups the Fakes to 4 when true. (Triple Trouble has 3 fakes) (Req. fakeEnemiesPresent)
	tooFestDeath = false --Triggers unused code cus i cant figure it out.
	fakePlayersPresent = false --Disables fake player logic when false.
	fakePlayerCount = 1 --Amount of fake players, if enabled (up to 2 currently) (1 is used for TT, 2 is used for EM Black Sun). (Req. fakePlayersPresent)
	camBumpRate = 60 --Doesn't work. Was inserted into the cam bump code with the intent of interchangabale cam bump speeds
	animInterrupts = true --Stops anims from being interrupted by Idle when false
	closeOnDeath = false --Closes the game on death while true.

	if curOS == "Web" then
		Gamestate.switch(clickStart)
	else
		Gamestate.switch(menu)
	end
end

function love.resize(width, height)
	lovesize.resize(width, height)
end

function love.keypressed(key)
	if key == "6" then
		love.filesystem.createDirectory("screenshots")

		love.graphics.captureScreenshot("screenshots/" .. os.time() .. ".png")
	elseif key == "7" then
		Gamestate.switch(debugMenu)
	elseif key == "0" then
		--debug that instantly ends a song
		inst:stop()
		voices:stop()
	elseif key == "9" then
		--debug that kills the player
		health = -1
	else
		Gamestate.keypressed(key)
	end
end

function love.mousepressed(x, y, button, istouch, presses)
	Gamestate.mousepressed(x, y, button, istouch, presses)
end

function love.update(dt)
	dt = math.min(dt, 1 / 30)

	input:update()

	if status.getNoResize() then
		Gamestate.update(dt)
	else
		love.graphics.setFont(font)
		graphics.screenBase(lovesize.getWidth(), lovesize.getHeight())
		graphics.setColor(1, 1, 1) -- Fade effect on
		Gamestate.update(dt)
		love.graphics.setColor(1, 1, 1) -- Fade effect off
		graphics.screenBase(love.graphics.getWidth(), love.graphics.getHeight())
		love.graphics.setFont(font)
	end

	Timer.update(dt)
end

function love.draw()
	love.graphics.setFont(font)
	if status.getNoResize() then
		graphics.setColor(1, 1, 1) -- Fade effect on
		Gamestate.draw()
		love.graphics.setColor(1, 1, 1) -- Fade effect off
		love.graphics.setFont(font)

		if status.getLoading() then
			love.graphics.print("Loading...", graphics.getWidth() - 175, graphics.getHeight() - 50)
		end
	else
		graphics.screenBase(lovesize.getWidth(), lovesize.getHeight())
		lovesize.begin()
			graphics.setColor(1, 1, 1) -- Fade effect on
			Gamestate.draw()
			love.graphics.setColor(1, 1, 1) -- Fade effect off
			love.graphics.setFont(font)

			if status.getLoading() then
				love.graphics.print("Loading...", lovesize.getWidth() - 175, lovesize.getHeight() - 50)
			end
		lovesize.finish()
	end
	graphics.screenBase(love.graphics.getWidth(), love.graphics.getHeight())

	-- Debug output
	if settings.showDebug then
		love.graphics.print(status.getDebugStr(settings.showDebug), 5, 5, nil, 0.5, 0.5)
	end
end
