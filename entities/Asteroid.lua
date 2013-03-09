Asteroid = {}

function Asteroid:new(size, x, y)
  local object = {}
  
  object.image = love.graphics.newImage("asteroid.png")
  
  if size then object.size = size else object.size = math.random(5,10) end  
  if size then object.x = x else object.x = math.random(-5000,5000) end  
  if size then object.y = y else object.y = math.random(-5000,5000) end  
  
  -- Physics
  object.body = love.physics.newBody(world, object.x, object.y, "dynamic")
  object.shape = love.physics.newCircleShape(object.size)
  object.fixture = love.physics.newFixture(object.body, object.shape)-- connect body to shape
  object.fixture:setUserData("Asteroid")

  setmetatable(object, { __index = Asteroid })
  return object
end

-- Update function
function Asteroid:update(dt)  
end

function Asteroid:isDestroyed()
  if self.fixture:getUserData() == "DESTROYME" then
    return true
  else
    return false
  end
end

function Asteroid:draw()
  g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
  g.draw(self.image, self.body:getX(), self.body:getY(), self.body:getAngle(), self.size/30, self.size/30, self.image:getWidth()/2, self.image:getHeight()/2)
end