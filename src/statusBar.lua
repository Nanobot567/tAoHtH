import "CoreLibs/graphics"
import "horse"

local gfx = playdate.graphics

gfx.setColor(gfx.kColorWhite)

local statText = ""

function statusUpdate()
    hunger,anger,thirst,happiness,horseStatus = gimmeStats()

    gfx.setColor(gfx.kColorBlack)
    gfx.drawRect(0,110,100,20)
    gfx.fillRect(0,110,hunger*10,20)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0,218,gfx.getTextSize(statText))



    if hunger == 10 then
        statText = "your horse may resort to cannibalism soon"
    elseif hunger == 15 then
        statText = "your horse has resorted to cannibalism."
        gfx.setColor(gfx.kColorWhite)
        gfx.fillRect(0,110,hunger*10,20)
        changeHorse("hunger","10","-")
    elseif anger == 5 then
        statText = "you should appease your horse!"
    elseif anger == 10 then
        statText = "your horse has gone crazy!"
    else
        statText = "your horse is fine."
    end
    gfx.drawText(statText,0,218)
end