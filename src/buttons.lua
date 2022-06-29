import "menu"
import "sounds"

function playdate.AButtonDown()
    if askingForConfirmation == true then
        playdate.start()
        playdate.datastore.delete("save")
        setStatusText("SAVE DELETED! please reopen tAoHtH.")
        playdate.stop()
        saveOnExit = false
    elseif checkingForEpilepsy then
        epileptic = true
        checkingForEpilepsy = false
        hasSave = true
        playdate.graphics.clear(playdate.graphics.kColorWhite)
        inTutorial = true
        save(false)
    elseif waitingForOkInSVT then
        if svtMode == 0 then
            svtMode += 1
        end
    end
end

function playdate.BButtonDown()
    if askingForConfirmation == true then
        bgmaction("play","main")
        playdate.start()
        askingForConfirmation = false
    elseif checkingForEpilepsy then
        epileptic = false
        checkingForEpilepsy = false
        hasSave = true
        playdate.graphics.clear(playdate.graphics.kColorWhite)
        inTutorial = true
        save(false)
    end
end

function playdate.BButtonHeld()
    if playdate.buttonIsPressed("up") then
        debug = not debug
    elseif playdate.buttonIsPressed("down") then
        editingSV = true
    end
end