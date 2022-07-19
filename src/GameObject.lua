--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

GameObject = Base:extend()

function GameObject:constructor(def, mapX, mapY)
    self.type = def.type
    self.texture = def.texture
    self.frame = def.frame or 1
    self.frames = def.frames or {}

    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    self.mapX = mapX
    self.mapY = mapY
    self.x = (self.mapX - 1) * TILE_SIZE
    self.y = (self.mapY - 1) * TILE_SIZE
    self.width = def.width
    self.height = def.height


    self.onCollide = function() end
    self.onInteract = def.onInteract or function() end
    self.isAIInteractable = def.isAIInteractable or false
    self.isAvailable = def.isAvailable or false
    self.onAIInteract = def.onAIInteract or function() end
    self.inventory = def.inventory or {}
    self.isStand = def.isStand or false
    self.recipe = def.recipe or {}
    self.price = def.price or nil
end

function GameObject:update(dt)

    if self.isStand then
        local lemon = self.inventory.lemon
        local ice = self.inventory.ice

        if lemon > 0 and ice > 0 then
            self.state = 'full'
        elseif lemon <= 0 and ice > 0 then
            self.state = 'ice'
        elseif lemon > 0 and ice <= 0 then
            self.state = 'juice-lemon'
        elseif lemon <= 0 and ice <= 0 then
            self.state = 'empty'
        end
    end
end

function GameObject:render()
    if #self.frames > 0 then
        for y = 1, self.height / TILE_SIZE do
            for x = 1, self.width / TILE_SIZE do
                love.graphics.draw(gTextures[self.texture],
                    gFrames[self.texture][
                    self.states[self.state].frames[x + (y - 1) * (self.width / TILE_SIZE)] or
                        self.frames[x + (y - 1) * (self.width / TILE_SIZE)]]
                    ,
                    self.x + (x - 1) * TILE_SIZE, self.y + (y - 1) * TILE_SIZE)
            end
        end
    else
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
            self.x,
            self.y)
    end

    -- Collision box for debugging
    -- love.graphics.setColor(0, 1, 1, 1)
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(1, 1, 1, 1)
end
