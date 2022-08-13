--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

StartState = BaseState:extend()

function StartState:constructor()
    local music = gSounds['game-music']
    music:setLooping(true)
    music:play()
end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:push(FadeInState({
            r = 1, g = 1, b = 1
        }, 1, function()
            gStateStack:pop()
            gStateStack:push(PlayState())
            gStateStack:push(FadeOutState({
                r = 1, g = 1, b = 1
            }, 1, function() end))
        end))
    end
end

function StartState:render()
    love.graphics.draw(gTextures['background'], 0, 0, 0,
        1, VIRTUAL_HEIGHT / (gTextures['background']:getHeight()))
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 360 / 2, VIRTUAL_HEIGHT / 2 - 44, 360, 72, 3)
    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(1, 204 / 255, 51 / 255, 1)
    love.graphics.printf("Sorcerer's Lemonade", 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Press Enter to Start", 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end
