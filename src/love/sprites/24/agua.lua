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

return graphics.newSprite(
	love.graphics.newImage(graphics.imagePath("24/stage/good/agua")),
	-- Automatically generated from agua.xml
	{
		{x = 40, y = 40, width = 4085, height = 1345, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: agua0000
		{x = 40, y = 1425, width = 4085, height = 1345, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: agua0001
		{x = 40, y = 2810, width = 4085, height = 1345, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: agua0002
		{x = 40, y = 4195, width = 4085, height = 1345, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0} -- 4: agua0003
	},
	{
		["anim"] = {start = 1, stop = 4, speed = 24, offsetX = 0, offsetY = 0}
	},
	"anim",
	true
)
