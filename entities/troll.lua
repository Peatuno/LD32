require '../libs/AnAL'

Troll = class('Troll')

local g = love.graphics

function Troll:initialize()
  trollimg = g.newImage("Assets/troll.png")
  trolls = {}
end
function Troll:spawn(x, y, hp, speed, drops)
  local troll = {}
  troll.x = x
  troll.y = y
  troll.hp = hp
  troll.speed = speed
  troll.damage = 0.01
  troll.look = "left"
  troll.drops = drops
  table.insert(trolls, troll)
end
function Troll:update(dt)
  local remShot = {} remTroll = {}
  for i,v in ipairs(shots) do
    for j,k in ipairs(trolls) do
      if CheckCollision(v.x, v.y, 16, 16, k.x, k.y, 60, 128) then
        --kanske någon animation att dom får ont :/
        k.hp = k.hp - v.damage
        table.insert(remShot, i)
        if k.hp <= 1 then --död
          for i=1,k.drops do
            coins:drop(k.x+20+(i*4), k.y+128+(i*2), "gold")
          end
          table.insert(remTroll, j)
        end
      end
    end
  end
  for i,v in ipairs(remShot) do --remove shots
    table.remove(shots, v)
  end
  for i,v in ipairs(remTroll) do --remove trollz
    table.remove(trolls, v)
  end
  for i,v in ipairs(trolls) do --Move them trollz
    if (v.x - 70 - player.x) > 0 then
      v.look = "left"
    elseif (v.x - 70 - player.x) < 0 then
      v.look = "right"
    end
    local dir = math.atan2(v.y-150-player.y,v.x-85-player.x)
    ax = v.speed * dt * math.cos(dir)
    ay = v.speed * dt * math.sin(dir)
    v.x = v.x - ax
    v.y = v.y - ay
  end
end
function Troll:draw()
  for i,v in ipairs(trolls) do
    if v.look == "left" then
      g.draw(trollimg, v.x, v.y, 0)
    elseif v.look == "right" then
      g.draw(trollimg, v.x, v.y, 0, -1, 1, 64)
    end
    if v.hp <= 50 then
      g.setColor(255, 0, 0)
      g.print(v.hp, v.x+25, v.y-20)
      g.reset()
    else
      g.print(v.hp, v.x+25, v.y-20)
    end
    --v.animation:draw(v.x, v.y)
  end
end
