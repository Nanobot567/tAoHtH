import "CoreLibs/graphics"
import "horse"

local gfx = playdate.graphics
statText = "your horse is fine."

gfx.setColor(gfx.kColorWhite)

hm2 = gfx.image.new("img/hmeter/hmeter.-2")
hm1 = gfx.image.new("img/hmeter/hmeter.-1")
h0 = gfx.image.new("img/hmeter/hmeter.0")
h1 = gfx.image.new("img/hmeter/hmeter.1")
h2 = gfx.image.new("img/hmeter/hmeter.2")
hca = gfx.image.new("img/hmeter/hmeter.cannibalism")
hcr = gfx.image.new("img/hmeter/hmeter.crazy")
food = gfx.image.new("img/sustenance/burger")
water = gfx.image.new("img/sustenance/water")

food:draw(0,95)
water:draw(0,150)

function statusUpdate()
    hunger,anger,thirst,happiness,horseStatus = gimmeStats()

    if happiness == -2 then
        hm2:load("img/hmeter/hmeter.-2")
        hm2:draw(185,80)
    elseif happiness == -1 then
        hm1:load("img/hmeter/hmeter.-1")
        hm1:draw(185,80)
    elseif happiness == 0 then
        h0:load("img/hmeter/hmeter.0")
        h0:draw(185,80)
    elseif happiness == 1 then
        h1:load("img/hmeter/hmeter.1")
        h1:draw(185,80)
    elseif happiness == 2 then
        h2:load("img/hmeter/hmeter.2")
        h2:draw(185,80)
    end
    
    if horseStatus == "ca" then
        hca:load("img/hmeter/hmeter.cannibalism")
        hca:draw(185,80)
    elseif horseStatus == "cr" then
        hcr:load("img/hmeter/hmeter.crazy")
        hcr:draw(185,80)

    end

    gfx.setColor(gfx.kColorBlack)
    gfx.drawRect(0,110,100,20)
    gfx.fillRect(0,110,hunger*10,20)
    gfx.drawRect(0,130,100,20)
    gfx.fillRect(0,130,thirst*10,20)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0,218,gfx.getTextSize(statText))

    statText = "your horse is fine."


    if hunger >= 10 then
        statText = "your horse may resort to cannibalism soon"
    end

    if hunger == 15 then
        statText = "your horse has resorted to cannibalism."
    elseif hunger == 16 then
        gfx.setColor(gfx.kColorWhite)
        gfx.fillRect(0,110,hunger*10,20)
        changeHorse("hunger","11", "-")
    end
    
    if anger == 5 then
        statText = "you should appease your horse!"
    elseif anger == 10 then
        statText = "your horse has gone crazy!"
    end

    gfx.drawText(statText,0,218)
end

function setStatusText(text)
    statText = text
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0,218,400,22)
    gfx.drawText(statText,0,218)
end

function refreshValues()
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0,110,160,20)
    gfx.fillRect(0,130,150,20)
end