--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

Tile = Base:extend()

function Tile:constructor(x, y, id)
    self.x = x
    self.y = y
    self.id = id
end

function Tile:update(dt)

end

function Tile:render()
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.id], (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
end
