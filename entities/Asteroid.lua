Asteroid = {}

function Asteroid:new()
  local object = {
    image = love.graphics.newImage("hamster.png"),
    x = 150,
    y = 150,
    xSpeed = 0,
    ySpeed = 0
  }

  setmetatable(object, { __index = Asteroid })
  return object
end

-- Update function
function Asteroid:update(dt)  
  -- update the player's position
  self.x = self.x + (self.xSpeed * dt)
  self.y = self.y + (self.ySpeed * dt)
end

function Asteroid:draw()
  g.draw(self.image, self.x, self.y)
end