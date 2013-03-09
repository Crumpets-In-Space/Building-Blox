Player = {}
 
-- Constructor
function Player:new()
  -- define our parameters here
  local object = {
    image = love.graphics.newImage("hamster.png"),
    x = 50,
    y = 50,
    width = 0,
    height = 0,
    xSpeed = 0,
    ySpeed = 0
  }
  setmetatable(object, { __index = Player })
  return object
end

-- Move Player
function Player:move(direction)
  movementSpeed = 10
  speedLimit = 140
  
  if direction == 'right' and self.xSpeed <= speedLimit then self.xSpeed = self.xSpeed + movementSpeed
  elseif direction == 'left' and self.xSpeed >= -speedLimit then self.xSpeed = self.xSpeed - movementSpeed
  elseif direction == 'up' and self.ySpeed <= speedLimit then self.ySpeed = self.ySpeed + movementSpeed
  elseif direction == 'down' and self.ySpeed >= -speedLimit then self.ySpeed = self.ySpeed - movementSpeed 
  end
end

-- Update function
function Player:update(dt)
  -- update the player's position
  self.x = self.x + (self.xSpeed * dt)
  self.y = self.y + (self.ySpeed * dt)
end