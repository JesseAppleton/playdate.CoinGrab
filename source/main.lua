import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "player"
import "coin"

-- screen size is 400 x 240. 0, 0 would be top left
local gfx <const> = playdate.graphics
local playTimer = nil
local playTime = 30 * 1000
local score = 0
local coinSprite  = nil

local function resetTimer()
    playTimer = playdate.timer.new(playTime, playTime, 0, playdate.easingFunctions.linear)
end

local function initialize()
    local playerSprite = Player(200, 100)
    playerSprite:add()

    coinSprite = Coin()
    coinSprite:add()

    local backgroundImage = gfx.image.new("images/background")
    gfx.sprite.setBackgroundDrawingCallback(
        function (x, y, width, height)
            gfx.setClipRect(x, y, width, height)
            backgroundImage:draw(0, 0)
            gfx.clearClipRect()
        end
    )

    resetTimer()
end

initialize()

function playdate.update()
    if playTimer.value == 0 then
        if playdate.buttonJustPressed(playdate.kButtonA) then
            resetTimer()
            coinSprite:moveCoin()
            score = 0
        end
    else
        local collisions = coinSprite:overlappingSprites()
        if #collisions >= 1 then
            coinSprite:moveCoin()
            score += 1
        end
    end

    playdate.timer.updateTimers()
    gfx.sprite.update()
    gfx.drawText("Time: " .. math.ceil(playTimer.value/1000), 5, 5)
    gfx.drawText("Score: " .. score, 300, 5)
end