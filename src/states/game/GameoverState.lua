--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

GameoverState = BaseState:extend()

function GameoverState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:pop()
        gStateStack:push(StartState())
    end
end

function GameoverState:render()
    love.graphics.draw(gTextures['background'], 0, 0, 0,
        1, VIRTUAL_HEIGHT / (gTextures['background']:getHeight()))
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 360 / 2, VIRTUAL_HEIGHT / 2 - 144, 360, 96, 3)
    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(1, 204 / 255, 51 / 255, 1)
    love.graphics.printf("GAME OVER!", 0, VIRTUAL_HEIGHT / 2 - 128, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Your lemonade stand went backrupt!", 0, VIRTUAL_HEIGHT / 2 - 96, VIRTUAL_WIDTH, 'center')
    love.graphics.printf("Press Enter to continue", 0, VIRTUAL_HEIGHT / 2 - 72, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end
