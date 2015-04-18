require 'libs/AnAL'
require 'settings'

local k = love.keyboard

Player = class('Player')
Player:include(Stateful)

function Player:initialize(x, y)
  --cords
  self.x = x
  self.y = y

  --gfx
  self.width = 128
  self.height = 256
  self.idleimg = love.graphics.newImage("Assets/Sten_idle.png")
  self.runimg = love.graphics.newImage("Assets/Sten_run.png")
  self.idleanim = newAnimation(self.idleimg, self.width, self.height, 0.1, 0)
  self.runanim = newAnimation(self.runimg, self.width, self.height, 0.1, 0)

  self.anim = self.idleanim

  --other things..
  self.runPower = 250
  self.velocity = 0
  self.jump_height = 300
end

function Player:update(dt, gravity)
  if k.isDown("d") and self.x < (WINDOW_WIDTH - self.width) then
    self.anim = self.runanim
    self.x = self.x + dt * self.runPower
  elseif k.isDown("a") and self.x > 0 then
    self.x = self.x - dt * self.runPower
  else
    self.anim = self.idleanim
  end
  if k.isDown(" ") and self.velocity == 0 then
    self.anim = self.idleanim
    self.velocity = self.jump_height
  end


  if self.velocity ~= 0 then --If velocity isnt 0, well then we're jumping.
    self.y = self.y - self.velocity * dt
    self.velocity = self.velocity - gravity * dt
    if self.y > BORDER_Y then
      --self.anim = self.idleanim
      self.velocity = 0
      self.y = BORDER_Y
    end
  end


  self.anim:update(dt)
end


function Player:draw()
  self.anim:draw(self.x, self.y)
  --love.graphics.draw(self.idle, self.x, self.y)

  --love.graphics.print("Y: "..self.y, 30, 20)
end
