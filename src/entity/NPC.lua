--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

NPC = Entity:extend()

function NPC:constructor(def)
    Entity.constructor(self, def)
    self.canInteract = true
    self.noInteractionDuration = 0
    self.noInteractionTimer = 0
    self.shouldProcessAI = def.shouldProcessAI or false
end

function NPC:update(dt)
    if self.noInteractionDuration > 0 then
        self.noInteractionTimer = self.noInteractionTimer + dt
    elseif self.noInteractionTimer > self.noInteractionDuration then
        self.noInteractionTimer = 0
        self.noInteractionDuration = 0
        self.canInteract = true
    end

    Entity.update(self, dt)
end
