Moon = {}

function Moon:new()
  local object = {
    image = love.graphics.newImage("asteroid.png"),
    x = 350,
    y = 150,
    value = math.random(5, 9)
  }

  -- Physics
  object.body = love.physics.newBody(world, object.x,object.y, "dynamic")
  object.shape = love.physics.newCircleShape(object.value)
  object.fixture = love.physics.newFixture(object.body, object.shape):setUserData("Moon")-- connect body to shape
  
  setmetatable(object, { __index = Moon })
  return object
end

function Moon:update()

end

function Moon:draw()
  g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
end