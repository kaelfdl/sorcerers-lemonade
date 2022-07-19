--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

FadeOutState = BaseState:extend()

function FadeOutState:constructor(color, time, onFadeComplete)
    self.r = color.r
    self.g = color.g
    self.b = color.b
    self.opacity = 1
    self.time = time

    Timer.tween(self.time, {
        [self] = { opacity = 0 }
    }):finish(function()
        gStateStack:pop()
        onFadeComplete()
    end)
end

function FadeOutState:render()
    love.graphics.setColor(self.r, self.g, self.b, self.opacity)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(1, 1, 1, 1)
end
