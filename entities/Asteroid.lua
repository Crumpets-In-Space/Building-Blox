Asteroid = {}

function Asteroid:new()
  local object = {
    size = math.random(5)
    image = love.graphics.newImage("asteroid.png"),
    x = math.random(1200),
    y = math.random(800)
  }

  -- Physics
  object.body = love.physics.newBody(world, object.x,object.y, "dynamic")
  object.shape = love.physics.newCircleShape(object.size)
  object.fixture = love.physics.newFixture(object.body, object.shape):setUserData("Asteroid")-- connect body to shape
  
  setmetatable(object, { __index = Asteroid })
  return object
end

-- Update function
function Asteroid:update(dt)  
  
end

function Asteroid:draw()
  g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
  g.draw(self.image, self.body:getX(), self.body:getY(), self.body:getAngle(), self.size/30, self.size/30, self.image:getWidth()/2, self.image:getHeight()/2)
end
