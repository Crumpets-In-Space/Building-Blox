Moon = {}

function Moon:new(xPos, yPos, radius, i)
  newX = xPos + radius
  newY = yPos + radius

  if math.random(2) == 1 then 
    newX = newX + math.random(30,50) * i * -1 
  else
    newX = newX + math.random(30,50) * i
  end

  if math.random(2) == 1 then 
    newY = newY + math.random(30,50) * i * -1 
  else
    newY = newY + math.random(30,50) * i
  end

  local object = {
    image = love.graphics.newImage("asteroid.png"),
    x = newX,
    y = newY,
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
