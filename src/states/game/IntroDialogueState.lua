--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

IntroDialogueState = DialogueState:extend()

function IntroDialogueState:constructor(text, callback, callback_2)
    DialogueState.constructor(self, text, callback)
    self.callback_2 = callback_2
end

function IntroDialogueState:update(dt)
    DialogueState.update(self, dt)

    if love.keyboard.wasPressed('space') then
        gStateStack:pop()
        self.callback_2()
    end
end
