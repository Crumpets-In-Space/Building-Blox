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

  require 'entities/Moon'
  object.moons = {}
  for i=1,(math.random(1,3)),1 do
    object.moons[i] = Moon:new(object, i)
  end
  
  setmetatable(object, { __index = Planet })
  return object
end

function Planet:update(dt)
  planet = self.body
  for i,v in ipairs(self.moons) do
    moon = v.body
    moonVec = vector(moon:getX(), moon:getY())
    planetVec = vector(planet:getX(), planet:getY())
    distance = planetVec - moonVec
    force = 40 / distance:len2()
    normforce = force*distance
    print ("Norm: "..normforce.x..","..normforce.y)
    moon:applyLinearImpulse(normforce.x, normforce.y, moon:getX(), moon:getY())
  end
end

function Planet:draw()
  g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)

  excessAtEdgeOfScreen = 10
  
  for i,v in ipairs(self.moons) do
    if v.body:getX() < camera.x + g.getWidth() + excessAtEdgeOfScreen and v.body:getX() > camera.x - excessAtEdgeOfScreen then
      if v.body:getY() < camera.y + g.getHeight() + excessAtEdgeOfScreen and v.body:getY() > camera.y - excessAtEdgeOfScreen then
        v:draw()
      end
    end
  end
end
