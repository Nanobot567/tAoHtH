import "sounds"
import "horse"
import "CoreLibs/ui"
import "CoreLibs/crank"

yourHP = 100
horseHP = 250
cranking = false
power = 0
actionType = 0
defPower = 0
horseDmgModifier = 0
foodsRemaining = 5
gotAttackedTimer = nil
talkBtnEnabled = true

horseHPBarX = 149
horseHPBarY = 70

talkTextID = 0

local gfx = playdate.graphics

crashFnt = gfx.font.new("fnt/Roobert-10-Bold")

thxImg = gfx.image.new("img/other/thx")

function setupBattle()
    bgmaction("stop","main")
    setStatusText("your horse has had enough.")
    horseStatus = "finalform"
    inSettings = false
    askingForTalkText = false
    redrawMenuIcons(false)
    drawStatusBarIcons()
    playdate.keyboard.hide()
    playdate.wait(5000)
    bgmaction("play","finalform")
end

function updateBattle()
    gfx.setColor(gfx.kColorBlack)
    gfx.drawRect(295,164,100,20)
    gfx.drawRect(horseHPBarX,horseHPBarY,100,10)
    gfx.fillRect(horseHPBarX,horseHPBarY,(horseHP/2.5),10)
    gfx.setColor(gfx.kColorWhite)
    gfx.drawText("your HP: "..yourHP, 300, 165, 100, 20)

    if yourHP <= 0 then
        bgmaction("stop","finalform")
        setStatusText("nil")
        playdate.wait(5000)
        gfx.clear(gfx.kColorWhite)
        crashFnt:drawText("main.lua:1: universe not present",1,1)
        crashFnt:drawText("stack traceback:",1,16)
        crashFnt:drawText("nil",11,31)
        playdate.datastore.delete("save")
        saveOnExit = false
        playdate.stop()
    elseif horseHP <= 0 then
        bgmaction("stop","finalform")
        gfx.fillRect(0,58,278,182)
        setTextAndWait("the horse returns to its home, defeated.",6000)
        setTextAndWait("the universe is saved.",4000)
        setTextAndWait("you win.",2000)
        setTextAndWait("you beat the obomination.",1000)
        setTextAndWait("you saved the world.",500)
        setTextAndWait("you killed the horse.",250)
        setTextAndWait("the horse is gone forever.",125)
        setTextAndWait("you destroyed the system.",62)
        setTextAndWait("you became the system.",31)
        setTextAndWait("the enemies retreated.",15)
        setTextAndWait("everything is fine.",15)
        setTextAndWait("you are only collapsing.",15)
        setTextAndWait("you won't die.",15)
        setTextAndWait("the sky is red.",15)
        setTextAndWait("the moon is exploding.",15)
        setTextAndWait("the sun is getting larger.",15)
        setTextAndWait("the horse is coming back.",15)
        setTextAndWait("you gave in to the horse's power.",15)
        setTextAndWait("you have won, and are now free.",3000)
        gfx.clear(gfx.kColorBlack)
        thxImg:draw(0,0)
        playdate.datastore.delete("save")
        saveOnExit = false
        playdate.stop()
    end

    -- lcd display in center of screen to display dmg given to horse/dmg subtracted from horse attack
    -- maybe in a later update
    if gotAttackedTimer ~= nil then
        playdate.display.setOffset(math.random(-5,5), math.random(-5,5))
        if gotAttackedTimer.currentTime >= 800 then
            gotAttackedTimer = nil
            playdate.display.setOffset(0,0)
        end
    end
    
    if cranking and playdate.isCrankDocked() then
        playdate.ui.crankIndicator:update()
    elseif cranking == true and playdate.isCrankDocked() == false then
        if playdate.getCrankTicks(2) == 1 then
            power += 1
        end
        gfx.fillRect(310,185,90,55)
        if actionType == 1 then
            gfx.drawText("dmg: "..power,340,200)
        elseif actionType == 2 then
            gfx.drawText("def: "..power,345,200)
        end
        gfx.drawText(powerTimer.timeLeft,360,220)
    elseif cranking == false and power >= 1 then
        gfx.fillRect(310,185,90,55)
    end
end

function powerTimerDone()
    print("finished! power: "..power)
    if actionType == 1 then
        gfx.setColor(gfx.kColorWhite)
        gfx.fillRect(horseHPBarX,horseHPBarY,100,20)
        horseHP -= power
    elseif actionType == 2 then
        defPower = power
    end
    
    refreshBRText()
    attackTimer = playdate.timer.new(800,horseAttack)
    -- horseAttack()

    cranking = false
    actionType = 0
    power = 0
    defPower = 0
    powerTimer = nil
end

function attackHorse()
    if powerTimer == nil then
        playdate.ui.crankIndicator:start()
        powerTimer = playdate.timer.new(4000,powerTimerDone)
        actionType = 1
        cranking = true
    end
end

function defAgainstHorse()
    if powerTimer == nil then
        playdate.ui.crankIndicator:start()
        powerTimer = playdate.timer.new(4000,powerTimerDone)
        actionType = 2
        cranking = true
    end
end

function talkToHorse()
    if talkBtnEnabled == true then
        if talkTextID == 0 then
            setTextAndWait("you tell your horse to stop...",3000)
            setTextAndWait("...but it pretends not to notice.",3000)
        elseif talkTextID == 1 then
            setTextAndWait("you tell your horse that you'll take care of it...",3000)
            setTextAndWait("...but it only makes it angrier! +5 to horse damage!",3000)
            horseDmgModifier += 5
        elseif talkTextID == 2 then
            setTextAndWait("your horse is sick of talking to you...",3000)
            setTextAndWait("...and destroys your talk button.",3000)
            talkBtnEnabled = false
            redrawMenuIcons(false)
        end
        attackTimer = playdate.timer.new(800,horseAttack)
    end

    talkTextID += 1
    
    -- talk to horse, maybe mercy will be given..?
end

function consumeSustenance()
    if foodsRemaining > 0 then
        local recHP = math.random(10,50)
        if recHP + yourHP > 100 then
            setStatusText("you ate a [FOOD]. recovered "..100-yourHP.." HP!")
            yourHP = 100
        else
            yourHP += recHP
            setStatusText("you ate a [FOOD]. recovered "..recHP.." HP!")
        end

        playdate.wait(3000)
        refreshBRText()

        foodsRemaining -= 1
    else
        setStatusText("you're out of food!")
        playdate.wait(3000)
    end
    attackTimer = playdate.timer.new(800,horseAttack)
    -- eat one food, max 5, recovers 10-50 hp.
end

function horseAttack()
    rand = math.random(5,20)
    if rand > defPower then
        yourHP -= ((rand - defPower) + horseDmgModifier)
    elseif rand <= defPower then
        yourHP -= (1 + horseDmgModifier)
    end
    gotAttackedTimer = playdate.timer.new(1000)
    refreshBRText()
end

function refreshBRText()
    gfx.fillRect(310,185,90,55)
    gfx.fillRect(300,165,100,20)
end

function setTextAndWait(text, waitTime)
    setStatusText(text)
    playdate.wait(waitTime)
end