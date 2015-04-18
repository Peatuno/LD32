require '../libs/AnAL'

Troll = class('Troll')

function Troll:initialize(x, y)
  self.x = x
  self.y = y

  self.hp = 50
end
