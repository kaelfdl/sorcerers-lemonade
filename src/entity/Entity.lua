--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

Entity = Base:extend()

function Entity:constructor(def)
    self.width = def.width
    self.height = def.height
    self.mapX = def.mapX
    self.mapY = def.mapY

    self.x = (self.mapX - 1) * TILE_SIZE
    self.y = (self.mapY - 1) * TILE_SIZE - self.height / 2

    self.direction = 'down'

    self.level = def.level
    self.animations = self:createAnimations(def.animations)
    self.onInteract = def.onInteract or function() end

end

function Entity:changeState(name, params)
    self.stateMachine:change(name, params)
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation({
            frames = animationDef.frames,
            texture = animationDef.texture,
            interval = animationDef.interval,
            flip = animationDef.flip or false,
            gameSpeed = self.level.gameSpeed
        })
    end
    return animationsReturned
end

function Entity:onInteract()

end

function Entity:collides(target)
    local x, y = (self.mapX - 1) * TILE_SIZE, (self.mapY - 1) * TILE_SIZE - self.height / 2
    return not
        (
        x + self.width <= target.x or x >= target.x + target.width or y + self.height <= target.y or
            y + self.height / 2 >= target.y + target.height)
end

function Entity:update(dt)
    self.currentAnimation.gameSpeed = self.level.gameSpeed
    self.currentAnimation:update(dt)
    self.stateMachine:update(dt)
end

function Entity:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Entity:render()
    self.stateMachine:render()

    -- Collision box for debugging
    -- love.graphics.setColor(1, 0, 1, 1)
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(1, 1, 1, 1)
end
