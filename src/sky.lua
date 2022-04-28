import "CoreLibs/graphics"
import "CoreLibs/crank"

local gfx = playdate.graphics

gfx.setColor(gfx.kColorWhite)

cloudx = -70

local rot = 0
local frame = 0

cloud = gfx.image.new("img/cloud")
cloud:load("img/cloud")
sun = gfx.image.new("img/sun")
sun:load("img/sun")

function sunUpdate()
    gfx.fillRect(0,0,400,60)
    if playdate.isCrankDocked() == true then
        rot += 1
        if rot == 360 then
            rot = 0
        end
    else
        rot = playdate.getCrankPosition()
    end
    sun:drawRotated(15, 15, rot, 2, 2)
end

function cloudUpdate()
    if playdate.isCrankDocked() == true then
        cloudx += 2
        if cloudx >= 420 then
            cloudx = -70
        end
    else
        if playdate.getCrankTicks(70) == 1 then
            cloudx += 1
            if cloudx >= 420 then
                cloudx = -70
            end
        elseif playdate.getCrankTicks(70) == -1 then
            cloudx -= 1
            if cloudx >= 420 then
                cloudx = -70
            end
        end
    end
    cloud:drawScaled(cloudx, 20, 1.2, 1.2)
end