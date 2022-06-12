import "CoreLibs/graphics"
import "CoreLibs/crank"
import "horse"

local gfx = playdate.graphics

gfx.setColor(gfx.kColorWhite)

cloudx = -70

local rot = 0
time = 0
isNight = 0

cloud = gfx.image.new("img/sky/cloud")
sun = gfx.image.new("img/sky/sun")

function skyUpdate()
    gfx.fillRect(0,0,400,60)
    if horseStatus == "finalform" then
        time += 10
    else
        time += 1
    end
    
    if time == 1000 then
        isNight = true
    elseif time >= 2000 then
        isNight = false
        time = 0
    end

    if isNight then
        sun:load("img/sky/moon")
    else
        sun:load("img/sky/sun")
    end
    if playdate.isCrankDocked() == true or horseStatus == "finalform" then
        if horseStatus == "finalform" then
            cloudx += 20
            rot += 5
        else
            cloudx += 2
            rot += 1
        end

        if cloudx >= 420 then
            cloudx = -70
        end

        if rot == 360 then
            rot = 0
        end
    else
        if horseStatus ~= "finalform" then
            rot = playdate.getCrankPosition()
            if playdate.getCrankTicks(90) == 1 then
                cloudx += 1
                if cloudx >= 420 then
                    cloudx = -70
                end
            elseif playdate.getCrankTicks(90) == -1 then
                cloudx -= 1
                if cloudx >= 420 then
                    cloudx = -70
                end
            end
        end
    end

    sun:drawRotated(15, 15, rot, 2, 2)
    cloud:drawScaled(cloudx, 20, 1.2, 1.2)
end