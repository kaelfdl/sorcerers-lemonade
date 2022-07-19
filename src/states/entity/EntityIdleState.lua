--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

EntityIdleState = EntityBaseState:extend()

function EntityIdleState:constructor(entity)
    self.entity = entity
    self.entity:changeAnimation('idle-' .. self.entity.direction)

    self.waitDuration = 0
    self.waitTimer = 0
end

function EntityIdleState:processAI(params, dt)
    local directions = { 'left', 'right', 'down', 'up' }
    if self.waitDuration == 0 then
        self.waitDuration = math.random(5) / self.entity.level.gameSpeed
    else
        self.waitTimer = self.waitTimer + dt
        if self.waitTimer > self.waitDuration then
            self.entity.direction = directions[math.random(#directions)]
            self.entity:changeState('walk')
        end
    end
end
