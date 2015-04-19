HC       = require 'libs/hardoncollider'
class    = require 'libs/middleclass'
Stateful = require 'libs/stateful'
require 'settings'
require 'utils'
require 'player'
require 'entities/kyl'
require 'entities/troll'
require 'entities/coins'
require 'waves'

local k = love.keyboard
local g = love.graphics

Game = class('Game')

function Game:initialize()
  --Inside shop gfx
  bg = g.newImage("Assets/bg.png")
  desk = g.newImage("Assets/desk.png")
  screen = g.newImage("Assets/screen.png")
  screenanim = newAnimation(screen, 128, 128, 0.5, 0)
  --outside gfx
  outsidebg = g.newImage("Assets/outsidebg.png")
  trollimg = g.newImage("Assets/troll.png")
  --misc gfx
  crosshair = g.newImage("Assets/crosshair.png")
  statsbox = g.newImage("Assets/statsbox.png")
  player = Player:new(200, BORDER_Y)
  kyl = Kyl:new(950, 333)
  coins = Coins:new()
  troll = Troll:new()
  love.mouse.setVisible(false)
  projectile = Projectile:new()
  gravity = 400
  stage = "start"
  morestages = true
  waves = Waves:new()
  ShowShopText = false
  ShopToggle = false
  loveframes = require("libs.loveframes")
end
function Game:update(dt)
  player:update(dt, gravity)
  screenanim:update(dt)
  projectile:update(dt)
  if stage == "start" then
    if math.dist(player.x, player.y, 225, 404) < 90 then
      ShowShopText = true
    else
      ShowShopText = false
    end
    if k.isDown("e") and ShowShopText == true then --Shop gui thing..
      if ShopToggle == false then
        ShopToggle = true
        ShowShopText = false
        love.mouse.setVisible(true)
        local shopframe = loveframes.Create("frame")
        shopframe:SetName("Shop"):SetPos(500, 200)
        local button1 = loveframes.Create("button", shopframe) --HP
        button1:SetText("Medkit (+10 hp) - Cost: 80$"):SetWidth(260):SetPos(20, 40)
        button1.OnClick = function()
          if player.cashmoney >= 80 then
            player.cashmoney = player.cashmoney - 80
            player.hp = player.hp + 10
          end
        end
        local button2 = loveframes.Create("button", shopframe) --Damage
        button2:SetText("Steroids (+5 damage) - Cost: 150$"):SetWidth(260):SetPos(20, 70)
        button2.OnClick = function()
          if player.cashmoney >= 150 then
            player.cashmoney = player.cashmoney - 150
            player.damage = player.damage + 5
          end
        end
        local button3 = loveframes.Create("button", shopframe) --Energy
        button3:SetText("Energydrink (+20 energy) - Cost: 50$"):SetWidth(260):SetPos(20, 100)
        button3.OnClick = function()
          if player.cashmoney >= 50 then
            player.cashmoney = player.cashmoney - 50
            player.energy = player.energy + 20
          end
        end
        shopframe.OnClose = function(object)
          love.mouse.setVisible(false)
          ShopToggle = false
        end
      end
    end
  elseif stage == "outside_night_1" then --IF outside, move enemys..
    troll:update(dt)
    coins:update(dt)
    waves:update(dt)
  end
  loveframes.update(dt)
end
function Game:draw()
  if stage == "start" then --Shop
    g.draw(bg)
    kyl:draw()
    g.draw(desk, 150, 461)
    screenanim:draw(225, 404)
    g.setFont(mainFont)
    g.printf("Home (Shop)",550, 20, 200,"center")
    if ShowShopText == true then
      g.printf("Press e to shop",230, 370, 200, "center", 0, 0.5, 0.5)
    end
    g.setFont(defaultfont)
    --Printa stats..
    g.draw(statsbox, -50, 20)
    g.printf("HP: "..math.ceil(player.hp),50, 30, 200, "left")
    g.printf("Energy: "..player.energy,50, 60, 500, "left")
    g.printf("Damage: "..player.damage,50, 45, 500, "left")
    g.printf("Cashmoney: "..player.cashmoney.." $",50, 85, 500, "left")
    --crosshair
    local mousex, mousey = love.mouse.getPosition()
    g.draw(crosshair, mousex, mousey, 0, 1, 1, 12, 12)
  elseif stage == "outside_night_1" then --Outside 1
    g.draw(outsidebg)
    troll:draw()
    coins:draw()
    g.setFont(mainFont)
    g.printf("Outside",550, 20, 200,"center")
    g.setFont(defaultfont)
    waves:draw()
    g.draw(statsbox, -50, 20)
    g.printf("HP: "..math.ceil(player.hp),50, 30, 200, "left")
    g.printf("Energy: "..player.energy,50, 60, 500, "left")
    g.printf("Damage: "..player.damage,50, 45, 500, "left")
    g.printf("Cashmoney: "..player.cashmoney.." $",50, 85, 500, "left")
    --crosshair
    local mousex, mousey = love.mouse.getPosition()
    g.draw(crosshair, mousex, mousey, 0, 1, 1, 12, 12)
  elseif stage == "dead" then --Deadscreen..
    love.mouse.setVisible(true)
    g.setFont(deadFont)
    g.printf("You died, but fear not! Because you can always restart the game, and be the best keyboard warrior in the whole world! And on that bombshell, thanks for playing!",100, 100, 900,"center")
    g.setFont(defaultfont)
  elseif stage == "win" then --Winning!
    love.mouse.setVisible(true)
    g.setFont(mainFont)
    g.printf("GZ You are the number one keyboard warrior in the whole world",10, 200, 1270,"center")
    g.printf("And on that bombshell thanks for playing",10, 250, 1270, "center")
    g.setFont(defaultfont)
  end
  player:draw()
  Projectile:draw()
  loveframes.draw()
end
function love.mousepressed(x, y, button)
  loveframes.mousepressed(x, y, button)
end
function love.mousereleased(x, y, button)
  loveframes.mousereleased(x, y, button)
end
function love.keypressed(key, unicode)
  loveframes.keypressed(key, unicode)
end
function love.keyreleased(key)
  loveframes.keyreleased(key)
end
function love.textinput(text)
  loveframes.textinput(text)
end
