local MAX_TIME = 1
local explosions = {}
function loadExplosions()
end
function drawExplosions()
  for _,explosion in ipairs(explosions) do
  	local random = math.random;
  	for i=1,random(5,40) do
  	   love.graphics.setColor(random(128,255),random(50,60),random(0,10),((((explosion.time/MAX_TIME)*255)*-1)+255*2)/2+255)
       love.graphics.point((explosion.x-explosion.time*120+0.1)+random(explosion.time*240+0.1),(explosion.y-explosion.time*120+0.1)+random(explosion.time*240+0.1));
       love.graphics.setColor(255, 255, 255, 255)
    end
  end
end
function updateExplosions(dt)
  local explosion
  for i = #explosions,1,-1 do
    explosion = explosions[i]
    explosion.time = explosion.time + dt
    if explosion.time > MAX_TIME then
      table.remove(explosions, i)
    end
  end
end
function newExplosion(x,y)
  table.insert(explosions, {x=x,y=y,time=0})
end
