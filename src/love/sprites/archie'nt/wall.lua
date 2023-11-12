
return graphics.newSprite(
	love.graphics.newImage(graphics.imagePath("archie'nt/Wall")),

		-- Automatically generated from Wall.xml
	{
		{x = 0, y = 0, width = 5680, height = 2533, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Wall Broken instance 10000
		{x = 0, y = 2533, width = 5680, height = 2534, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0} -- 2: Wall instance 10000
	},
	{
		["broken"] = {start = 1, stop = 30, speed = 24, offsetX = 0, offsetY = 0},
		["not broken"] = {start = 31, stop = 60, speed = 24, offsetX = 0, offsetY = 0}
	},
	"broken",
	true
)
