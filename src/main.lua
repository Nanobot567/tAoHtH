import "CoreLibs/graphics"
import "sky"
import "horse"
import "statusBar"

local gfx = playdate.graphics

gfx.setColor(gfx.kColorWhite)

function playdate.update()
    horseUpdate()
    sunUpdate()
    cloudUpdate()
    statusUpdate()
    playdate.drawFPS(380,0)
end