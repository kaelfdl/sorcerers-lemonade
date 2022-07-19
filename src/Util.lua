--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

function GenerateQuads(atlas, tileWidth, tileHeight)
    local quads = {}
    local sheetWidth = atlas:getWidth() / tileWidth
    local sheetHeight = atlas:getHeight() / tileHeight
    local counter = 1

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            quads[counter] = love.graphics.newQuad(x * tileWidth, y * tileHeight, tileWidth, tileHeight,
                atlas:getDimensions())
            counter = counter + 1
        end
    end
    return quads
end
