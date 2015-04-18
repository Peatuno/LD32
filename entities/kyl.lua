require '../libs/AnAL'

Kyl = class('Kyl')

function Kyl:initialize(x, y)
  self.x = x
  self.y = y

  --gfx
  self.width = 256
  self.height = 256
  self.idle = love.graphics.newImage("Assets/kyl.png")

end
function Kyl:draw()
  love.graphics.draw(self.idle, self.x, self.y)
end
