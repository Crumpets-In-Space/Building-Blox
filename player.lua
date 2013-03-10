Player = {}
 
-- Constructor
function Player:new()
  -- define our parameters here 
  local object = {
    value = 10,
    image = g.newImage("imgs/player.png"),
    x = g.getWidth()/2,
    y = g.getHeight()/2,
    width = 0,
    height = 0,
    health = 5
  }

  -- Physics
  object.body = love.physics.newBody(world, object.x,object.y, "dynamic")
  object.shape = love.physics.newCircleShape(25)
  object.fixture = love.physics.newFixture(object.body, object.shape):setUserData("Player")-- connect body to shape
  
  id = love.image.newImageData(32, 32)
    --1b. fill that blank image data
    for x = 0, 31 do
      for y = 0, 31 do
        local gradient = 1 - ((x-15)^2+(y-15)^2)/40
        id:setPixel(x, y, math.random(200,255), math.random(0,150), math.random(0,100), 255*(gradient<0 and 0 or gradient))
      end
    end
    --2. create an image from that image data
    i = love.graphics.newImage(id)
  
  object.p = love.graphics.newParticleSystem( i, 512 )
  object.p:setEmissionRate          (500)
  object.p:setLifetime              (4)
  object.p:setParticleLife          (1)
  object.p:setPosition              (0, 0)
  object.p:setDirection             (0)
  object.p:setSpread                (1)
  object.p:setSpeed                 (100, 0)
  object.p:setGravity               (30)
  object.p:setRadialAcceleration    (5)
  object.p:setTangentialAcceleration(0)
  object.p:setSizeVariation         (0.5)
  object.p:setRotation              (0)
  object.p:setSpin                  (0)
  object.p:setSpinVariation         (0)
  object.p:stop()
  
  -- SOUNDS
  rocket = love.audio.newSource("Sounds/rocket.wav","static")
  rocket:setPitch(0.5) -- one octave lower
  rocket:setVolume(0.7)
  
  setmetatable(object, { __index = Player })
  return object
end

-- Update function
function Player:update(dt)  
  x, y = self.body:getLinearVelocity( )
  
  if self.shape:getRadius() < 50 then
    speed = 100
  elseif self.shape:getRadius() < 100 then
    speed = 200
  elseif self.shape:getRadius() < 150 then
    speed = 300
  end
  
  if love.keyboard.isDown("right") and x < 300 then
    self.body:applyForce(300, 0)
    love.audio.play(rocket)
    self.p:setDirection(math.pi)
    self.p:setSpeed(speed, 0)
    self.p:start()
  elseif love.keyboard.isDown("left") and x > -300 then
    self.body:applyForce(-300, 0)
    love.audio.play(rocket)
    self.p:setDirection(2*math.pi)
    self.p:setSpeed(speed, 0)
    self.p:start()
  end
  
  if love.keyboard.isDown("down") and y < 300 then
    self.body:applyForce(0, 300)
    love.audio.play(rocket)
    self.p:setDirection(3*math.pi/2)
    self.p:setSpeed(0, speed)
    self.p:start()
  elseif love.keyboard.isDown("up") and y > -300 then
    self.body:applyForce(0, -300)
    love.audio.play(rocket)
    self.p:setDirection(math.pi/2)
    self.p:setSpeed(0, speed)
    self.p:start()
  end
  
  if love.keyboard.isDown("left") and love.keyboard.isDown("up") then
    self.p:setDirection(math.pi/4)
    self.p:setSpeed(speed, speed)
    self.p:start()
  elseif love.keyboard.isDown("left") and love.keyboard.isDown("down") then
    self.p:setDirection(7*math.pi/4)
    self.p:setSpeed(speed, speed)
    self.p:start()
  elseif love.keyboard.isDown("right") and love.keyboard.isDown("up") then
    self.p:setDirection(3*math.pi/4)
    self.p:setSpeed(speed, speed)
    self.p:start()
  elseif love.keyboard.isDown("right") and love.keyboard.isDown("down") then
    self.p:setDirection(5*math.pi/4)
    self.p:setSpeed(speed, speed)
    self.p:start()
  end
  
  -- Get current velocity
  camera:move(x*dt,y*dt)
  
  -- Determine if player is dead
  if self.health <= 0 then
    gameover = true
  end
  
  --4b. on each frame, the particle system needs to update its particles's positions after dt miliseconds
  self.p:update(dt)
end

function Player:draw()
  love.graphics.draw(self.p, self.body:getX(), self.body:getY())
  --g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
  scaleFactor = (self.shape:getRadius() * 2)/(self.image:getWidth())
  g.draw(self.image, self.body:getX(), self.body:getY(), self.body:getAngle(),  scaleFactor, scaleFactor, self.image:getWidth()/2, self.image:getHeight()/2)
end

function love.keyreleased(key)
  if love.keyboard.isDown("right") and love.keyboard.isDown("right") and love.keyboard.isDown("right") and love.keyboard.isDown("right") then
    return
  else
    love.audio.stop(rocket)
  end
end