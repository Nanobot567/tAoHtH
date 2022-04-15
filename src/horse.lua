import "CoreLibs/graphics"

local gfx = playdate.graphics

gfx.setColor(gfx.kColorWhite)

horse_idle = gfx.image.new("img/horse_idle")
horse_idle:load("img/horse_idle")
-- horse_idle

hunger = 0
anger = 0
thirst = 0
happiness = "0"
horseStatus = 0
tick = 0
-- statuses: 0-idle 1-sleeping

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
    print("changed")
    print(hunger)
end

function horseUpdate()
    tick += 1
    if tick == 100 then
        hunger += 1
        tick = 0
    end
    if horseStatus == 0 then
        horse_idle:drawCentered(200,160)
    end
end

function gimmeStats()
    return hunger,anger,thirst,happiness,horseStatus
end