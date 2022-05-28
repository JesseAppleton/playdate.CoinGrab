import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics

class('Dashbar').extends(gfx.sprite)

function Dashbar:init(x, y, maxTime)
    Dashbar.super.init(self)
    self.maxTime = maxTime
    self.currentTime = 0
    self.dashTime = 2 * 1000
    self:moveTo(x, y)
    self:updateTime()
    self:add()
end

function Dashbar:updateTime()
    local maxWidth = 40
    local height = 5
    local dashbarWidth = (self.currentTime / self.maxTime) * maxWidth
    local dashbarImage = gfx.image.new(maxWidth, height)
    gfx.pushContext(dashbarImage)
        gfx.fillRect(0, 0, dashbarWidth, height)
    gfx.popContext()
    self:setImage(dashbarImage)
end

local dashTimer = nil
local dashTime = 30 * 1000


local function resetTimer()
    dashTimer = playdate.timer.new(dashTime, dashTime, 0, playdate.easingFunctions.linear)
end