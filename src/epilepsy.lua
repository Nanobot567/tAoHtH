import "CoreLibs/graphics"
import "saveload"
import "buttons"

local gfx = playdate.graphics

check = gfx.image.new("img/other/epilepsycheck")
checkingForEpilepsy = false
epileptic = true

function checkForEpilepsy()
    checkingForEpilepsy = true
    gfx.clear(gfx.kColorBlack)
    check:draw(0,0)
end