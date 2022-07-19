--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

Menu = Base:extend()

function Menu:constructor(def)
    self.panel = Panel(def.x, def.y, def.width, def.height)

    self.selection = Selection({
        items = def.items,
        x = def.x,
        y = def.y,
        width = def.width,
        height = def.height,
        font = def.font
    })
end

function Menu:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    self.selection:update(dt)
end

function Menu:render()
    self.panel:render()
    self.selection:render()
end
