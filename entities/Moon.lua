Moon = {}

function Moon:new(planet, i)
  newX = planet.x + planet.radius
  newY = planet.y

  newX = newX + math.random(30,50) * i  

  local object = {
    image = love.graphics.newImage("imgs/asteroid.png"),
    x = newX,
    y = newY,
    value = math.random(5, 9)
  }

  object.planet = planet
  -- Physics
  object.body = love.physics.newBody(world, object.x,object.y, "dynamic")
  object.shape = love.physics.newCircleShape(object.value)
  object.fixture = love.physics.newFixture(object.body, object.shape):setUserData("Moon")-- connect body to shape
  object.body:applyForce(500, 10000)
  setmetatable(object, { __index = Moon })
  return object
end

function Moon:update()
end

function Moon:draw()
  g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
end
