return graphics.newSprite(
	love.graphics.newImage(graphics.imagePath("archie'nt/Floor")),

	-- Automatically generated from Floor.xml
	{
		{x = 0, y = 0, width = 5680, height = 411, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: floor blue0000
		{x = 0, y = 411, width = 5680, height = 411, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0} -- 2: floor yellow0000
	},
	{
		["blue"] = {start = 1, stop = 1, speed = 24, offsetX = 0, offsetY = 0},
		["yellow"] = {start = 2, stop = 2, speed = 24, offsetX = 0, offsetY = 0}
	},
	"yellow",
	true
)
