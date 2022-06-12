import "CoreLibs/graphics"
import "sky"
import "horse"
import "status"
import "menu"
import "saveload"
import "epilepsy"
import "buttons"
import "tutor"

saveOnExit = true
debug = false

local gfx = playdate.graphics

gfx.setColor(gfx.kColorWhite)

getmetatable('').__index = function(str,i) return string.sub(str,i,i) end

hasSave = loadSave(false)

bgmaction("play","main")

if hasSave == true then
    setupMenu()
end

function playdate.update()
    playdate.timer.updateTimers()

    if hasSave == false then
        checkForEpilepsy()
        snd = playdate.sound.sample.new(3, playdate.sound.kFormat16bitMono)
        snd:save("idle")
        snd:save("idle.wav")
    elseif inTutorial == true then
        tutorUpdate()
    else
        horseUpdate()
        skyUpdate()
        statusUpdate()
        menuUpdate()
    end

    if horseStatus == "finalform" then
        updateBattle()
    end

    if debug == true then
        playdate.drawFPS(385,0)
    end

    if playdate.keyboard.isVisible() == false and kbOpen == true then
        gfx.clear(gfx.kColorWhite)
        redrawMenuIcons(inSettings)
        drawStatusBarIcons()
        kbOpen = false

        if askingForTalkText == true and talkText ~= "" then
            setStatusText("your horse is responding...")
            playdate.wait(3000)
            horseRespond()
        end
    elseif kbOpen == true then
        if askingForTalkText == true then
            setStatusText(playdate.keyboard.text)
            talkText = playdate.keyboard.text
        else
            horseName = playdate.keyboard.text
        end
    end

end

function playdate.gameWillTerminate()
    if saveOnExit == true then
        if horseStatus == "finalform" then
            anger = 20
        end
        save(false)
    end
end