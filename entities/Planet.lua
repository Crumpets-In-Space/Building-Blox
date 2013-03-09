Planet = {}

function Planet:new()
  local object = {
    image = love.graphics.newImage("asteroid.png"),
    x = 350,
    y = 150
  }

  -- Physics
  object.body = love.physics.newBody(world, object.x,object.y, "dynamic")
  object.shape = love.physics.newCircleShape(50)
  object.fixture = love.physics.newFixture(object.body, object.shape):setUserData("Planet")-- connect body to shape
  
  setmetatable(object, { __index = Planet })
  return object
end

function Planet:update()

end

function Planet:draw()
  g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
end