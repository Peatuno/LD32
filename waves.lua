Waves = class('Waves')

local g = love.graphics

function Waves:initialize()
  self.currentWave = 1
  self.maxLevels = 3
  waveinactive = true
end
function Waves:update(dt)
  if waveinactive == true then
    if self.currentWave == 1 then --Level 1
      troll:spawn(1280, 433, 50, 30)
      troll:spawn(1280, 600, 50, 30)
    elseif self.currentWave == 2 then --Level 2
      troll:spawn(1380, 433, 80, 40)
      troll:spawn(1380, 600, 100, 35)
      troll:spawn(1300, 500, 100, 35)
    elseif self.currentWave == 3 then
      troll:spawn(1380, 433, 85, 80)
      troll:spawn(1380, 600, 90, 35)
      troll:spawn(1300, 500, 100, 35)
      troll:spawn(1280, 520, 100, 60)
      troll:spawn(1380, 420, 100, 50)
    end
    waveinactive = false
  elseif waveinactive == false then
    if table.getn(trolls) == 0 and self.currentWave < self.maxLevels then
      self.currentWave = self.currentWave + 1
      waveinactive = true
    end
  end
end
function Waves:draw()
  g.setFont(mainFont)
  g.printf("Wave "..self.currentWave,550, 60, 200,"center")
  g.printf(table.getn(trolls).." more to kill", 500, 90, 500, "center")
  g.setFont(defaultfont)
end
