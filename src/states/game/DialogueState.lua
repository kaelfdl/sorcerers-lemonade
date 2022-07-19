--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

DialogueState = BaseState:extend()

function DialogueState:constructor(text, callback)
    self.textbox = Textbox(6, 6, VIRTUAL_WIDTH - 12, 64, text, gFonts['medium'])
    self.callback = callback or function() end
end

function DialogueState:update(dt)
    self.textbox:update(dt)

    if self.textbox:isClosed() then
        gStateStack:pop()
        self.callback()
    end
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function DialogueState:render()
    self.textbox:render()
end
