--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

Selection = Base:extend()

function Selection:constructor(def)
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    self.font = def.font or gFonts['small']
    self.items = def.items or {}
    self.gapHeight = self.height / #self.items
    self.currentSelection = 1
    self.showCursor = true
end

function Selection:update(dt)
    if love.keyboard.wasPressed('up') then
        gSounds['select']:stop()
        gSounds['select']:play()
        if self.currentSelection == 1 then
            self.currentSelection = #self.items
        else
            self.currentSelection = self.currentSelection - 1
        end
    elseif love.keyboard.wasPressed('down') then
        gSounds['select']:stop()
        gSounds['select']:play()
        if self.currentSelection == #self.items then
            self.currentSelection = 1
        else
            self.currentSelection = self.currentSelection + 1
        end
    end

    if self.currentSelection ~= #self.items then
        if love.keyboard.wasPressed('left') then
            gSounds['select']:stop()
            gSounds['select']:play()
            self.items[self.currentSelection].decrease()
        elseif love.keyboard.wasPressed('right') then
            gSounds['select']:stop()
            gSounds['select']:play()
            self.items[self.currentSelection].increase()
        end
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['enter']:play()
        self.items[self.currentSelection].onSelect()
    end
end

function Selection:render()
    local currentY = self.y

    love.graphics.setFont(self.font)
    for i = 1, #self.items do
        local paddedY = currentY + (self.gapHeight / 2) - self.font:getHeight() / 2

        love.graphics.printf(self.items[i].text, self.x, paddedY, self.width, 'center')

        if i == self.currentSelection and self.showCursor then
            love.graphics.setColor(1, 204 / 255, 51 / 255, 1)
            love.graphics.rectangle('line', self.x + 4, currentY + self.gapHeight / 2 - self.font:getHeight() / 2,
                self.width - 8, self.gapHeight / 2
                , 5)
            love.graphics.setColor(1, 1, 1, 1)
        end

        currentY = currentY + self.gapHeight
    end

end
