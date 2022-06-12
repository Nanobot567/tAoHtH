import "CoreLibs/graphics"
import "status"

local gfx = playdate.graphics

mic = gfx.image.new("img/other/mic")

buffer = playdate.sound.sample.new(3, playdate.sound.kFormat16bitMono)
bgm = playdate.sound.fileplayer.new("mus/main")
recBeep = playdate.sound.sample.new("mus/recBeep")

function recSound(sound)
    mic:draw(360,200)
    -- if sound == "idle" then
    bgmaction("pause","main")
    playdate.wait(500)
    recBeep:play()
    playdate.wait(1100)
    gfx.drawText("REC",361,185)

    playdate.sound.micinput.recordToSample(buffer, doneRec)
    -- end
end

function doneRec(sound)
    sound:save("idle")
    sound:save("idle.wav")
    gfx.fillRect(360,180,30,50)
    playdate.stop()
    print("done")
    sound:play()
    setStatusText("playing new horseIdleSound...")
    playdate.wait(3000)
    bgmaction("play","main")
    playdate.start()
end

function playSound(sound)
    if sound == "idle" then
        snd = playdate.sound.sample.new("idle")
        snd:play()
    end
end

function bgmaction(action, audioname)
    bgm:load("mus/"..audioname)
    if action == "play" then
        bgm:play(100000000)
    elseif action == "pause" then
        bgm:pause()
    elseif action == "stop" then
        bgm:stop()
    end
end