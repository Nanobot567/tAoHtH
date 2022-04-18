import "CoreLibs/graphics"

local gfx = playdate.graphics

gfx.setColor(gfx.kColorBlack)

function menuUpdate()
    gfx.setColor(gfx.kColorBlack)
    gfx.drawRect(300,110,95,50)
    gfx.setColor(gfx.kColorWhite)
    if playdate.buttonJustPressed("left") then
        print("left")
    elseif playdate.buttonJustPressed("right") then
        print("right")
    elseif playdate.buttonJustPressed("down") then
        print("down")
    elseif playdate.buttonJustPressed("up") then
        print("up")
    end
end