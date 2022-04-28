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
hungerTick = 0
thirstTick = 0
soundTick = 0

randomSoundPlayTick = math.random(100,1000)
-- statuses: i-idle s-sleeping

function changeHorse(stat, amount, operator)
    gfx.setColor(gfx.kColorWhite)
    if stat == "hunger" then
        gfx.fillRect(0,110,hunger*10,20)
        if operator == "+" then
            hunger += amount
        elseif operator == "-" then
            horseStatus = "i"
            hunger -= amount
        else
            hunger = amount
        end
    elseif stat == "thirst" then
        gfx.fillRect(0,130,thirst*10,20)
        if operator == "+" then
            thirst += amount
        elseif operator == "-" then
            thirst -= amount
        else
            thirst = amount
        end

        if hunger <= 0 then
            hunger = 0
        end
        if thirst <= 0 then
            thirst = 0
        end
    end
end

function horseUpdate()
    hungerTick += 1
    thirstTick += 1
    soundTick += 1
    if thirstTick == 60 then
        if thirst == 15 then
        else
            thirst += 1
        end
        thirstTick = 0
    end

    if hungerTick == 100 then
        if hunger == 16 then
        else
            hunger += 1
            hungerTick = 0
        end
    end

    if soundTick == randomSoundPlayTick then
        randomSoundPlayTick = math.random(100,1000)
        playSound("idle")
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