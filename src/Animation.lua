--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

Animation = Base:extend()

function Animation:constructor(def)
    self.frames = def.frames
    self.interval = def.interval or 1
    self.texture = def.texture or 'entities'
    self.looping = def.looping or true

    self.currentFrame = 1
    self.timer = 0

    self.timesPlayed = 0
    self.flip = def.flip or false
    self.gameSpeed = def.gameSpeed
end

function Animation:refresh()
    self.timer = 0
    self.currentFrame = 1
    self.timesPlayed = 0
end

function Animation:update(dt)

    if not self.looping and self.timesPlayed > 0 then
        return
    end

    if #self.frames > 1 then
        self.timer = self.timer + dt
        if self.timer > self.interval / self.gameSpeed then
            self.timer = self.timer % self.interval / self.gameSpeed
            self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))

            if self.currentFrame == 1 then
                self.timesPlayed = self.timesPlayed + 1
            end
        end
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end
