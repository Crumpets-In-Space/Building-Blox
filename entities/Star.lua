Star = {}

function Star:new(s)
  
  if not s then
    s = math.random(50, 100)
  end

  local images = {}
  images[0] = "imgs/ColoredStars/bluesun.png"
  images[1] = "imgs/ColoredStars/dkbluesun.png"
  images[2] = "imgs/ColoredStars/green1sun.png"
  images[3] = "imgs/ColoredStars/green2sun.png"
  images[4] = "imgs/ColoredStars/orangesun.png"
  images[5] = "imgs/ColoredStars/pinksun.png"
  images[6] = "imgs/ColoredStars/red1sun.png"
  images[7] = "imgs/ColoredStars/sun.png"
  images[8] = "imgs/ColoredStars/tealsun.png"
  images[9] = "imgs/ColoredStars/whitesun.png"
  images[10] = "imgs/ColoredStars/yellowsun.png"

  local object = {
    image = love.graphics.newImage(images[math.random(10)]),
    x = math.random(-2000,2000),
    y = math.random(-2000,2000),
    size = s 
  }
  
  -- Physics
  object.body = love.physics.newBody(world, object.x,object.y, "dynamic")
  object.shape = love.physics.newCircleShape(object.size)
  object.fixture = love.physics.newFixture(object.body, object.shape):setUserData("Star")-- connect body to shape
  object.body:setMass(10*object.size)

  setmetatable(object, { __index = Star })
  return object
end

function Star:update()

end

function Star:draw()
    if self.body:getX() < camera.x + g.getWidth() + excessAtEdgeOfScreen and self.body:getX() > camera.x - excessAtEdgeOfScreen then
      if self.body:getY() < camera.y + g.getHeight() + excessAtEdgeOfScreen and self.body:getY() > camera.y - excessAtEdgeOfScreen then
        g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
        scaleFactor = (self.shape:getRadius() * 2)/(self.image:getWidth())
        g.draw(self.image, self.body:getX(), self.body:getY(), self.body:getAngle(), scaleFactor, scaleFactor, self.image:getWidth()/2, self.image:getHeight()/2)
      end
    end
end
