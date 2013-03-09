Player = {}
 
-- Constructor
function Player:new()
  -- define our parameters here
  local object = {
    value = 10,
    image = g.newImage("hamster.png"),
    x = g.getWidth()/2,
    y = g.getHeight()/2,
    width = 0,
    height = 0,
    health = 10
  }

  -- Physics
  object.body = love.physics.newBody(world, object.x,object.y, "dynamic")
  object.shape = love.physics.newCircleShape(25)
  object.fixture = love.physics.newFixture(object.body, object.shape):setUserData("Player")-- connect body to shape
  
  setmetatable(object, { __index = Player })
  return object
end

-- Move Player
function Player:move(direction)
  if direction == 'right' then 
    self.body:applyForce(1000, 0)    -- and self.xSpeed <= speedLimit then self.xSpeed = self.xSpeed + movementSpeed
  elseif direction == 
    'left' then self.body:applyForce(-1000, 0) -- and self.xSpeed >= -speedLimit then self.xSpeed = self.xSpeed - movementSpeed
  elseif direction == 'up' then self.body:applyForce(0, -1000)  -- and self.ySpeed >= -speedLimit then self.ySpeed = self.ySpeed - movementSpeed
  elseif direction == 'down' then self.body:applyForce(0, 1000)  -- and self.ySpeed <= speedLimit then self.ySpeed = self.ySpeed + movementSpeed 
  end
end

-- Update function
function Player:update(dt)  
  if love.keyboard.isDown("right") then
    self:move('right')
  elseif love.keyboard.isDown("left") then
    self:move('left')
  end
  
  if love.keyboard.isDown("down") then
    self:move('down')
  elseif love.keyboard.isDown("up") then
    self:move('up')
  end
  
  -- Get current velocity
  x, y = self.body:getLinearVelocity( )
  camera:move(x/60,y/60)
  
  -- Determine if player is dead
  if self.health <= 0 then
    gameover = true
  end
end

function Player:draw()
  g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
  g.draw(self.image, self.body:getX(), self.body:getY(), self.body:getAngle(),  1/2, 1/2, self.image:getWidth()/2, self.image:getHeight()/2)
end
