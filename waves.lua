Waves = class('Waves')

local g = love.graphics

function Waves:initialize()
  self.currentWave = 1
  self.maxLevels = 9
  waveinactive = true
end
function Waves:update(dt)
  if waveinactive == true then
    if self.currentWave == 1 then --Level 1
      troll:spawn(1280, 433, 50, 30, 4)
      troll:spawn(1280, 600, 50, 30, 4)
    elseif self.currentWave == 2 then --Level 2
      troll:spawn(1500, 433, 80, 40, 4)
      troll:spawn(1500, 600, 100, 35, 4)
      troll:spawn(1500, 700, 100, 35, 4)
    elseif self.currentWave == 3 then
      troll:spawn(1500, 433, 85, 80, 4)
      troll:spawn(1500, 600, 90, 35, 4)
      troll:spawn(1500, 500, 100, 35, 4)
      troll:spawn(1500, 520, 100, 60, 4)
      troll:spawn(1500, 420, 100, 50, 4)
    elseif self.currentWave == 4 then
      troll:spawn(1500, 433, 85, 80, 4)
      troll:spawn(1500, 600, 90, 35, 4)
      troll:spawn(1500, 500, 100, 35, 4)
      troll:spawn(1500, 520, 100, 60, 4)
      troll:spawn(1500, 420, 100, 50, 4)
      troll:spawn(-200, 520, 20, 200, 4)
    elseif self.currentWave == 5 then
      troll:spawn(-400, 820, 20, 200, 4)
      troll:spawn(-200, 520, 20, 200, 4)
      troll:spawn(1500, 520, 100, 60, 4)
      troll:spawn(1500, 433, 80, 40, 4)
      troll:spawn(1500, 520, 100, 60, 4)
      troll:spawn(600, 900, 40, 100, 4)
    elseif self.currentWave == 6 then
      troll:spawn(-400, 820, 20, 200, 4)
      troll:spawn(-200, 520, 20, 200, 4)
      troll:spawn(1500, 520, 100, 60, 4)
      troll:spawn(1500, 433, 80, 40, 4)
      troll:spawn(1500, 520, 100, 60, 4)
      troll:spawn(600, 900, 40, 100, 4)
      troll:spawn(1500, 600, 90, 35, 4)
      troll:spawn(1500, 500, 100, 35, 4)
      troll:spawn(200, 800, 40, 150, 4)
      troll:spawn(-800, 800, 70, 220, 4)
    elseif self.currentWave == 7 then
      troll:spawn(-400, 820, 50, 200, 4)
      troll:spawn(-200, 520, 50, 200, 4)
      troll:spawn(-200, 920, 50, 200, 4)
    elseif self.currentWave == 8 then
      troll:spawn(1500, 433, 85, 80, 5)
      troll:spawn(1500, 600, 90, 35, 4)
      troll:spawn(1500, 500, 100, 35, 5)
      troll:spawn(1500, 520, 100, 60, 6)
      troll:spawn(1500, 420, 100, 50, 5)
      troll:spawn(-200, 520, 20, 200, 4)
    elseif self.currentWave == 9 then
      troll:spawn(1280, 500, 1337, 5, 20)
    end
    waveinactive = false
  elseif waveinactive == false then
    if table.getn(trolls) == 0 and self.currentWave < self.maxLevels then
      self.currentWave = self.currentWave + 1
      waveinactive = true
    elseif table.getn(trolls) == 0 and self.currentWave == self.maxLevels then
      stage = "win"
    end
  end
end
function Waves:draw()
  g.setFont(mainFont)
  if self.currentWave == 9 then
    g.printf("The last troll on the internet",250, 60, 800,"center")
  else
    g.printf("Wave "..self.currentWave.." of "..self.maxLevels,450, 60, 500,"center")
  end
  if self.currentWave < self.maxLevels then
    g.printf(table.getn(trolls).." more to kill", 500, 90, 500, "center")
  end
  g.setFont(defaultfont)
end
