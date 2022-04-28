import "CoreLibs/graphics"
import "sky"
import "horse"
import "status"
import "menu"
import "saveload"


saveOnExit = true

local gfx = playdate.graphics

gfx.setColor(gfx.kColorWhite)

getmetatable('').__index = function(str,i) return string.sub(str,i,i) end

load()

function playdate.update()
    horseUpdate()
    sunUpdate()
    cloudUpdate()
    statusUpdate()
    menuUpdate()
    playdate.drawFPS(380,0)
end

function playdate.gameWillTerminate()
    if saveOnExit == true then
        save()
    end
end