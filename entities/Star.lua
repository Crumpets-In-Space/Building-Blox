Star = {}

function Star:new(s)
  
  if not s then
    s = math.random(50, 100)
  end

  local object = {
    image = love.graphics.newImage("asteroid.png"),
    x = 250,
    y = 150,
    size = s 
  }
  
  -- Physics
  object.body = love.physics.newBody(world, object.x,object.y, "dynamic")
  object.shape = love.physics.newCircleShape(s)
  object.fixture = love.physics.newFixture(object.body, object.shape):setUserData("Asteroid")-- connect body to shape
  
  setmetatable(object, { __index = Star })
  return object
end

function Star:update()

end

function Player:draw()
  g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
end
