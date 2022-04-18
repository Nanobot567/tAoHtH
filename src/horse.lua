import "CoreLibs/graphics"

local gfx = playdate.graphics

gfx.setColor(gfx.kColorWhite)

horse_idle = gfx.image.new("img/horse_idle")
horse_idle:load("img/horse_idle")
-- horse_idle

hunger = 0
anger = 0
thirst = 0
happiness = 0
horseStatus = "i"
tick = 0
-- statuses: i-idle s-sleeping

function changeHorse(stat, amount, operator)
    if stat == "hunger" then
        if operator == "+" then
            hunger += amount
        elseif operator == "-" then
            hunger -= amount
        else
            hunger = amount
        end
    elseif stat == "thirst" then
        if operator == "+" then
            thirst += amount
        elseif operator == "-" then
            thirst -= amount
        else
            thirst = amount
        end
    end
end

function horseUpdate()
    tick += 1
    if tick == 50 then
        if thirst == 15 then
        else
            thirst += 1
        end
    elseif tick == 100 then
        hunger += 1
        tick = 0
    end

    if hunger == 0 or thirst == 0 then
        happiness = 2
    elseif hunger == 5 or thirst == 5 then
        happiness = 1
    elseif hunger == 7 or thirst == 7 then
        happiness = 0
    elseif hunger == 10 or thirst == 10 then
        happiness = -1
    elseif hunger == 14 or thirst == 14 then
        happiness = -2
    end
    
    if hunger == 15 then
        horseStatus = "ca"
    end
    
    if horseStatus == "i" or horseStatus == "ca" then
        horse_idle:drawCentered(200,160)
    end

    if hunger == 16 then
        horseStatus = "i"
    end
end

function gimmeStats()
    return hunger,anger,thirst,happiness,horseStatus
end