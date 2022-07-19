--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

BuyMenuState = BaseState:extend()

function BuyMenuState:constructor(level, type, callback)
    self.level = level
    self.type = type
    self.callback = callback

    self.merchant = self.level.objects[self.type].inventory
    self.buyLimit = math.floor(self.level.player.coins * (self.type == 'fruit-stand' and
        self.merchant.lemon.cost or self.merchant.ice.cost))
    self.buyQuantity = math.min(1, self.buyLimit)
    self.items = {}


    if self.type == 'fruit-stand' then
        self.items = {
            {
                text = 'Fruit Stand',
                onSelect = function() end,
                increase = function() end,
                decrease = function() end
            },
            {
                text = 'Lemon: ' ..
                    math.min(self.buyQuantity, self.buyLimit),
                decrease = function()
                    self.buyQuantity = math.max(1, self.buyQuantity - 1)
                    self.buyMenu.selection.items[2].text = 'Lemon: ' ..
                        math.min(self.buyQuantity, self.buyLimit)
                    self.buyMenu.selection.items[3].text = 'Total: ' ..
                        tostring(self.buyQuantity * self.merchant.lemon.cost)
                end,
                increase = function()
                    self.buyQuantity = math.max(1, math.min(self.buyLimit, self.buyQuantity + 1))
                    self.buyMenu.selection.items[2].text = 'Lemon: ' ..
                        math.min(self.buyQuantity, self.buyLimit)
                    self.buyMenu.selection.items[3].text = 'Total: ' ..
                        tostring(self.buyQuantity * self.merchant.lemon.cost)

                end,
                onSelect = function() end
            },
            {
                text = 'Total: ' ..
                    tostring(self.buyQuantity * self.merchant.lemon.cost),
                onSelect = function() end,
                increase = function() end,
                decrease = function() end
            },
            {
                text = 'Buy',
                onSelect = function()
                    local coinsLeft = self.level.player.coins - (self.merchant.lemon.cost * self.buyQuantity)
                    if coinsLeft < 0 then
                        gStateStack:push(DialogueState("You don't have enough coins to buy lemons."))
                    else
                        self.level.player.coins = self.level.player.coins -
                            (self.merchant.lemon.cost * self.buyQuantity
                            )

                        local lemonadeStand = self.level.objects['lemonade-stand']
                        lemonadeStand.inventory.lemon = lemonadeStand.inventory.lemon + self.buyQuantity
                        self.merchant.lemon.quantity = self.merchant.lemon.quantity - self.buyQuantity


                        gStateStack:pop()
                        gStateStack:push(DialogueState(tostring(self.buyQuantity) ..
                            (self.buyQuantity == 1 and ' lemon bought' or ' lemons bought'), function()
                            self.callback()
                        end))
                    end
                end,
                increase = function() end,
                decrease = function() end
            },

            {
                text = 'Cancel',
                onSelect = function()
                    gStateStack:pop()
                    self.callback()
                end,
                increase = function() end,
                decrease = function() end
            }
        }

    elseif self.type == 'ice-shed' then
        self.items = {
            {
                text = 'Ice Shed',
                onSelect = function() end,
                increase = function() end,
                decrease = function() end
            },
            {
                text = 'Ice: ' ..
                    math.min(self.buyQuantity, self.buyLimit),
                decrease = function()
                    self.buyQuantity = math.max(1, self.buyQuantity - 1)
                    self.buyMenu.selection.items[2].text = 'Ice: ' ..
                        math.min(self.buyQuantity, self.buyLimit)
                    self.buyMenu.selection.items[3].text = 'Total: ' ..
                        tostring(self.buyQuantity * self.merchant.ice.cost)
                end,
                increase = function()
                    self.buyQuantity = math.max(1, math.min(self.buyLimit, self.buyQuantity + 1))
                    self.buyMenu.selection.items[2].text = 'Ice: ' ..
                        math.min(self.buyQuantity, self.buyLimit)
                    self.buyMenu.selection.items[3].text = 'Total: ' ..
                        tostring(self.buyQuantity * self.merchant.ice.cost)
                end,
                onSelect = function() end
            },
            {
                text = 'Total: ' ..
                    tostring(self.buyQuantity * self.merchant.ice.cost),
                onSelect = function() end,
                increase = function() end,
                decrease = function() end
            },
            {
                text = 'Buy',
                onSelect = function()
                    local coinsLeft = self.level.player.coins - (self.merchant.ice.cost * self.buyQuantity)
                    if coinsLeft < 0 then
                        gStateStack:push(DialogueState("You don't have enough coins to buy ice."))
                    else
                        self.level.player.coins = self.level.player.coins - (self.merchant.ice.cost * self.buyQuantity)
                        local lemonadeStand = self.level.objects['lemonade-stand']
                        lemonadeStand.inventory.ice = lemonadeStand.inventory.ice + self.buyQuantity
                        self.merchant.ice.quantity = self.merchant.ice.quantity - self.buyQuantity
                        gStateStack:pop()
                        gStateStack:push(DialogueState(tostring(self.buyQuantity) ..
                            (self.buyQuantity == 1 and ' ice block bought' or ' ice blocks bought'), function()
                            self.callback()
                        end))
                    end
                end,
                increase = function() end,
                decrease = function() end
            },
            {
                text = 'Cancel',
                onSelect = function()
                    gStateStack:pop()
                    self.callback()
                end,
                increase = function() end,
                decrease = function() end
            }
        }
    end

    self.buyMenu = Menu({
        x = 16,
        y = VIRTUAL_HEIGHT / 2 - 160 / 2,
        width = VIRTUAL_WIDTH - 32,
        height = 160,
        items = self.items,
        font = gFonts['medium']
    })
end

function BuyMenuState:update(dt)
    self.buyMenu:update(dt)
end

function BuyMenuState:render()
    self.buyMenu:render()
    if self.type == 'fruit-stand' then
        love.graphics.draw(gTextures['lemon_ice'], gFrames['lemon_ice'][1],
            VIRTUAL_WIDTH / 2 + 40, 138)
    else
        love.graphics.draw(gTextures['lemon_ice'], gFrames['lemon_ice'][2],
            VIRTUAL_WIDTH / 2 + 28, 138)
    end
    love.graphics.draw(gTextures['coins'], gFrames['coins'][3], VIRTUAL_WIDTH / 2 + 36, 172)
end
