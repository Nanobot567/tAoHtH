import "CoreLibs/graphics"
import "status"

local gfx = playdate.graphics

mic = gfx.image.new("img/other/mic")

buffer = playdate.sound.sample.new(3, playdate.sound.kFormat16bitMono)
horseIdleSound = playdate.sound.sampleplayer.new(buffer)

function recSound(sound)
    mic:draw(360,200)
    -- if sound == "idle" then
    playdate.wait(1000)

    playdate.sound.micinput.recordToSample(buffer, doneRec)
    -- end
end

function doneRec(sound)
    horseIdleSound = playdate.sound.sampleplayer.new(buffer)
    gfx.fillRect(360,200,30,30)
    playdate.stop()
    print("done")
    horseIdleSound:play()
    setStatusText("playing new horseIdleSound...")
    playdate.wait(3000)
    playdate.start()
end

function playSound(sound)
    if sound == "idle" then
        horseIdleSound:play()
    end
end