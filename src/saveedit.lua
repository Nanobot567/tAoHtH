import "CoreLibs/graphics"

local gfx = playdate.graphics
svtMode = 0
waitingForOkInSVT = false
svteditCursorPos = 0
dontTryForBtnTimer = 100

-- svt = save tamperer

function svTUpdate()
    if svtMode == 0 and waitingForOkInSVT == false then
        waitingForOkInSVT = true
        gfx.clear(gfx.kColorBlack)
        gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
        gfx.drawText("welcome to the save editor!!",0,0)
        svtData = {"hunger";hunger,"anger";anger,"thirst";thirst,"happiness";happiness,"horseStatus";horseStatus,"time";time,"isNight";isNight,"epileptic";epileptic,"name";horseName}
    elseif svtMode == 1 and waitingForOkInSVT == true then
        gfx.clear(gfx.kColorBlack)
        gfx.drawText("hunger: "..svtData[2],0,0)
        gfx.drawText("anger: "..svtData[4],0,20)
        gfx.drawText("thirst: "..svtData[6],0,40)
        gfx.drawText("happiness: "..svtData[8],0,60)
        gfx.drawText("status: "..tostring(svtData[10]),0,80)
        gfx.drawText("time: "..svtData[12],0,100)
        gfx.drawText("isNight: "..tostring(svtData[14]),0,120)
        gfx.drawText("epileptic: "..tostring(svtData[16]),0,140)
        gfx.drawText("horseName: "..tostring(svtData[18]),0,160)

        gfx.drawText("<",380,svteditCursorPos*20)

        if playdate.keyboard.isVisible() == false then
            if playdate.buttonJustPressed("down") and svteditCursorPos ~= 8 then
                svteditCursorPos += 1
            elseif playdate.buttonJustPressed("up") and svteditCursorPos ~= 0 then
                svteditCursorPos -= 1
            elseif playdate.buttonJustPressed("a") then
                if dontTryForBtnTimer == 0 then
                    playdate.keyboard.show()
                    if type(svtData[(svteditCursorPos+1)*2]) == "boolean" then
                        playdate.keyboard.text = tostring(svtData[(svteditCursorPos+1)*2])
                    else
                        playdate.keyboard.text = svtData[(svteditCursorPos+1)*2]
                    end
                end
            elseif playdate.buttonJustPressed("b") then
                if dontTryForBtnTimer == 0 then
                    hunger = tonumber(svtData[2])
                    anger = tonumber(svtData[4])
                    thirst = tonumber(svtData[6])
                    happiness = tonumber(svtData[8])
                    horseStatus = svtData[10]
                    time = tonumber(svtData[12])
                    isNight = tobool(svtData[14])
                    epileptic = tobool(svtData[16])
                    horseName = svtData[18]
                    save(false)
                    gfx.drawText("saved changes! restart to see them.",0,220)
                    playdate.stop()
                end
            end
        else
            gfx.drawText(tostring(playdate.keyboard.text),0,220)
            if playdate.keyboard.text ~= "" then
                svtData[(svteditCursorPos+1)*2] = playdate.keyboard.text
            end
        end

        if dontTryForBtnTimer ~= 0 then
            dontTryForBtnTimer -= 1
        end


    end
end

function tobool(string)
    local bool = false
    if string == "true" then
        bool = true
    elseif string == "false" then
        bool = false
    end
    return bool
end