--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

EntityBaseState = Base:extend()

function EntityBaseState:constructor(entity)
    self.entity = entity
end

function EntityBaseState:update(dt) end

function EntityBaseState:enter() end

function EntityBaseState:exit() end

function EntityBaseState:processAI(params, dt) end

function EntityBaseState:render()
    local anim = self.entity.currentAnimation
    if anim.flip then
        love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
            math.floor(self.entity.x)
            , math.floor(self.entity.y), 0, -1, 1, self.entity.width)
    else
        love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
            math.floor(self.entity.x)
            , math.floor(self.entity.y))
    end

end
