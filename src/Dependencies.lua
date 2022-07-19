--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

-- Class = require 'lib/class'
push = require 'lib/push'

Base = require 'lib/base'
Timer = require 'lib/knife/timer'

require 'src/constants'
require 'src/Util'
require 'src/Animation'

require 'src/GameObject'
require 'src/game_objects'

require 'src/gui/Panel'
require 'src/gui/Textbox'
require 'src/gui/Selection'
require 'src/gui/Menu'

require 'src/StateMachine'
require 'src/states/StateStack'
require 'src/states/BaseState'

require 'src/states/game/StartState'
require 'src/states/game/PlayState'
require 'src/states/game/FadeInState'
require 'src/states/game/FadeOutState'
require 'src/states/game/DialogueState'
require 'src/states/game/BuyMenuState'
require 'src/states/game/RecipeMenuState'
require 'src/states/game/DailySummaryMessageState'
require 'src/states/game/GameoverState'
require 'src/states/game/IntroDialogueState'

require 'src/states/entity/EntityBaseState'
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/EntityInteractingState'
require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerWalkState'
require 'src/states/entity/PlayerInteractingState'

require 'src/world/Level'
require 'src/world/Tile'
require 'src/world/TileMap'
require 'src/world/tile_ids'
require 'src/world/weather_defs'

require 'src/entity/Entity'
require 'src/entity/Player'
require 'src/entity/NPC'
require 'src/entity/entity_defs'

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32),
}

gSounds = {
    ['coin'] = love.audio.newSource('sounds/coin.wav', 'static'),
    ['enter'] = love.audio.newSource('sounds/enter.wav', 'static'),
    ['select'] = love.audio.newSource('sounds/select.wav', 'static'),

    -- https://opengameart.org/content/town-theme-rpg
    ['game-music'] = love.audio.newSource('sounds/TownTheme.mp3', 'static'),

}

gTextures = {

    ['tiles'] = love.graphics.newImage('graphics/sheet.png'),


    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['lemonade_stand'] = love.graphics.newImage('graphics/lemonade_stand.png'),
    ['fruit_stand'] = love.graphics.newImage('graphics/fruit_stand.png'),
    ['lemon_ice'] = love.graphics.newImage('graphics/lemon_ice.png'),
    ['coins'] = love.graphics.newImage('graphics/coins_and_bombs.png'),
    ['weather'] = love.graphics.newImage('graphics/weather.png'),

    -- https://opengameart.org/content/tiny-16-basic
    ['entities'] = love.graphics.newImage('graphics/entities.png'),


    -- https://opengameart.org/content/orthographic-outdoor-tiles
    ['house_kit'] = love.graphics.newImage('graphics/house_kit.png'),
    -- https://opengameart.org/content/blowhard-2-blow-harder
    ['blowhard_entities'] = love.graphics.newImage('graphics/blowhard_entities.png'),
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE),
    ['house_kit'] = GenerateQuads(gTextures['house_kit'], TILE_SIZE, TILE_SIZE),
    ['lemon_ice'] = GenerateQuads(gTextures['lemon_ice'], TILE_SIZE, TILE_SIZE),
    ['lemonade_stand'] = GenerateQuads(gTextures['lemonade_stand'], TILE_SIZE, TILE_SIZE),
    ['fruit_stand'] = GenerateQuads(gTextures['fruit_stand'], TILE_SIZE, TILE_SIZE),
    ['entities'] = GenerateQuads(gTextures['entities'], TILE_SIZE, TILE_SIZE),
    ['coins'] = GenerateQuads(gTextures['coins'], TILE_SIZE, TILE_SIZE),
    ['weather'] = GenerateQuads(gTextures['weather'], TILE_SIZE, TILE_SIZE),
    ['blowhard_entities'] = GenerateQuads(gTextures['blowhard_entities'], TILE_SIZE, TILE_SIZE),
}
