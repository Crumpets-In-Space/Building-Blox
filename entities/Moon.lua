Moon = {}

function Moon:new(planet, i)
  newX = planet.x + planet.radius
  newY = planet.y

  newX = newX + (100 * i) 

  local images = {}
  images[0] = "imgs/Moons/moon1.png"
  
  local object = {
    image = love.graphics.newImage(images[0]),
    x = newX,
    y = newY,
    radius = math.random(15, 20)
  }

  object.planet = planet
  -- Physics
  object.body = love.physics.newBody(world, object.x,object.y, "dynamic")
  object.shape = love.physics.newCircleShape(object.radius)
  object.fixture = love.physics.newFixture(object.body, object.shape)
  object.fixture:setUserData("Moon")-- connect body to shape
  object.body:setMass(50*object.radius)
  pX, pY = planet.body:getLinearVelocity()
  object.body:applyLinearImpulse(0, 10000)
  setmetatable(object, { __index = Moon })
  return object
end

function Moon:update()
end

function Moon:draw()
  --g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
  scaleFactor = (self.shape:getRadius() * 2)/(self.image:getWidth())
  g.draw(self.image, self.body:getX(), self.body:getY(), self.body:getAngle(), scaleFactor, scaleFactor, self.image:getWidth()/2, self.image:getHeight()/2)
end
