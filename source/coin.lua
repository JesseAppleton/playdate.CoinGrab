local gfx <const> = playdate.graphics

class('Coin').extends(gfx.sprite)

function Coin:init()
    Coin.super.init(self)
    math.randomseed(playdate.getSecondsSinceEpoch())

    local coinImage = gfx.image.new("images/coin")
    self:setImage(coinImage)
    self:setCollideRect(0, 0, self:getSize())
    self:moveCoin()
end

function Coin:moveCoin()
    local randX = math.random(40, 360)
    local randY = math.random(40, 200)
    self:moveTo(randX, randY)
end