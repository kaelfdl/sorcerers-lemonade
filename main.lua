--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

require 'src/Dependencies'

function love.load()
    math.randomseed(os.time())
    love.window.setTitle("Witcher's Lemonade")

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gStateStack = StateStack()

    gStateStack:push(StartState())
    love.keyboard.keysPressed = {}
end

function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end
