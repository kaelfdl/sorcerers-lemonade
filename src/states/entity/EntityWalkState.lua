--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

EntityWalkState = EntityBaseState:extend()

function EntityWalkState:constructor(entity, level)
    self.entity = entity
    self.level = level
    self.bumped = false
    self.moveDuration = 0
    self.movementTimer = 0
    self.isWalking = false

end

function EntityWalkState:enter(params)
    self.bumped = false
    self:attemptMove()
end

function EntityWalkState:attemptMove()
    self.isWalking = true
    self.entity:changeAnimation('walk-' .. self.entity.direction)


    local toX, toY = self.entity.mapX, self.entity.mapY
    local origX, origY = self.entity.mapX, self.entity.mapY

    if self.entity.direction == 'left' then
        toX = toX - 1
    elseif self.entity.direction == 'right' then
        toX = toX + 1
    elseif self.entity.direction == 'up' then
        toY = toY - 1
    elseif self.entity.direction == 'down' then
        toY = toY + 1
    end

    if toX < 1 or toX > MAP_WIDTH or toY < 1 or toY > MAP_HEIGHT then
        self.entity:changeState('idle')
        self.entity:changeAnimation('idle-' .. self.entity.direction)
        return
    end



    self.entity.mapX = toX
    self.entity.mapY = toY


    for k, object in pairs(self.level.objects) do
        if self.entity:collides(object) then
            if object.isAIInteractable and object.isOpen and object.isAvailable and self.entity ~= self.level.player and
                self.entity.canInteract then
                object.onAIInteract(object, self.entity)
                return
            else
                self.bumped = true
                self.entity.mapX = origX
                self.entity.mapY = origY

                self.entity:changeState('idle')
                self.entity:changeAnimation('idle-' .. self.entity.direction)
                return
            end

        end
    end

    for y = 1, MAP_HEIGHT do
        for x = 1, MAP_WIDTH do
            local tile = self.level.fenceLayer.tiles[y][x]
            if self.entity.mapX == tile.x and self.entity.mapY == tile.y and
                tile.id ~= TILE_IDS['empty'] then
                self.bumped = true
                self.entity.mapX = origX
                self.entity.mapY = origY

                self.entity:changeState('idle')
                self.entity:changeAnimation('idle-' .. self.entity.direction)
                return
            end
        end
    end
    for k, entity in pairs(self.level.entities) do
        if self.entity:collides(entity) then
            self.bumped = true
            self.entity.mapX = origX
            self.entity.mapY = origY

            self.entity:changeState('idle')
            self.entity:changeAnimation('idle-' .. self.entity.direction)
            return
        end
    end

    if self.entity:collides(self.level.player) and self.entity ~= self.level.player then
        self.bumped = true
        self.entity.mapX = origX
        self.entity.mapY = origY
        self.entity:changeState('idle')
        self.entity:changeAnimation('idle-' .. self.entity.direction)
        return
    end

    Timer.tween(0.25 / self.entity.level.gameSpeed, {
        [self.entity] = { x = (toX - 1) * TILE_SIZE, y = (toY - 1) * TILE_SIZE - self.entity.height / 2 }
    }):finish(function()
        self.isWalking = false
        if self.entity == self.level.player then
            if love.keyboard.isDown('left') then
                self.entity.direction = 'left'
                self.entity:changeState('walk')
            elseif love.keyboard.isDown('right') then
                self.entity.direction = 'right'
                self.entity:changeState('walk')
            elseif love.keyboard.isDown('up') then
                self.entity.direction = 'up'
                self.entity:changeState('walk')
            elseif love.keyboard.isDown('down') then
                self.entity.direction = 'down'
                self.entity:changeState('walk')
            else
                self.entity:changeState('idle')
            end
        else
            self:attemptMove()
        end
    end)
end

function EntityWalkState:processAI(params, dt)
    local directions = { 'left', 'right', 'down', 'up' }

    if not self.isWalking then
        self.entity:changeAnimation('idle-' .. self.entity.direction)
    end
    if self.moveDuration == 0 or self.bumped then
        self.moveDuration = math.random(5) / self.entity.level.gameSpeed
        self.entity.direction = directions[math.random(#directions)]
        if not self.isWalking then
            self:attemptMove()
        end
    elseif self.movementTimer > self.moveDuration then
        self.movementTimer = 0

        -- chance to go idle
        if math.random(3) == 1 then
            self.entity:changeState('idle')
        else
            self.moveDuration = math.random(5) / self.entity.level.gameSpeed
            self.entity.direction = directions[math.random(#directions)]
            if not self.isWalking then
                self:attemptMove()

            end
        end
    end
    self.movementTimer = self.movementTimer + dt
end
