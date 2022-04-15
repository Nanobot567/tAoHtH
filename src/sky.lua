import "CoreLibs/graphics"

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
    rot += 1
    if rot == 360 then
        rot = 0
    end
    sun:drawRotated(15, 15, rot, 2, 2)
end

function cloudUpdate()
    cloudx += 2
    if cloudx == 420 then
        cloudx = -70
    end
    cloud:drawScaled(cloudx, 20, 1.2, 1.2)
end