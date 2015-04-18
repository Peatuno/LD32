-------------------------------------------------
-- Sten the "Keyboard Warrior" #LD32 by Peatuno / JoQ
-- Website: http://jksoft.se
-- Licence: ZLIB/libpng
-- Copyright (c) 2015 JKsoft
-------------------------------------------------

require 'game'
require 'settings'


function love.load()
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {resizable=false, vsync=false, minwidth=800, minheight=600})

  mainFont = love.graphics.newFont("Assets/8-BITWONDER.ttf", 24)
  defaultfont = love.graphics.newFont(14)
  game = Game:new()
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:draw()

  --love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end
