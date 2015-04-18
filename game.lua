HC       = require 'libs/hardoncollider'
class    = require 'libs/middleclass'
Stateful = require 'libs/stateful'
require 'settings'
require 'player'
require 'entities/kyl'
require 'entities/troll'

local k = love.keyboard
local g = love.graphics

Game = class('Game')

function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

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

  --Move till egen class sen..
  enemys = {}
  enemys[1] = Troll:new(1000, 433)
  enemys[2] = Troll:new(820, 452)

  love.mouse.setVisible(false)

  projectile = Projectile:new()

  gravity = 400

  stage = "start"
  morestages = true

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

    if k.isDown("e") and ShowShopText == true then
      if ShopToggle == false then
        ShopToggle = true
        ShowShopText = false
        love.mouse.setVisible(true)
        local shopframe = loveframes.Create("frame")
        shopframe:SetName("Shop"):SetPos(500, 200)
        local button1 = loveframes.Create("button", shopframe)
        button1:SetText("Energydrink (+50 energy) - Cost: 100$"):SetWidth(260):Center()
        button1.OnClick = function()
          if player.cashmoney > 100 then
            player.cashmoney = player.cashmoney - 100
            player.energy = player.energy + 50
          end
        end
        shopframe.OnClose = function(object)
          love.mouse.setVisible(false)
          ShopToggle = false
        end
      end

    elseif ShowShopText == false then
      --hide shop-gui

    end


  elseif stage == "outside_night_1" then --IF outside, move enemys..
    for i,v in ipairs(enemys) do
      v.x = v.x - dt * 10
    end
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

  elseif stage == "outside_night_1" then --Outside 1
    g.draw(outsidebg)

    for i,v in ipairs(enemys) do
      g.draw(trollimg, v.x, v.y)
    end

    g.setFont(mainFont)
    g.printf("Outside (Fight)",550, 20, 200,"center")
    g.setFont(defaultfont)

  end

  player:draw()
  Projectile:draw()

  --Printa stats..
  g.draw(statsbox, -50, 20)
  --g.setFont(mainFont)
  g.printf("HP: "..player.hp,50, 40, 200, "left")
  g.printf("Energy: "..player.energy,50, 55, 500, "left")
  g.printf("Cashmoney: "..player.cashmoney.."$",50, 70, 500, "left")
  --g.setFont(defaultfont)
  --crosshair
  local mousex, mousey = love.mouse.getPosition()
  g.draw(crosshair, mousex, mousey, 0, 1, 1, 12, 12)

  loveframes.draw()

  --love.graphics.print("Dist: "..tostring(math.dist(player.x, player.y, 225, 404)), 50, 50)
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
