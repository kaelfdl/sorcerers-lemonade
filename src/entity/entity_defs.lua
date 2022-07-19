--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

ENTITY_DEFS = {
    ['player'] = {
        animations = {
            ['idle-down'] = {
                frames = { 5 },
            },
            ['idle-left'] = {
                frames = { 17 },
            },
            ['idle-right'] = {
                frames = { 29 },
            },
            ['idle-up'] = {
                frames = { 41 },
            },
            ['walk-down'] = {
                frames = { 4, 5, 6, 5 },
                interval = 0.3
            },
            ['walk-left'] = {
                frames = { 16, 17, 18, 17 },
                interval = 0.3
            },
            ['walk-right'] = {
                frames = { 28, 29, 30, 29 },
                interval = 0.3
            },
            ['walk-up'] = {
                frames = { 40, 41, 42, 41 },
                interval = 0.3
            },

        },
        width = TILE_SIZE,
        height = TILE_SIZE,
        mapX = 10,
        mapY = 10
    },
    ['NPC-1'] = {
        animations = {
            ['idle-down'] = {
                frames = { 802 },
                texture = 'blowhard_entities'
            },
            ['idle-left'] = {
                frames = { 805 },
                texture = 'blowhard_entities',
                flip = true
            },
            ['idle-right'] = {
                frames = { 805 },
                texture = 'blowhard_entities'
            },
            ['idle-up'] = {
                frames = { 808 },
                texture = 'blowhard_entities'
            },
            ['walk-down'] = {
                frames = { 803, 802, 804, 802 },
                texture = 'blowhard_entities',
                interval = 0.3
            },
            ['walk-left'] = {
                frames = { 806, 805, 807, 805 },
                texture = 'blowhard_entities',
                interval = 0.3,
                flip = true
            },
            ['walk-right'] = {
                frames = { 806, 805, 807, 805 },
                texture = 'blowhard_entities',
                interval = 0.3
            },
            ['walk-up'] = {
                frames = { 809, 808, 810, 808 },
                texture = 'blowhard_entities',
                interval = 0.3
            },
        },
        width = TILE_SIZE,
        height = TILE_SIZE,
        shouldProcessAI = true
    },
    ['fruit-merchant'] = {
        animations = {
            ['idle-down'] = {
                frames = { 8 },
            },
            ['idle-left'] = {
                frames = { 20 },
            },
            ['idle-right'] = {
                frames = { 32 },
            },
            ['idle-up'] = {
                frames = { 44 },
            }
        },
        width = TILE_SIZE,
        height = TILE_SIZE,
        onInteract = function(entity, player)
            -- Pause the time and a push a buy menu state
            player.level.gameTimer:remove()
            gStateStack:push(BuyMenuState(entity.level, 'fruit-stand', function()
                player.level.gameTimer = Timer.every(1, function()
                    player.level.timer = player.level.timer - 1
                end)
            end))
        end
    },
    ['ice-merchant'] = {
        animations = {
            ['idle-down'] = {
                frames = { 2 },
            },
            ['idle-left'] = {
                frames = { 14 },
            },
            ['idle-right'] = {
                frames = { 26 },
            },
            ['idle-up'] = {
                frames = { 38 },
            }
        },
        width = TILE_SIZE,
        height = TILE_SIZE,
        onInteract = function(entity, player)
            -- Pause the time and a push a buy menu state
            player.level.gameTimer:remove()
            gStateStack:push(BuyMenuState(entity.level, 'ice-shed', function()
                player.level.gameTimer = Timer.every(1, function()
                    player.level.timer = player.level.timer - 1
                end)
            end))
        end
    }
}
