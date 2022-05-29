import "dashbar"

local gfx <const> = playdate.graphics

class('Player').extends(gfx.sprite)

function Player:init(x, y)
    Player.super.init(self)
    self:moveTo(x, y)
    local playerImage = gfx.image.new("images/player")
    self:setImage(playerImage)
    self.speed = 4
    self.dashBar = Dashbar(x, y-20)
    self.dashOnCooldown = false;
    self:setCollideRect(0, 0, self:getSize())
end

function Player:update()
    Player.super.update(self)
    self.dashBar:updateTime()
    if playdate.buttonIsPressed(playdate.kButtonUp) then
        self:moveBy(0, -self.speed)
    end
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        self:moveBy(self.speed, 0)
    end
    if playdate.buttonIsPressed(playdate.kButtonDown) then
        self:moveBy(0, self.speed)
    end
    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        self:moveBy(-self.speed, 0)
    end
    if playdate.buttonJustPressed(playdate.kButtonB) and self.dashBar.dashOnCooldown == false then
        self:dash()
    end
    
end

function Player:moveBy(x, y)
    Player.super.moveBy(self, x, y)
    self.dashBar:moveBy(x, y)
end

function Player:resetStats()
    self.speed = 4
end

function Player:dash()
    local function timerCallBack()
        self:resetStats()
    end
    self.dashBar.currentTime = 0
    playdate.timer.performAfterDelay(1000, timerCallBack)
    self.speed = 8
end