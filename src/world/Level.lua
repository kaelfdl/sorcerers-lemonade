--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

Level = Base:extend()

function Level:constructor()
    -- Stock reset

    self.tileWidth = MAP_WIDTH
    self.tileHeight = MAP_HEIGHT

    self.objects = {}
    self.entities = {}

    self.baseLayer = TileMap(self.tileWidth, self.tileHeight)
    self.fenceLayer = TileMap(self.tileWidth, self.tileHeight)

    self:generateObjects()

    self:refresh()
    self:createMaps()
    self:generateEntities()

    self.weatherForecast = {}
    self.workingHours = { '7:00 am', '12:00 nn', '3:00 pm', '5:00 pm' }

    self:generateWeatherForecast()

    self.player = Player({
        animations = ENTITY_DEFS['player'].animations,
        width = ENTITY_DEFS['player'].width,
        height = ENTITY_DEFS['player'].height,
        mapX = ENTITY_DEFS['player'].mapX,
        mapY = ENTITY_DEFS['player'].mapY,
        level = self,
    })

    self.player.stateMachine = StateMachine({
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['walk'] = function() return PlayerWalkState(self.player, self) end,
        ['interact'] = function() return PlayerInteractingState(self.player) end,
    })

    self.player:changeState('idle')

    self.timer = 180
    self.day = 1

    self.currentTime = self.workingHours[1]
    self.currentWeather = self.weatherForecast[1]

    self.dailyProgress = {
        lemonadeSold = 0,
        revenue = 0,
        stockUsed = 0,
        stockLost = 0,
        totalEarnings = 0,
    }

    self.gameSpeed = 1
end

function Level:update(dt)


    if self.timer == 120 then
        self.currentTime = self.workingHours[2]
        self.currentWeather = self.weatherForecast[2]
    elseif self.timer == 60 then
        self.currentTime = self.workingHours[3]
        self.currentWeather = self.weatherForecast[3]
    elseif self.timer == 0 then
        self.currentTime = self.workingHours[4]
    end

    if self.timer <= 0 then
        self.gameTimer:remove()
        self.timer = 0



        -- Compute the summary at the end of the day
        self:computeDailySummary()

        -- Ice blocks melt at the end of the day
        gStateStack:push(DialogueState(tostring(self.objects['lemonade-stand'].inventory.ice ..
            (self.objects['lemonade-stand'].inventory.ice > 1 and ' ice blocks melted' or ' ice block melted')),
            function()
                self.objects['lemonade-stand'].inventory.ice = 0

                -- Lemons spoil every two days
                if self.day % 2 == 0 then
                    gStateStack:push(DialogueState(tostring(self.objects['lemonade-stand'].inventory.lemon ..
                        (self.objects['lemonade-stand'].inventory.lemon > 1 and ' lemons spoiled' or ' lemon spoiled')),
                        function()
                            self.objects['lemonade-stand'].inventory.lemon = 0
                            gStateStack:push(DailySummaryMessageState(self, function()
                                self:nextDay()
                                self:checkGameover(function()
                                    gStateStack:push(RecipeMenuState(self))
                                end)
                            end))
                        end))

                else
                    gStateStack:push(DailySummaryMessageState(self, function()
                        self:nextDay()
                        self:checkGameover(function()
                            gStateStack:push(RecipeMenuState(self))
                        end)
                    end))
                end
            end))




    end
    self.player:update(dt)

    self.player:checkInteraction(self.objects)
    self.player:checkInteraction(self.entities)

    for k, object in pairs(self.objects) do
        object:update(dt)
    end

    for k, entity in pairs(self.entities) do
        if entity.shouldProcessAI then
            entity:processAI({}, dt)
        end

        entity:update(dt)
    end

    -- Market gets fresh deliveries every 7 days
    if self.day % 7 == 0 then
        self:refreshStock()
    end

end

function Level:render()
    self.baseLayer:render()
    self.fenceLayer:render()

    if self.player.isInteracting then
        self.player:render()
    end

    for k, object in pairs(self.objects) do
        object:render()
    end

    for k, entity in pairs(self.entities) do
        entity:render()
    end

    if not self.player.isInteracting then
        self.player:render()
    end
end

function Level:checkGameover(callback)
    if self.player.coins - self.objects['fruit-stand'].inventory.lemon.cost <= 0 and
        self.objects['lemonade-stand'].inventory.lemon <= 0 then
        print('Gameover')
        gStateStack:clear()
        gStateStack:push(GameoverState())
    else
        callback()
    end
end

function Level:resetProgress()
    for k, item in pairs(self.dailyProgress) do
        item = 0
    end
end

function Level:computeDailySummary()
    local lemonadeStand = self.objects['lemonade-stand']
    local iceShed = self.objects['ice-shed']
    local fruitStand = self.objects['fruit-stand']
    local progress = self.dailyProgress
    progress.revenue = progress.lemonadeSold * lemonadeStand.price
    progress.stockUsed = progress.lemonadeSold *
        (
        (lemonadeStand.recipe.lemon * fruitStand.inventory.lemon.cost) +
            (lemonadeStand.recipe.ice * iceShed.inventory.ice.cost))
    progress.stockLost = (lemonadeStand.inventory.ice * iceShed.inventory.ice.cost) +
        (self.day % 2 == 0 and (lemonadeStand.inventory.lemon * fruitStand.inventory.lemon.cost) or 0)
    progress.totalEarnings = progress.revenue - (progress.stockUsed + progress.stockLost)
end

function Level:nextDay()
    self.day = self.day + 1
    self.currentTime = self.workingHours[1]
    self:generateWeatherForecast()
    self.currentWeather = self.weatherForecast[1]
    self.timer = 180
    self:resetProgress()
end

function Level:createMaps()
    for y = 1, self.tileHeight do
        table.insert(self.baseLayer.tiles, {})
        for x = 1, self.tileWidth do
            local id = TILE_IDS['grass'][math.random(#TILE_IDS['grass'])]
            table.insert(self.baseLayer.tiles[y], Tile(x, y, id))
        end
    end

    for y = 1, self.tileHeight do
        table.insert(self.fenceLayer.tiles, {})
        for x = 1, self.tileWidth do
            local id = TILE_IDS['empty']
            table.insert(self.fenceLayer.tiles[y], Tile(x, y, id))
        end
    end
    for k, object in pairs(self.objects) do
        if object.type == 'building' then

            local startX = math.floor(object.x / TILE_SIZE)
            local startY = math.floor(object.y / TILE_SIZE)
            local endX = startX + math.floor(object.width / TILE_SIZE + 1)
            local endY = startY + math.floor(object.height / TILE_SIZE + 1)

            for y = startY, endY do
                for x = startX, endX do
                    local tile = self.fenceLayer.tiles[y][x]
                    if y == startY and x == startX then
                        tile.id = TILE_IDS['fence-top-left']
                    elseif y == startY and x == endX then
                        tile.id = TILE_IDS['fence-top-right']
                    elseif y == endY and x == startX then
                        tile.id = TILE_IDS['fence-bot-left']
                    elseif y == endY and x == endX then
                        tile.id = TILE_IDS['fence-bot-right']
                    elseif y == startY then
                        tile.id = TILE_IDS['fence-top']
                    elseif x == startX then
                        tile.id = TILE_IDS['fence-left']
                    elseif x == endX then
                        tile.id = TILE_IDS['fence-right']
                    end
                end
            end
        end
    end
end

function Level:generateObjects()
    local house = GameObject(GAME_OBJECT_DEFS['house'], 6, 4)

    local townHall = GameObject(GAME_OBJECT_DEFS['town-hall'], 16, 8)

    local lemonadeStand = GameObject(GAME_OBJECT_DEFS['lemonade-stand'], 10, 16)

    local fruitStand = GameObject(GAME_OBJECT_DEFS['fruit-stand'], 30, 12)

    local iceShed = GameObject(GAME_OBJECT_DEFS['ice-shed'], 30, 2)
    self.objects['house'] = house
    self.objects['town-hall'] = townHall
    self.objects['lemonade-stand'] = lemonadeStand
    self.objects['fruit-stand'] = fruitStand
    self.objects['ice-shed'] = iceShed

end

function Level:generateEntities()
    for i = 1, 10 do
        local mapX = math.random(MAP_WIDTH - 1)
        local mapY = math.random(MAP_HEIGHT - 1)

        for k, object in pairs(self.objects) do
            if not
                (
                mapX < object.mapX or mapX > object.mapX + object.width / TILE_SIZE or mapY < object.mapY or
                    mapY > object.mapY + object.y / TILE_SIZE) then
                mapX = object.mapX - 1
                mapY = object.mapY + object.y / TILE_SIZE + 2
            end
        end

        for y = 1, MAP_HEIGHT do
            for x = 1, MAP_WIDTH do
                local tile = self.fenceLayer.tiles[y][x]
                if (mapX == tile.x or mapY == tile.y) and tile.id ~= TILE_IDS['empty'] then
                    mapX = math.random(MAP_WIDTH - 1)
                    mapY = math.random(MAP_HEIGHT - 1)
                end
            end
        end

        local sorcerer = NPC({
            animations = ENTITY_DEFS['NPC-1'].animations,
            width = ENTITY_DEFS['NPC-1'].width,
            height = ENTITY_DEFS['NPC-1'].height,
            mapX = mapX,
            mapY = mapY,
            level = self,
            shouldProcessAI = ENTITY_DEFS['NPC-1'].shouldProcessAI
        })

        sorcerer.stateMachine = StateMachine({
            ['idle'] = function() return EntityIdleState(sorcerer) end,
            ['walk'] = function() return EntityWalkState(sorcerer, self) end,
            ['interact'] = function() return EntityInteractingState(sorcerer) end,
        })

        sorcerer:changeState('idle')
        table.insert(self.entities, sorcerer)
    end

    local fruitMerchant = NPC({
        animations = ENTITY_DEFS['fruit-merchant'].animations,
        width = ENTITY_DEFS['fruit-merchant'].width,
        height = ENTITY_DEFS['fruit-merchant'].height,
        mapX = 29,
        mapY = 14,
        level = self,
        onInteract = ENTITY_DEFS['fruit-merchant'].onInteract,
    })

    local iceMerchant = NPC({
        animations = ENTITY_DEFS['ice-merchant'].animations,
        width = ENTITY_DEFS['ice-merchant'].width,
        height = ENTITY_DEFS['ice-merchant'].height,
        mapX = 30,
        mapY = 7,
        level = self,
        onInteract = ENTITY_DEFS['ice-merchant'].onInteract,
    })

    fruitMerchant.stateMachine = StateMachine({
        ['idle'] = function() return EntityIdleState(fruitMerchant) end,
    })

    iceMerchant.stateMachine = StateMachine({
        ['idle'] = function() return EntityIdleState(iceMerchant) end,
    })
    fruitMerchant:changeState('idle')
    iceMerchant:changeState('idle')

    table.insert(self.entities, fruitMerchant)
    table.insert(self.entities, iceMerchant)

end

function Level:generateWeatherForecast()
    self.weatherForecast = {}
    for i = 1, 3 do
        table.insert(self.weatherForecast, WEATHER_DEFS[math.random(#WEATHER_DEFS)])
    end
end

function Level:tweenCoin(object)
    Timer.after(1 / self.gameSpeed, function()
        local coin = GameObject(GAME_OBJECT_DEFS['coin'], object.mapX + 1, object.mapY - 1)

        table.insert(self.objects, coin)

        Timer.tween(0.3 / self.gameSpeed, {
            [coin] = { y = coin.y - 16 }
        }):finish(function()
            table.remove(self.objects)
        end)
    end)
end

function Level:refresh()
    self.objects['lemonade-stand'].inventory.lemon = 1
    self.objects['lemonade-stand'].inventory.ice = 1
    self.objects['fruit-stand'].inventory.quantity = 100
    self.objects['ice-shed'].inventory.quantity = 10
end

function Level:refreshStock()
    GAME_OBJECT_DEFS['fruit-stand'].inventory.quantity = GAME_OBJECT_DEFS['fruit-stand'].inventory.quantity + 100
    GAME_OBJECT_DEFS['ice-shed'].inventory.quantity = GAME_OBJECT_DEFS['ice-shed'].inventory.quantity + 10
end
