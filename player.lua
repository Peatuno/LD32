require 'libs/AnAL'
require 'settings'
require 'entities/projectile'

local k = love.keyboard
local m = love.mouse

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
  self.idleanim = newAnimation(self.idleimg, self.width, self.height, 1.5, 0)
  self.runanim = newAnimation(self.runimg, self.width, self.height, 0.1, 0)

  self.anim = self.idleanim

  --other things..
  self.runPower = 250
  self.velocity = 0
  self.jump_height = 300
  self.shooting = 0

  --stats
  self.hp = 100
  self.energy = 200
  self.cashmoney = 250
end

function Player:update(dt, gravity)
  if k.isDown("d") then
    if morestages == false then
      if self.x < (WINDOW_WIDTH - self.width) then
        self.anim = self.runanim
        self.x = self.x + dt * self.runPower
      end
    else
      if self.x < (WINDOW_WIDTH) then
        self.anim = self.runanim
        self.x = self.x + dt * self.runPower
      end
    end
  elseif k.isDown("a") and self.x > 0 then
    self.x = self.x - dt * self.runPower
  else
    self.anim = self.idleanim
  end
  if k.isDown(" ") and self.velocity == 0 then
    self.anim = self.idleanim
    self.velocity = self.jump_height
  end
  if m.isDown("l") and self.shooting == 0 and ShopToggle == false then
    local mousex, mousey = love.mouse.getPosition()
    local dir = math.atan2(self.y+150-mousey,self.x+95-mousex)
    Projectile:shoot(self.x, self.y, dir)
    self.shooting = 1
    self.energy = self.energy - 1
  end
  if not m.isDown("l") and self.shooting == 1 then
    self.shooting = 0
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

  --Stage-thingy, change to next stage or viseversa..
  if self.x > (WINDOW_WIDTH-20) and stage == "start" then --Next stage outside night
    Projectile:clean()
    self.x = 1
    stage = "outside_night_1"
    morestages = false
  elseif self.x < 0 and stage =="outside_night_1" then
    Projectile:clean()
    stage = "start"
    self.x = WINDOW_WIDTH - self.width
    morestages = true
  end
  self.anim:update(dt)
end


function Player:draw()
  self.anim:draw(self.x, self.y)
  --love.graphics.draw(self.idle, self.x, self.y)

  --love.graphics.print("Y: "..self.y, 30, 20)
end
