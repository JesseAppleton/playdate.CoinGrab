local gfx <const> = playdate.graphics

class('Dashbar').extends(gfx.sprite)

function Dashbar:init(x, y)
    Dashbar.super.init(self)
    self.maxTime = 100
    self.dashOnCooldown = false
    self.currentTime = 0
    self:moveTo(x, y)
    self:updateTime()
    self:add()
end

function Dashbar:updateTime()
    if self.currentTime < self.maxTime then
        self.dashOnCooldown = true
        self.currentTime += 1
        if self.currentTime >= self.maxTime then
            self.dashOnCooldown = false
        end
    end
    local maxWidth = 40
    local height = 5
    local dashbarWidth = (self.currentTime / self.maxTime) * maxWidth
    local dashbarImage = gfx.image.new(maxWidth, height)
    gfx.pushContext(dashbarImage)
        gfx.fillRect(0, 0, dashbarWidth, height)
    gfx.popContext()
    self:setImage(dashbarImage)
end