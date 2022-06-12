import "CoreLibs/graphics"
import "horse"
import "battle"

local gfx = playdate.graphics
statText = "your horse is fine."

gfx.setColor(gfx.kColorWhite)

happyMeter = gfx.image.new("img/hmeter/hmeter.0")
food = gfx.image.new("img/sustenance/burger")
water = gfx.image.new("img/sustenance/water")

angerNumbers = {20,21,22,23,24,25,26,27,28,29,30}

function drawStatusBarIcons()
    food:draw(0,95)
    water:draw(0,150)
end

drawStatusBarIcons()

function statusUpdate()
    hunger,anger,thirst,happiness,horseStatus = gimmeStats()

    if horseStatus == "finalform" then
        refreshValues()
    end

    if happiness == -2 then
        happyMeter:load("img/hmeter/hmeter.-2")
    elseif happiness == -1 then
        happyMeter:load("img/hmeter/hmeter.-1")
    elseif happiness == 0 then
        happyMeter:load("img/hmeter/hmeter.0")
    elseif happiness == 1 then
        happyMeter:load("img/hmeter/hmeter.1")
    elseif happiness == 2 then
        happyMeter:load("img/hmeter/hmeter.2")
    end
    
    if horseStatus == "ca" then
        happyMeter:load("img/hmeter/hmeter.cannibalism")
    elseif horseStatus == "cr" then
        happyMeter:load("img/hmeter/hmeter.crazy")
    elseif horseStatus == "finalform" then
        happyMeter:load("img/hmeter/hmeter.nil")
    end

    happyMeter:draw(185,80)

    gfx.fillRect(220,92,180,15)
    gfx.drawText("anger: "..anger,220,92)

    gfx.setColor(gfx.kColorBlack)
    gfx.drawRect(0,110,100,20)
    if horseStatus == "finalform" then
        if epileptic == true then
            hunger = 0
            thirst = 0
        else
            hunger = math.random(0,14)
            thirst = math.random(0,15)
        end
    end

    gfx.fillRect(0,110,hunger*10,20)
    gfx.drawRect(0,130,100,20)
    gfx.fillRect(0,130,thirst*10,20)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(0,218,gfx.getTextSize(statText))

    statText = horseName.." is fine."

    if horseStatus ~= "finalform" then
        if hunger >= 10 then
            statText = horseName.." may resort to cannibalism soon"
        end

        if hunger == 15 then
            statText = horseName.." has resorted to cannibalism."
        elseif hunger == 16 then
            gfx.setColor(gfx.kColorWhite)
            gfx.fillRect(0,110,hunger*10,20)
            changeHorse("hunger","11", "-")
        end
    end
    
    if anger >= 5 then
        statText = "you should appease "..horseName.."!"
    end

    if anger >= 10 then
        horseStatus = "cr"
        statText = horseName.." has gone crazy!"
    end
    
    if anger >= 15 then
        statText = horseName.." demands blood!"
        horseStatus = "needsblood"
    end
    
    for key,value in pairs(angerNumbers) do
        if anger == value then
            anger = 9001
            setupBattle()
        end
    end

    if anger >= 9001 then
        horseStatus = "finalform"
    end

    if horseStatus == "finalform" then
        statText = "your horse has had enough."
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