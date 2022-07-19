--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

PlayerInteractingState = EntityInteractingState:extend()
function PlayerInteractingState:enter(params)
    self.entity.isInteracting = true
    self.object = params.object
    self.object.isOpen = true
    self.entity.mapX, self.entity.mapY = self.object.mapX, self.object.mapY
    self.entity.x, self.entity.y = self.object.x + self.object.width / 2 - self.entity.width / 3,
        self.object.y + self.entity.height / 2
end

function PlayerInteractingState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        self.entity.mapX = self.object.mapX
        self.entity.mapY = self.object.mapY + 2
        self.entity.x = (self.entity.mapX - 1) * TILE_SIZE
        self.entity.y = (self.entity.mapY - 1) * TILE_SIZE
        self.entity:changeState('idle')
    end
end

function PlayerInteractingState:exit()
    self.entity.isInteracting = false
    self.object.isOpen = false
end
