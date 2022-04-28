import "horse"
import "status"

askingForConfirmation = false

function save()
    dataList = {"hunger";hunger,"anger";anger,"thirst";thirst,"happiness";happiness,"horseStatus";horseStatus}
    playdate.datastore.write(dataList,"save")
end

function load()
    dataJson = playdate.datastore.read("save")
    if dataJson == nil then
        print("no save found")
    else
        hunger = dataJson[2]
        anger = dataJson[4]
        thirst = dataJson[6]
        happiness = dataJson[8]
        horseStatus = dataJson[10]
    end
end

function deleteSave()
    playdate.datastore.delete("save")
    setStatusText("are you sure? (a = yes, b = no)")
    askingForConfirmation = true
    playdate.stop()
end

function playdate.AButtonDown()
    if askingForConfirmation then
        playdate.start()
        setStatusText("SAVE DELETED! please reopen tAoHtH.")
        playdate.stop()
        saveOnExit = false
    end
end

function playdate.BButtonDown()
    if askingForConfirmation then
        playdate.start()
        askingForConfirmation = false
    end
end