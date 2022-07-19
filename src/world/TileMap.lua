--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

TileMap = Base:extend()

function TileMap:constructor(width, height)
    self.tiles = {}
    self.width = width
    self.height = height
end

function TileMap:render()
    for y = 1, self.height do
        for x = 1, self.width do
            self.tiles[y][x]:render()
        end
    end
end
