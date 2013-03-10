Planet = {}

function Planet:new(sun, i)
  local images = {}
  images[0] = "imgs/Planets/blue2.png"
  images[1] = "imgs/Planets/bluey.png"
  images[2] = "imgs/Planets/earth.png"
  images[3] = "imgs/Planets/mars.png"
  images[4] = "imgs/Planets/red_dwalf.png"
  images[5] = "imgs/Planets/redPlanets.png"
  images[6] = "imgs/Planets/ringy.png"
  images[7] = "imgs/Planets/venusaw.png"
  
  local object = {
    image = love.graphics.newImage(images[math.random(0,7)]),
    x = sun.x + 500 * i,
    y = sun.y,
    radius = math.random(20, 60)
  }

  -- Physics
  object.body = love.physics.newBody(world, object.x,object.y, "dynamic")
  object.shape = love.physics.newCircleShape(object.radius)
  object.fixture = love.physics.newFixture(object.body, object.shape)
  object.fixture:setUserData("Planet")-- connect body to shape
  object.body:setMass(10*object.radius)
  object.body:applyForce(0, 100000*i)

  require 'entities/Moon'
  object.moons = {}
  for i=1,(math.random(1,3)),1 do
    object.moons[i] = Moon:new(object, i)
  end
  
  setmetatable(object, { __index = Planet })
  return object
end

function Planet:update(dt)
  actor = self.body
  for i,v in ipairs(self.moons) do
    actress = v.body
    actressVec = vector(actress:getX(), actress:getY())
    actorVec = vector(actor:getX(), actor:getY())
    distance = actorVec - actressVec
    force = (0.5*actor:getMass()*actress:getMass()) / distance:len2()
    normforce = force*distance
    actress:applyLinearImpulse(normforce.x, normforce.y, actress:getX(), actress:getY())
  end
  
  -- Remove destroyed moons
  for x=#self.moons,1,-1 do
    if self.moons[x].fixture:getUserData() == "DESTROYME" then
      self.moons[x].body:destroy()
      table.remove(self.moons, x)
    end
  end
  
end

function Planet:draw()
  --g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)

  scaleFactor = (self.shape:getRadius() * 2)/(self.image:getWidth())
  g.draw(self.image, self.body:getX(), self.body:getY(), self.body:getAngle(), scaleFactor, scaleFactor, self.image:getWidth()/2, self.image:getHeight()/2)

  excessAtEdgeOfScreen = 10
  
  for i,v in ipairs(self.moons) do
    if v.body:getX() < camera.x + g.getWidth() + excessAtEdgeOfScreen and v.body:getX() > camera.x - excessAtEdgeOfScreen then
      if v.body:getY() < camera.y + g.getHeight() + excessAtEdgeOfScreen and v.body:getY() > camera.y - excessAtEdgeOfScreen then
        v:draw()
      end
    end
  end
end