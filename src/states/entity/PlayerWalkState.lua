--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

PlayerWalkState = EntityWalkState:extend()

function PlayerWalkState:constructor(entity, level)
    EntityWalkState.constructor(self, entity, level)
end
