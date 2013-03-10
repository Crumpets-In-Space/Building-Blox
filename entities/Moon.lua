Moon = {}

function Moon:new(planet, i)
  newX = planet.x + planet.radius
  newY = planet.y

  newX = newX + (100 * i) 

  local object = {
    image = love.graphics.newImage("asteroid.png"),
    x = newX,
    y = newY,
    radius = math.random(15, 20)
  }

  object.planet = planet
  -- Physics
  object.body = love.physics.newBody(world, object.x,object.y, "dynamic")
  object.shape = love.physics.newCircleShape(object.radius)
  object.fixture = love.physics.newFixture(object.body, object.shape):setUserData("Moon")-- connect body to shape
  object.body:setMass(10*object.radius)
  pX, pY = planet.body:getLinearVelocity()
  object.body:applyLinearImpulse(0, 100*object.radius)
  setmetatable(object, { __index = Moon })
  return object
end

function Moon:update()
end

function Moon:draw()
  g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
end
