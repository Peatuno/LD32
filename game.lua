HC       = require 'libs/hardoncollider'
class    = require 'libs/middleclass'
Stateful = require 'libs/stateful'
require 'settings'
require 'player'
require 'entities/kyl'

local k = love.keyboard
local g = love.graphics

Game = class('Game')

function Game:initialize()
  bg = g.newImage("Assets/bg.png")
  desk = g.newImage("Assets/desk.png")
  screen = g.newImage("Assets/screen.png")
  screenanim = newAnimation(screen, 128, 128, 0.5, 0)

  crosshair = g.newImage("Assets/crosshair.png")

  player = Player:new(200, BORDER_Y)
  kyl = Kyl:new(950, 333)

  love.mouse.setVisible(false)

  projectile = Projectile:new()

  gravity = 400
end


function Game:update(dt)
  player:update(dt, gravity)

  screenanim:update(dt)
  projectile:update(dt)

end

function Game:draw()
  g.draw(bg)
  kyl:draw()
  g.draw(desk, 150, 461)
  screenanim:draw(225, 404)

  player:draw()

  Projectile:draw()

  local mousex, mousey = love.mouse.getPosition()
  g.draw(crosshair, mousex, mousey, 0, 1, 1, 12, 12)

end
