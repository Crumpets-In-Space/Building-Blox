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
    health = 10
  }

  -- Physics
  object.body = love.physics.newBody(world, object.x,object.y, "dynamic")
  object.shape = love.physics.newCircleShape(25)
  object.fixture = love.physics.newFixture(object.body, object.shape):setUserData("Player")-- connect body to shape
  
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
  
  if love.keyboard.isDown("right") and x < 500 then
    self.body:applyForce(500, 0)
    love.audio.play(rocket)
  elseif love.keyboard.isDown("left") and x > -500 then
    self.body:applyForce(-500, 0)
    love.audio.play(rocket)
  end
  
  if love.keyboard.isDown("down") and y < 500 then
    self.body:applyForce(0, 500)
    love.audio.play(rocket)
  elseif love.keyboard.isDown("up") and y > -500 then
    self.body:applyForce(0, -500)
    love.audio.play(rocket)
  end
  
  -- Get current velocity
  camera:move(x*dt,y*dt)
  
  -- Determine if player is dead
  if self.health <= 0 then
    gameover = true
  end
end

function Player:draw()
  g.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
  g.draw(self.image, self.body:getX(), self.body:getY(), self.body:getAngle(),  1/13, 1/13, self.image:getWidth()/2, self.image:getHeight()/2)
end

function love.keyreleased(key)
  if love.keyboard.isDown("right") and love.keyboard.isDown("right") and love.keyboard.isDown("right") and love.keyboard.isDown("right") then
    return
  else
    love.audio.stop(rocket)
  end
end