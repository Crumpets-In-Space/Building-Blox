Planet = {}

function Planet:new()
  local object = {
    image = love.graphics.newImage("asteroid.png"),
    x = 350,
    y = 150,
    radius = math.random(10, 40)
  }

  -- Physics
  object.body = love.physics.newBody(world, object.x,object.y, "dynamic")
  object.shape = love.physics.newCircleShape(object.radius)
  object.fixture = love.physics.newFixture(object.body, object.shape):setUserData("Planet")-- connect body to shape

  object.moons = {}
  for i=1,(math.random(1,3)),1 do
    object.moons[i] = Moon:new(object.x, object.y, object.radius)
  end
  
  setmetatable(object, { __index = Planet })
  return object
end

function Planet:update()

end

function Planet:draw()
  g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
end
