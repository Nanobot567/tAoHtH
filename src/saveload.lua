import "horse"
import "status"
import "sounds"

askingForConfirmation = false

function save(manuallySaved)
    dataList = {"hunger";hunger,"anger";anger,"thirst";thirst,"happiness";happiness,"horseStatus";horseStatus,"time";time,"isNight";isNight,"epileptic";epileptic,"name";horseName}
    playdate.datastore.write(dataList,"save")
    
    if manuallySaved == true then
        setStatusText("saved game.")
        playdate.wait(1000)
    end
end

function loadSave(manuallyLoaded)
    dataJson = playdate.datastore.read("save")
    if dataJson == nil then
        return false
    else
        hunger = dataJson[2]
        anger = dataJson[4]
        thirst = dataJson[6]
        happiness = dataJson[8]
        horseStatus = dataJson[10]
        time = dataJson[12]
        isNight = dataJson[14]
        epileptic = dataJson[16]
        horseName = dataJson[18]
        return true
    end

    if manuallyLoaded == true then
        setStatusText("loaded save.json.")
        playdate.wait(1000)
    end
end

function deleteSave()
    setStatusText("are you sure? (a = yes, b = no)")
    askingForConfirmation = true
    bgmaction("pause","main")
    playdate.stop()
end