--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

GAME_OBJECT_DEFS = {
    ['house'] = {
        type = 'building',
        texture = 'house_kit',
        frames = { 59, 60, 61, 62, 84, 85, 86, 87, 109, 110, 111, 112, 134, 135, 136, 137 },
        width = 64,
        height = 64,
        solid = true,
        defaultState = 'default',
        states = {
            ['default'] = {
                frames = { 59, 60, 61, 62, 84, 85, 86, 87, 109, 110, 111, 112, 134, 135, 136, 137 }
            }
        },
    },
    ['town-hall'] = {
        type = 'building',
        texture = 'house_kit',
        frames = { 27, 28, 29, 30, 31, 32, 52, 53, 54, 55, 56, 57, 77, 78, 79, 80, 81, 82, 102, 103, 104, 105, 106, 107,
            127, 128, 129, 130, 131, 132 },
        width = 96,
        height = 80,
        solid = true,
        defaultState = 'default',
        states = {
            ['default'] = {
                frames = { 27, 28, 29, 30, 31, 32, 52, 53, 54, 55, 56, 57, 77, 78, 79, 80, 81, 82, 102, 103, 104, 105,
                    106, 107,
                    127, 128, 129, 130, 131, 132 }
            }
        },
    },
    ['lemonade-stand'] = {
        type = 'stand',
        texture = 'lemonade_stand',
        frames = { 1, 2, 17, 18 },
        width = 32,
        height = 32,
        solid = true,
        inventory = {
            ['lemon'] = 0,
            ['ice'] = 0,
            ['juice'] = 0
        },
        recipe = {
            ['lemon'] = 1,
            ['ice'] = 1,
        },
        defaultState = 'full',
        states = {
            ['full'] = {
                frames = { 1, 2, 17, 18 },
            },
            ['juice-lemon'] = {
                frames = { 5, 6, 21, 22 }
            },
            ['ice'] = {
                frames = { 11, 12, 27, 28 }
            },
            ['empty'] = {
                frames = { 15, 16, 31, 32 }
            },
        },
        onInteract = function(object, player)
            player.direction = 'down'
            player:changeState('interact', {
                object = object
            })
        end,
        onAIInteract = function(object, entity)
            object.isAvailable = false
            entity.direction = 'up'
            entity:changeState('interact', {
                object = object
            })
        end,
        isAvailable = true,
        isAIInteractable = true,
        isOpen = false,
        isStand = true,
        price = 1
    },
    ['fruit-stand'] = {
        type = 'stand',
        texture = 'fruit_stand',
        frames = { 1, 2, 5, 6 },
        width = 32,
        height = 32,
        solid = true,
        inventory = {
            ['lemon'] = {
                quantity = 100,
                cost = 2
            }
        },
        defaultState = 'full',
        states = {
            ['full'] = {
                frames = { 1, 2, 5, 6 }
            },
            ['empty'] = {
                frames = {
                    3, 4, 7, 8
                }
            }
        }
    },
    ['ice-shed'] = {
        type = 'building',
        texture = 'house_kit',
        frames = { 64, 65, 66, 67, 68, 69, 89, 90, 91, 92, 93, 94, 114, 115, 116, 117, 118, 119, 139, 140, 141, 142, 143,
            144 },
        width = 96,
        height = 64,
        solid = true,
        inventory = {
            ['ice'] = {
                quantity = 10,
                cost = 0.5
            },
        },
        defaultState = 'default',
        states = {
            ['default'] = {
                frames = { 64, 65, 66, 67, 68, 69, 89, 90, 91, 92, 93, 94, 114, 115, 116, 117, 118, 119, 139, 140, 141,
                    142, 143, 144 }
            }
        }
    },
    ['coin'] = {
        type = 'coin',
        texture = 'coins',
        frame = 3,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'default',
        states = {
            ['default'] = {
                frame = 3
            }
        }
    }
}
