import "CoreLibs/graphics"
import "horse"
import "sounds"
import "saveload"
import "status"

local gfx = playdate.graphics
inSettings = false

cursor = {300,115}

gfx.setColor(gfx.kColorBlack)

burger = gfx.image.new("img/sustenance/burger")
water = gfx.image.new("img/sustenance/water")
wrench = gfx.image.new("img/menu/wrench")
back = gfx.image.new("img/menu/back")
mic = gfx.image.new("img/other/mic")
saveico = gfx.image.new("img/menu/save")
loadico = gfx.image.new("img/menu/load")
delsave = gfx.image.new("img/menu/delsave")
-- burger:load("img/sustenance/burger")
-- water:load("img/sustenance/water")
-- wrench:load("img/menu/wrench")
-- back:load("img/menu/back")
-- mic:load("img/other/mic")
-- saveico:load("img/menu/save")
-- loadico:load("img/menu/load")
-- delsave:load("img/menu/delsave")


gfx.drawRect(cursor[1],cursor[2],15,15)

burger:draw(300,115)
water:draw(315,115)
wrench:draw(375,145)


function menuUpdate()
    gfx.setColor(gfx.kColorBlack)
    gfx.drawRect(295,110,100,55)
    gfx.setColor(gfx.kColorWhite)
    if playdate.buttonJustPressed("left") and okToMoveCursor("left") then
        drawCursor()
        cursor[1] -= 15
    elseif playdate.buttonJustPressed("right") and okToMoveCursor("right") then
        drawCursor()
        cursor[1] += 15
    elseif playdate.buttonJustPressed("down") and okToMoveCursor("down") then
        drawCursor()
        cursor[2] += 15
    elseif playdate.buttonJustPressed("up") and okToMoveCursor("up") then
        drawCursor()
        cursor[2] -= 15

    elseif playdate.buttonJustPressed("a") then
        if inSettings == true then
            if cursorAt(0,0) then
                recSound()
            elseif cursorAt(3,0) then
                save()
            elseif cursorAt(4,0) then
                load()
                refreshValues()
            elseif cursorAt(5,0) then
                deleteSave()
            end
        else
            if cursorAt(0,0) then
                changeHorse("hunger",5,"-")
            elseif cursorAt(1,0) then
                changeHorse("thirst",5,"-")
            end
        end

        if cursorAt(5,2) then
            inSettings = not inSettings
            redrawMenuIcons(inSettings)
        end
    end
    gfx.setColor(gfx.kColorBlack)
    drawCursor()
    gfx.setColor(gfx.kColorWhite)
end

function cursorAt(x,y)
    x = (x*15)+300
    y = (y*15)+115
    if cursor[1] == x and cursor[2] == y then
        return true
    end
end

function drawCursor()
    gfx.drawRect(cursor[1],cursor[2],15,15)
end

function redrawMenuIcons(isSettings)
    gfx.fillRect(300,115,100,30)
    if isSettings then
        mic:drawScaled(300,115,0.5)
        saveico:draw(345,115)
        loadico:draw(360,115)
        delsave:draw(375,115)
        back:draw(375,145)
    else
        burger:draw(300,115)
        water:draw(315,115)
        wrench:draw(375,145)
    end
end

function okToMoveCursor(direction)
    if direction == "left" then
        if cursor[1] == 300 then
            return false
        else
            return true
        end
    elseif direction == "right" then
        if cursor[1] == 375 then
            return false
        else
            return true
        end
    elseif direction == "up" then
        if cursor[2] == 115 then
            return false
        else
            return true
        end
    elseif direction == "down" then
        if cursor[2] == 145 then
            return false
        else
            return true
        end
    end
end