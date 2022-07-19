--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

RecipeMenuState = BaseState:extend()

function RecipeMenuState:constructor(level)
    self.level = level
    self.weatherForecast = self.level.weatherForecast
    self.lemonadeStand = self.level.objects['lemonade-stand']
    self.lemonQuantity = self.lemonadeStand.recipe.lemon
    self.price = self.lemonadeStand.price
    self.iceQuantity = self.lemonadeStand.recipe.ice
    self.recipeMenu = Menu({
        font = gFonts['medium'],
        x = TILE_SIZE,
        y = VIRTUAL_HEIGHT / 2 - 192 / 2,
        width = VIRTUAL_WIDTH - 32,
        height = 224,
        items = {
            {
                text = 'Day ' .. tostring(self.level.day),
                decrease = function() end,
                increase = function() end,
                onSelect = function() end,
            },
            {
                text = '7:00 am     | 12:00 nn     | 3:00 pm',
                -- text = '7:00 am ' ..
                --     self.level.weatherForecast[1].text .. ' | 12:00nn ' ..
                --     self.level.weatherForecast[2].text .. ' | 3:00 pm ' .. self.level.weatherForecast[3].text,
                decrease = function() end,
                increase = function() end,
                onSelect = function() end,
            },
            {
                text = 'Recipe',
                decrease = function() end,
                increase = function() end,
                onSelect = function() end,
            },
            {
                text = 'Lemon:  ' ..
                    self.lemonQuantity,
                decrease = function()
                    self.lemonQuantity = math.max(0, self.lemonQuantity - 1)
                    self.recipeMenu.selection.items[4].text = 'Lemon:  ' .. self.lemonQuantity

                end,
                increase = function()
                    self.lemonQuantity = math.min(5, self.lemonQuantity + 1)
                    self.recipeMenu.selection.items[4].text = 'Lemon:  ' ..
                        self.lemonQuantity

                end,
                onSelect = function() end
            },
            {
                text = 'Ice:  ' ..
                    self.iceQuantity,
                decrease = function()
                    self.iceQuantity = math.max(0, self.iceQuantity - 1)
                    self.recipeMenu.selection.items[5].text = 'Ice:  ' .. self.iceQuantity

                end,
                increase = function()
                    self.iceQuantity = math.min(5, self.iceQuantity + 1)
                    self.recipeMenu.selection.items[5].text = 'Ice:  ' ..
                        self.iceQuantity

                end,
                onSelect = function() end
            },
            {
                text = 'Lemonade Price:  ' .. tostring(self.price)
                ,
                decrease = function()
                    self.price = math.max(1, self.price - 1)
                    self.recipeMenu.selection.items[6].text = 'Lemonade Price:  ' ..
                        tostring(self.price)


                end,
                increase = function()
                    self.price = math.min(10, self.price + 1)
                    self.recipeMenu.selection.items[6].text = 'Lemonade Price:  ' ..
                        tostring(self.price)

                end,
                onSelect = function() end
            },
            {
                text = 'Continue',
                onSelect = function()
                    self.lemonadeStand.recipe.lemon = self.lemonQuantity
                    self.lemonadeStand.recipe.ice = self.iceQuantity
                    self.lemonadeStand.price = self.price
                    gStateStack:pop()
                    gStateStack:push(DialogueState("It's a new a day. Good luck!", function()
                        if self.level.gameTimer then
                            self.level.gameTimer:remove()
                        end
                        self.level.gameTimer = Timer.every(1 / self.level.gameSpeed, function()
                            self.level.timer = self.level.timer - 1
                        end)
                    end))

                end,
                decrease = function() end,
                increase = function() end,
            },
        }
    })

end

function RecipeMenuState:update(dt)
    self.recipeMenu:update(dt)
end

function RecipeMenuState:render()
    self.recipeMenu:render()
    local forecast = self.weatherForecast
    love.graphics.draw(gTextures['weather'], gFrames['weather'][forecast[1].id], VIRTUAL_WIDTH / 2 - 76, 124)
    love.graphics.draw(gTextures['weather'], gFrames['weather'][forecast[2].id], VIRTUAL_WIDTH / 2 + 46, 124)
    love.graphics.draw(gTextures['weather'], gFrames['weather'][forecast[3].id], VIRTUAL_WIDTH / 2 + 160, 124)
    -- love.graphics.setLineWidth(4)
    love.graphics.line(VIRTUAL_WIDTH / 2 - 64, 176, VIRTUAL_WIDTH / 2 + 64, 176)
    love.graphics.draw(gTextures['lemon_ice'], gFrames['lemon_ice'][1], VIRTUAL_WIDTH / 2 + 44, 188)
    love.graphics.draw(gTextures['lemon_ice'], gFrames['lemon_ice'][2], VIRTUAL_WIDTH / 2 + 30, 220)
    love.graphics.draw(gTextures['coins'], gFrames['coins'][3], VIRTUAL_WIDTH / 2 + 82, 252)
end
