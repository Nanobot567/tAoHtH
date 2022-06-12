import "CoreLibs/graphics"
import "menu"

local gfx = playdate.graphics

tutorStep = 1
justGotIn = true

tutorImg = gfx.image.new("img/tutorial/1")

function tutorUpdate()
    if justGotIn == true then
        tutorImg = gfx.image.new("img/tutorial/1")
        tutorImg:draw(0,0)
        justGotIn = false
    end

    if playdate.buttonJustPressed("right") then
        if tutorStep == 5 then
            gfx.clear(gfx.kColorWhite)
            setupMenu()
            inTutorial = false
        else
            tutorStep += 1
        end
        tutorImg:load("img/tutorial/"..tutorStep)
        tutorImg:draw(0,0)
    elseif playdate.buttonJustPressed("left") then
        if tutorStep == 1 then
        else
            tutorStep -= 1
        end
        tutorImg:load("img/tutorial/"..tutorStep)
        tutorImg:draw(0,0)
    end

    if inTutorial == false then
        gfx.clear(gfx.kColorWhite)
        setupMenu()
        drawStatusBarIcons()
    end

    
end