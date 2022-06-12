import "CoreLibs/graphics"
import "CoreLibs/keyboard"
import "CoreLibs/animator"
import "CoreLibs/easing"

local gfx = playdate.graphics

gfx.setColor(gfx.kColorWhite)

horse = gfx.image.new("img/horse/horse_idle")
-- horse_idle

horseName = "your horse"
hunger = 0
anger = 0
thirst = 0
happiness = 0
horseStatus = "i"
hungerTick = 0
thirstTick = 0
soundTick = 0

needsBloodFlash = false
kbOpen = false

blackWhite = false

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
    if horseStatus ~= "finalform" then
        hungerTick += 1
        thirstTick += 1
    end
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

    if soundTick >= randomSoundPlayTick then
        randomSoundPlayTick = math.random(200,1000)
        soundTick = 0
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

    if hunger == 16 then
        anger += 1
        horseStatus = "i"
    end
    
    if horseStatus == "i" or horseStatus == "ca" then
        horse:load("img/horse/horse_idle")
    elseif horseStatus == "cr" then
        horse:load("img/horse/horse_cr")
    
    elseif horseStatus == "needsblood" then
        if epileptic == false then
            blackWhite = not blackWhite
            if blackWhite == true then
                horse:load("img/horse/horse_needsblood2")
            else
                horse:load("img/horse/horse_needsblood")
            end
        end
    end

    if horseStatus == "finalform" and horseHP > 0 then
        horse:load("img/horse/horse_finalform")
        if horseHP < 20 then
            horse:drawCentered(math.random(168,232),math.random(128,192))
        else
            horse:drawCentered(math.random(198,202),math.random(158,162))
        end
    else
        horse:drawCentered(200,160)
    end
end

function playWithHorse()
    value = math.random(1,2)
    if value == 0 then
        respondTextDisplay("your horse doesn't want to play right now.")
        
    else
        if anger == 0 then
        else
            anger -= 1
        end

        if anger < 10 then
            horseStatus = "i"
        elseif anger == 14 then
            horseStatus = "cr"
        end
        respondTextDisplay("you have sucessfully played with your horse. -1 anger.")
        
    end
end

function gimmeStats()
    return hunger,anger,thirst,happiness,horseStatus
end

function changeHorseName()
    kbOpen = true
    playdate.keyboard.show(horseName)
end

function talkWithHorse()
    kbOpen = true
    playdate.keyboard.show()
    askingForTalkText = true
end

function horseRespond()
    askingForTalkText = false
    if (string.find(talkText, "dumb") or string.find(talkText, "stupid") or string.find(talkText, "idiot")) and (string.find(talkText, horseName) or string.find(talkText, "you")) then
        respondTextDisplay("your horse hates you now. +5 anger.")
        anger += 5
    elseif string.find(talkText, "fart") or string.find(talkText, "toot") then
        respondTextDisplay("your horse agrees that farts are hilarious.")
    elseif string.find(talkText, "death") or string.find(talkText, "dying") or string.find(talkText, "die") then
        respondTextDisplay("your horse thinks death is -1000% unfunny.")
    elseif string.find(talkText, "how") or string.find(talkText, "who") or string.find(talkText, "which") or string.find(talkText, "when") or string.find(talkText, "where") then
        respondTextDisplay("your horse doesn't know how to answer that.")
    elseif string.find(talkText, horseName) then
        respondTextDisplay("your horse agrees that "..horseName.." is its name.")
    elseif string.find(talkText, "favorite") then
        if string.find(talkText,"food") then
            respondTextDisplay("your horse's favorite food is carrots.")
        elseif string.find(talkText,"drink") or string.find(talkText,"soda") then
            respondTextDisplay("your horse's favorite drink is coca-cola.")
        else
            respondTextDisplay("your horse has no idea how to respond to that.")
        end
    elseif string.find(talkText,"hello") then
        respondTextDisplay("your horse says hi.")
    else
        respondTextDisplay("your horse is at a loss for words.")
    end
end

function respondTextDisplay(text)
    setStatusText(text)
    playdate.wait(3000)
end