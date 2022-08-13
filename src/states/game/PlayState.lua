--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

PlayState = BaseState:extend()

function PlayState:constructor()
    self.level = Level()

end

function PlayState:enter(params)
    gStateStack:push(IntroDialogueState("Hello there! Welcome to sorcerer's lemonade! To learn how to play, press the space bar. Otherwise, press Enter to get started."
        , function()
            gStateStack:push(RecipeMenuState(self.level))
        end, function()
        gStateStack:push(DialogueState(
            'Use the arrow keys to move your character. ' ..
            'Press Enter to interact with your lemonade stand. You can interact with merchants too! '
            ..
            'At the start of each day, a weather forecast and recipe menu will be shown on-screen. ' ..
            'Use the arrow keys to change your recipe for the day. ' ..
            'Remember that you need to tweak your recipe according to the weather. ' ..
            'At the end of each day, your unused ice blocks will melt. ' ..
            'And every two days, lemons get spoiled if not used. ' ..
            'Merchants will receive a new delivery every seven days. ' ..
            'For sunny weather, you need 2 lemons and 2 ice. ' ..
            'For rainy weather, you need 1 lemon. ' ..
            'For cloudy weather, you need 1 lemon and 1 ice. ' ..
            'To change the speed of the game, use the A and D keys. ' ..
            'To exit the game, press Escape. ' ..
            "That's it for now. Good luck!", function()
            gStateStack:push(RecipeMenuState(self.level))
        end))
    end))

end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('r') then
        self.level:tweenCoin(self.level.objects['lemonade-stand'])
    end

    if love.keyboard.wasPressed('d') then
        self.level.gameSpeed = math.min(10, self.level.gameSpeed + 1)
        self.level.gameTimer:remove()
        self.level.gameTimer = Timer.every(1 / self.level.gameSpeed, function()
            self.level.timer = self.level.timer - 1
        end)
    elseif love.keyboard.wasPressed('a') then
        self.level.gameSpeed = math.max(1, self.level.gameSpeed - 1)
        self.level.gameTimer:remove()
        self.level.gameTimer = Timer.every(1 / self.level.gameSpeed, function()
            self.level.timer = self.level.timer - 1
        end)
    end

    self.level:update(dt)
end

function PlayState:render()
    self.level:render()

    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 66, 1, 132, 56, 3)
    love.graphics.rectangle('fill', 2, 2, 56, 180, 3)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(gTextures['coins'], gFrames['coins'][3], 4, 4)
    love.graphics.print(tostring(self.level.player.coins), 32, 4)

    -- Display Inventory
    love.graphics.print('Stock', 4, 28)
    love.graphics.draw(gTextures['lemon_ice'], gFrames['lemon_ice'][1], 4, 48)
    love.graphics.print(tostring(self.level.objects['lemonade-stand'].inventory.lemon), 32, 48)

    love.graphics.draw(gTextures['lemon_ice'], gFrames['lemon_ice'][2], 4, 72)
    love.graphics.print(tostring(self.level.objects['lemonade-stand'].inventory.ice), 32, 72)

    -- Display Recipe
    love.graphics.print('Recipe', 4, 102)
    love.graphics.draw(gTextures['lemon_ice'], gFrames['lemon_ice'][1], 4, 118)
    love.graphics.print(tostring(self.level.objects['lemonade-stand'].recipe.lemon), 32, 118)

    love.graphics.draw(gTextures['lemon_ice'], gFrames['lemon_ice'][2], 4, 140)
    love.graphics.print(tostring(self.level.objects['lemonade-stand'].recipe.ice), 32, 140)

    love.graphics.draw(gTextures['coins'], gFrames['coins'][3], 4, 162)
    love.graphics.print(tostring(self.level.objects['lemonade-stand'].price), 32, 162)

    -- Display time and weather info
    love.graphics.printf('Day: ' .. tostring(self.level.day), 0, 4, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(tostring(self.level.currentTime), 0, 22, VIRTUAL_WIDTH, 'center')
    love.graphics.draw(gTextures['weather'], gFrames['weather'][self.level.currentWeather.id], VIRTUAL_WIDTH / 2 + 40, 22)

    love.graphics.printf('Game Speed: ' .. tostring(self.level.gameSpeed), 0, 40, VIRTUAL_WIDTH, 'center')
    -- love.graphics.print('Timer: ' .. tostring(self.level.timer), 4, VIRTUAL_HEIGHT - 32)
end
