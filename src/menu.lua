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
ball = gfx.image.new("img/menu/bol")
wrench = gfx.image.new("img/menu/wrench")
back = gfx.image.new("img/menu/back")
mic = gfx.image.new("img/other/mic")
renameico = gfx.image.new("img/menu/rename")
saveico = gfx.image.new("img/menu/save")
loadico = gfx.image.new("img/menu/load")
delsave = gfx.image.new("img/menu/delsave")
battleicon = gfx.image.new("img/menu/attack")

function setupMenu()
    gfx.drawRect(cursor[1],cursor[2],15,15)

    redrawMenuIcons(isSettings)
end


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
            if horseStatus ~= "finalform" then
                if cursorAt(0,0) then
                    recSound()
                elseif cursorAt(3,0) then
                    save(true)
                elseif cursorAt(4,0) then
                    loadSave(true)
                    refreshValues()
                elseif cursorAt(5,0) then
                    deleteSave()
                elseif cursorAt(0,1) then
                    changeHorseName()
                end
            end
        else
            if horseStatus ~= "finalform" then
                if cursorAt(0,0) then
                    changeHorse("hunger",5,"-")
                elseif cursorAt(1,0) then
                    changeHorse("thirst",5,"-") 
                elseif cursorAt(2,0) then
                    playWithHorse()
                elseif cursorAt(3,0) then
                    talkWithHorse()
                end
            else
                if cursorAt(0,0) then
                    attackHorse()
                elseif cursorAt(1,0) then
                    defAgainstHorse()
                elseif cursorAt(2,0) then
                    talkToHorse()
                elseif cursorAt(3,0) then
                    consumeSustenance()
                end
            end
        end

        if horseStatus ~= "finalform" then
            if cursorAt(5,2) then
                inSettings = not inSettings
                redrawMenuIcons(inSettings)
            end
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
    gfx.fillRect(300,115,89,30)
    if isSettings then
        mic:drawScaled(300,115,0.5)
        renameico:draw(300,130)
        saveico:draw(345,115)
        loadico:draw(360,115)
        delsave:draw(375,115)
        back:draw(375,145)
    else
        if horseStatus == "finalform" then
            battleicon:load("img/menu/attack")
            battleicon:draw(300,115)
            battleicon:load("img/menu/defend")
            battleicon:draw(315,115)
            if talkBtnEnabled == true then
                battleicon:load("img/menu/talk")
            else
                battleicon:load("img/menu/talkbroken")
            end
            battleicon:draw(330,115)
            battleicon:load("img/sustenance/burger")
            battleicon:draw(345,115)
            -- ..and so on
        else
            burger:draw(300,115)
            water:draw(315,115)
            ball:draw(330,115)
            battleicon:load("img/menu/talk")
            battleicon:draw(345,115)
            battleicon:load("img/menu/attack")
            wrench:draw(375,145)
        end
    end
end

function okToMoveCursor(direction)
    if kbOpen == false then
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
    else
        return false
    end
end