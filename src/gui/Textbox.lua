--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

Textbox = Base:extend()

function Textbox:constructor(x, y, width, height, text, font)
    self.panel = Panel(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.font = font or gFonts['small']
    self.text = text
    _, self.textChunks = self.font:getWrap(self.text, self.width - 12)

    self.chunkCounter = 1
    self.endOfText = false
    self.closed = false

    self:next()
end

function Textbox:next()
    if self.endOfText then
        self.displayingChunks = {}
        self.panel:toggle()
        self.closed = true
    else
        self.displayingChunks = self:nextChunk()
    end
end

function Textbox:nextChunk()
    local chunks = {}

    for i = self.chunkCounter, self.chunkCounter + 2 do
        table.insert(chunks, self.textChunks[i])

        if i == #self.textChunks then
            self.endOfText = true
            return chunks
        end
    end

    self.chunkCounter = self.chunkCounter + 3

    return chunks
end

function Textbox:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['enter']:stop()
        gSounds['enter']:play()
        self:next()
    end
end

function Textbox:isClosed()
    return self.closed
end

function Textbox:render()
    self.panel:render()

    love.graphics.setFont(self.font)
    for i = 1, #self.displayingChunks do
        love.graphics.print(self.displayingChunks[i], self.x + 4, self.y + 4 + (i - 1) * TILE_SIZE)
    end
end
