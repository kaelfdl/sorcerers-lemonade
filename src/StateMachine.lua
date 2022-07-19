--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

StateMachine = Base:extend()

function StateMachine:constructor(states)
    self.empty = {
        enter = function() end,
        update = function() end,
        render = function() end,
        exit = function() end,
    }
    self.states = states or {}
    self.current = self.empty
end

function StateMachine:change(state, params)
    assert(self.states[state])
    self.current:exit()
    self.current = self.states[state]()
    self.current:enter(params)
end

function StateMachine:update(dt)
    self.current:update(dt)
end

function StateMachine:render()
    self.current:render()
end

function StateMachine:processAI(params, dt)
    self.current:processAI(params, dt)
end
