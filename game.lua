HC       = require 'libs/hardoncollider'
class    = require 'libs/middleclass'
Stateful = require 'libs/stateful'
require 'settings'
require 'player'
require 'entities/kyl'

local k = love.keyboard

Game = class('Game')

function Game:initialize()
  bg = love.graphics.newImage("Assets/bg.png")
  crosshair = love.graphics.newImage("Assets/crosshair.png")

  player = Player:new(100, BORDER_Y)
  kyl = Kyl:new(950, 333)

  love.mouse.setVisible(false)

  gravity = 400
end


function Game:update(dt)
  player:update(dt, gravity)


end

function Game:draw()
  love.graphics.draw(bg)
  kyl:draw()

  player:draw()

  local mousex, mousey = love.mouse.getPosition()
  love.graphics.draw(crosshair, mousex, mousey, 0, 1, 1, 12, 12)

end
