HC       = require 'libs/hardoncollider'
class    = require 'libs/middleclass'
Stateful = require 'libs/stateful'
require 'settings'

local k = love.keyboard

Game = class('Game')

function Game:initialize()
  bg = love.graphics.newImage("Assets/bg.png")

end


function Game:update(dt)
  
end

function Game:draw()
  love.graphics.draw(bg)

end
