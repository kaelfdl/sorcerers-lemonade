--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

EntityInteractingState = EntityBaseState:extend()

function EntityInteractingState:constructor(entity)
    self.entity = entity
    self.level = self.entity.level
    self.entity:changeAnimation('idle-' .. self.entity.direction)
    self.waitDuration = 0
    self.waitTimer = 0
end

function EntityInteractingState:enter(params)
    self.entity.isInteracting = true
    self.object = params.object

    self.entity.mapX, self.entity.mapY = self.object.mapX + 1, self.object.mapY + 1
    self.entity.x, self.entity.y = self.object.x + self.object.width / 2 - self.entity.width / 3,
        self.object.y + self.object.height - self.entity.height / 2

    if self.object.state ~= 'empty' then
        -- Customers will only buy lemonade that suits the current weather
        local requiredRecipe = self.level.currentWeather.requiredRecipe

        if self.object.recipe.lemon == 0 then
            -- Pause the time and a push a dialogue state
            self.level.gameTimer:remove()
            gStateStack:push(DialogueState("There's nothing to buy here.", function()
                self.level.gameTimer = Timer.every(1 / self.level.gameSpeed, function()
                    self.level.timer = self.level.timer - 1
                end)
            end))
            return
        end

        if self.object.recipe.lemon < requiredRecipe.lemon then
            -- Pause the time and a push a dialogue state
            self.level.gameTimer:remove()
            gStateStack:push(DialogueState('Your lemonade taste bland. It is not worth it.', function()
                self.level.gameTimer = Timer.every(1 / self.level.gameSpeed, function()
                    self.level.timer = self.level.timer - 1
                end)
            end))
            return
        end

        if self.object.recipe.lemon > requiredRecipe.lemon then
            -- Pause the time and a push a dialogue state
            self.level.gameTimer:remove()
            gStateStack:push(DialogueState('Your lemonade taste too strong. It is not worth it.', function()
                self.level.gameTimer = Timer.every(1 / self.level.gameSpeed, function()
                    self.level.timer = self.level.timer - 1
                end)
            end))
            return
        end

        if self.object.recipe.ice < requiredRecipe.ice then
            self.level.gameTimer:remove()
            gStateStack:push(DialogueState('Your lemonade is not cold enough. I will not buy it.', function()
                self.level.gameTimer = Timer.every(1 / self.level.gameSpeed, function()
                    self.level.timer = self.level.timer - 1
                end)
            end))
            return
        end

        if self.object.recipe.ice > requiredRecipe.ice then
            -- Pause the time and a push a dialogue state
            self.level.gameTimer:remove()
            gStateStack:push(DialogueState('Your lemonade is too cold. I will not buy it.', function()
                self.level.gameTimer = Timer.every(1 / self.level.gameSpeed, function()
                    self.level.timer = self.level.timer - 1
                end)
            end))
            return
        end

        if self.object.price > requiredRecipe.price then
            -- Pause the time and a push a dialogue state
            self.level.gameTimer:remove()
            gStateStack:push(DialogueState('Your lemonade is too expensive.', function()
                self.level.gameTimer = Timer.every(1 / self.level.gameSpeed, function()
                    self.level.timer = self.level.timer - 1
                end)
            end))
            return
        end

        self.object.inventory.lemon = math.max(0, self.object.inventory.lemon - self.object.recipe.lemon)
        self.object.inventory.ice = math.max(0, self.object.inventory.ice - self.object.recipe.ice)

        self.object.inventory.juice = self.object.inventory.juice - 1

        self.level.player.coins = self.level.player.coins +
            self.level.objects['lemonade-stand'].price
        self.level.dailyProgress.lemonadeSold = self.level.dailyProgress.lemonadeSold + 1

        -- Tween a disappearing coin upwards
        self.level:tweenCoin(self.object)
    end


end

function EntityInteractingState:update(dt)
    if self.waitDuration == 0 then
        self.waitDuration = math.random(5) / self.level.gameSpeed
    elseif self.waitTimer > self.waitDuration then
        self.entity.mapX = self.object.mapX
        self.entity.mapY = self.object.mapY + 2
        self.entity.x = (self.entity.mapX - 1) * TILE_SIZE
        self.entity.y = (self.entity.mapY - 1) * TILE_SIZE
        self.entity:changeState('idle')
    end
    self.waitTimer = self.waitTimer + dt
end

function EntityInteractingState:exit()
    self.entity.isInteracting = false

    -- To avoid unintentional interaction loop
    -- we give a duration in which the NPC cannot interact
    self.entity.noInteractionDuration = math.random(5)
    self.entity.canInteract = false

    -- Make the lemonade stand available for the next customer that comes around
    self.object.isAvailable = true
end
