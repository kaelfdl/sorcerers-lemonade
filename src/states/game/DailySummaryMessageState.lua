--[[
    Sorcerer's Lemonade

    Author: Gabryel Flor de Lis
    gabryel.flordelis@gmail.com
]]

DailySummaryMessageState = BaseState:extend()

function DailySummaryMessageState:constructor(level, callback)
    self.level = level
    self.callback = callback
    self.summaryMessage = Menu({
        x = 4,
        y = 4,
        width = VIRTUAL_WIDTH - 8,
        height = 112,
        font = gFonts['medium'],
        items = {
            {
                text = 'Day ' .. tostring(self.level.day) .. ' Summary'
            },
            {
                text = 'Lemonades sold: ' .. tostring(self.level.dailyProgress.lemonadeSold)
            },
            {
                text = 'Revenue: ' ..
                    tostring(self.level.dailyProgress.revenue) ..
                    (self.level.dailyProgress.revenue == 1 and ' coin' or ' coins')
            },
            {
                text = 'Stock used: ' ..
                    tostring(self.level.dailyProgress.stockUsed) ..
                    (self.level.dailyProgress.stockUsed == 1 and ' coin' or ' coins')
            },
            {
                text = 'Stock lost: ' ..
                    tostring(self.level.dailyProgress.stockLost) ..
                    (self.level.dailyProgress.stockLost == 1 and ' coin' or ' coins')
            },
            {
                text = 'Total Earnings: ' ..
                    tostring(self.level.dailyProgress.totalEarnings) ..
                    (self.level.dailyProgress.totalEarnings == 1 and ' coin' or ' coins')
            }
        }
    })
    self.summaryMessage.selection.showCursor = false
end

function DailySummaryMessageState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:pop()
        self.callback()
    end
end

function DailySummaryMessageState:render()
    self.summaryMessage:render()
end
