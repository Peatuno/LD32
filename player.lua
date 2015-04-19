require 'libs/AnAL'
require 'settings'
require 'entities/projectile'

local k = love.keyboard
local m = love.mouse

Player = class('Player')
--Player:include(Stateful)

function Player:initialize(x, y)
  --cords
  self.x = x
  self.y = y
  --gfx
  self.width = 128
  self.height = 256
  self.idleimg = love.graphics.newImage("Assets/Sten_idle.png")
  self.runimg = love.graphics.newImage("Assets/Sten_run.png")
  self.deadimg = love.graphics.newImage("Assets/Sten_dead.png")
  self.idleanim = newAnimation(self.idleimg, self.width, self.height, 1.5, 0)
  self.runanim = newAnimation(self.runimg, self.width, self.height, 0.1, 0)
  self.deadanim = newAnimation(self.deadimg, self.width, self.height, 0.1, 0)
  self.deadanim:setMode("once")
  self.anim = self.idleanim
  --other things..
  self.velocity = 0
  self.shooting = 0
  self.look = "right"
  --stats
  self.hp = 100
  self.energy = 200
  self.cashmoney = 0
  self.runPower = 250
  self.jump_height = 300
  self.damage = 5
end
function Player:update(dt, gravity)
  --Check if alive, first..
  if self.hp < 0 then
    stage = "dead"
    self.anim = self.deadanim
  else --Okey we are alive!
    local mouse_x, mouse_y = m.getPosition()
    if (mouse_x - 70 - self.x) < 0 then
      self.look = "left"
    elseif (mouse_x - 70 - self.x) > 0 then
      self.look = "right"
    end
    if k.isDown("d") then --move right
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
    elseif k.isDown("a") and self.x > 0 then --move left
      self.anim = self.runanim
      self.x = self.x - dt * self.runPower
    else
      self.anim = self.idleanim
    end
    if k.isDown(" ") and self.velocity == 0 then --jump
      self.anim = self.idleanim
      self.velocity = self.jump_height
    end
    if m.isDown("l") and self.shooting == 0 and ShopToggle == false and self.energy > 0 then --left mouse to shoot
      local mousex, mousey = love.mouse.getPosition()
      local dir = math.atan2(self.y+150-mousey,self.x+95-mousex)
      if self.look == "right" then
        Projectile:shoot(self.x, self.y, dir, self.damage)
      elseif self.look == "left" then
      Projectile:shoot(self.x-75, self.y, dir, self.damage)
      end
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
    elseif self.x < 0 and stage =="outside_night_1" then --Go inside (shop) again
      Projectile:clean()
      stage = "start"
      self.x = WINDOW_WIDTH - self.width
      morestages = true
    end
    --Take damage of trollz
    for i,v in ipairs(trolls) do
      if CheckCollision(self.x, self.y, self.width-40, self.height, v.x, v.y, 60, 128) and stage == "outside_night_1" then
        self.hp = self.hp - v.damage
      end
    end
  end
  self.anim:update(dt)
end
function Player:draw()
  if self.look == "right" then
    self.anim:draw(self.x, self.y)
  elseif self.look == "left" then
    self.anim:draw(self.x, self.y, 0, -1, 1, self.width)
  end
end
