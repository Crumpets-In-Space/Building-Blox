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
    object.moons[i] = Moon:new(object.x, object.y, object.radius, i)
  end
  
  setmetatable(object, { __index = Planet })
  return object
end

function Planet:update()
  x, y = self.body:getLinearVelocity()
  for i,v in ipairs(self.moons) do
    v.body:setLinearVelocity(x, y) 
  end
end

function Planet:draw()
  g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)

  excessAtEdgeOfScreen = 10
  
  for i,v in ipairs(self.moons) do
    if v.body:getX() < camera.x + 1200 + excessAtEdgeOfScreen and v.body:getX() > camera.x - excessAtEdgeOfScreen then
      if v.body:getY() < camera.y + 800 + excessAtEdgeOfScreen and v.body:getY() > camera.y - excessAtEdgeOfScreen then
        v:draw()
      end
    end
  end
end
