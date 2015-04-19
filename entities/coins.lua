require '../libs/AnAL'

Coins = class('Coins')

function Coins:initialize()
  self.goldcoin = love.graphics.newImage("Assets/coin_gold.png")
  self.goldcoinanim = newAnimation(self.goldcoin, 16, 16, 0.08, 0)
  self.goldcoinanim:setMode("bounce")
  self.dropdcoins = {}
end
function Coins:drop(x, y, type)
  local coin = {}
  coin.x = x
  coin.y = y
  if type == "gold" then
    coin.value = 10
  else
    coin.value = 1
  end
  table.insert(self.dropdcoins, coin)
end
function Coins:update(dt)
  local remCoins = {}
  for i,v in ipairs(self.dropdcoins) do
    if math.dist(player.x, player.y, v.x, v.y) < 500 then
      local dir = math.atan2(v.y-150-player.y,v.x-85-player.x)
      ax = 250 * dt * math.cos(dir)
      ay = 250 * dt * math.sin(dir)
      v.x = v.x - ax
      v.y = v.y - ay
    end
    if math.dist(player.x+85, player.y+150, v.x, v.y) < 5 then
      table.insert(remCoins, i)
      player.cashmoney = player.cashmoney + v.value
    end
  end
  for i,v in ipairs(remCoins) do
    table.remove(self.dropdcoins, v)
  end
  self.goldcoinanim:update(dt)
end
function Coins:draw()
  for i,v in ipairs(self.dropdcoins) do
    self.goldcoinanim:draw(v.x, v.y)
  end
end
