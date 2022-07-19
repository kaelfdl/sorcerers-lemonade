--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

Player = Entity:extend()

function Player:constructor(def)
    Entity.constructor(self, def)
    self.coins = 10
end

-- Checks interaction between the player and the specified targets
function Player:checkInteraction(targets)
    for k, target in pairs(targets) do
        local x, y = self.mapX, self.mapY

        if self.direction == 'left' then
            self.mapX = self.mapX - 1
        elseif self.direction == 'right' then
            self.mapX = self.mapX + 1
        elseif self.direction == 'down' then
            self.mapY = self.mapY + 1
        elseif self.direction == 'up' then
            self.mapY = self.mapY - 1
        end

        if self:collides(target) then
            if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
                target.onInteract(target, self)
            end
        end
        self.mapX = x
        self.mapY = y
    end
end
