require '../libs/AnAL'

Projectile = class('Projectile')

function Projectile:initialize()
  shots = {}
  start = 0
  self.speed = 500
  projectileimg = love.graphics.newImage("Assets/projectile.png")
end
function Projectile:shoot(x, y, dir, damage)
  local shot = {}
  shot.dir = dir
  shot.x = x + 95
  shot.y = y + 150
  shot.damage = damage
  table.insert(shots, shot)
  start = 1
end
function Projectile:clean()
  for k,v in pairs(shots) do shots[k]=nil end
end
function Projectile:update(dt)
  if start == 1 then
    local remShot = {}
    for i,v in ipairs(shots) do
      --v.x = v.x + dt * self.speed
      ax = self.speed * dt * math.cos(v.dir)
      ay = self.speed * dt * math.sin(v.dir)
      v.x = v.x - ax
      v.y = v.y - ay
      if (v.x > WINDOW_WIDTH) or (v.x < 0) or (v.y < 0) or (v.y > WINDOW_HEIGHT) then --Check if out of screen, then remove..
        table.insert(remShot, i)
      end
    end
    for i,v in ipairs(remShot) do
      table.remove(shots, v)
    end
  end
end
function Projectile:draw()
  if start == 1 then
    for i,v in ipairs(shots) do
      love.graphics.draw(projectileimg, v.x, v.y)
    end
  end
end
