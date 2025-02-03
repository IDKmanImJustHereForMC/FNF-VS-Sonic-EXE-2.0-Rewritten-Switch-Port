--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten

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

local fromState

local goFunVal = love.math.random(1, 5)

return {
	enter = function(self, from)
		local boyfriend = fakeBoyfriend or boyfriend

		if closeOnDeath then
			if goFunVal == 1 then
				love.window.showMessageBox("HAHAHA", "COME BACK SOON")
			elseif goFunVal == 2 then
				love.window.showMessageBox("YOU WANNA LEARN HOW TO DO A F INFINITE?", "LIGHT PUNCH, HEAVY PUNCH. MEDIUM KICK, HEAVY KICK.")
			elseif goFunVal == 3 then
				love.window.showMessageBox("REMEMBER", "BLUE DOWN ARROWS")
			elseif goFunVal == 4 then
				love.window.showMessageBox("HAHAHA", "COME BACK SOON")
			elseif goFunVal == 5 then
				love.window.showMessageBox("HAHAHA", "COME BACK SOON")
			end
			love.event.quit()
		end

		if tooFestDeath then
			tooFestDeathVid = love.graphics.newVideo("videos/BfFuckingDies.ogv") --i cant fucking figure it out
		end

		fromState = from

		if inst then inst:stop() end
		voices:stop()
		
		if tooFestDeath then
			boyfriend.sizeX = 0.00000001
			tooFestDeathVid:play()
			boyfriend:animate("dies", false) --Just in-case
		else
			audio.playSound(sounds["death"])

			if BFcanDie then
				boyfriend:animate("dies", false)
			else
				boyfriend:animate("miss left", false)
			end

			Timer.clear()

			Timer.tween(
				2,
				cam,
				{x = -boyfriend.x, y = -boyfriend.y, sizeX = camScale.x, sizeY = camScale.y},
				"out-quad",
				function()
					inst = love.audio.newSource("music/game-over.ogg", "stream")
					inst:setLooping(true)
					inst:play()

					if BFcanDie then
						boyfriend:animate("dead", true)
					else
						boyfriend:animate("miss up", false)
					end
				end
			)
		end
	end,

	update = function(self, dt)
		local boyfriend = fakeBoyfriend or boyfriend

		if not graphics.isFading() then
			if input:pressed("confirm") then
				if inst then inst:stop() end -- In case inst is nil and "confirm" is pressed before game over music starts

				inst = love.audio.newSource("music/game-over-end.ogg", "stream")
				inst:play()

				Timer.clear()

				cam.x, cam.y = -boyfriend.x, -boyfriend.y

				if BFcanDie then
					boyfriend:animate("dead confirm", false)
				else
					boyfriend:animate("idle", false)
				end

				graphics.fadeOut(
					3,
					function()
						Gamestate.pop()

						fromState:load()
					end
				)
			elseif input:pressed("gameBack") then
				status.setLoading(true)

				if tooFestDeath then
					tooFestDeath = false
				end

				graphics.fadeOut(
					0.5,
					function()
						Gamestate.pop()

						Gamestate.switch(menu)

						status.setLoading(false)
					end
				)
			end
		end

		boyfriend:update(dt)
	end,

	draw = function(self)
		local boyfriend = fakeBoyfriend or boyfriend

		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)

			love.graphics.push()
				love.graphics.scale(cam.sizeX, cam.sizeY)
				love.graphics.translate(cam.x, cam.y)

				boyfriend:draw()
			love.graphics.pop()
		love.graphics.pop()
	end
}
