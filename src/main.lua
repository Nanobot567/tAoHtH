import "CoreLibs/graphics"
import "sky"
import "horse"
import "status"
import "menu"

local gfx = playdate.graphics

gfx.setColor(gfx.kColorWhite)

function playdate.update()
    horseUpdate()
    sunUpdate()
    cloudUpdate()
    statusUpdate()
    menuUpdate()
    playdate.drawFPS(380,0)
end