function love.load()
  --camera
  require "camera"
  excessAtEdgeOfScreen = 10
  zoom = 1
  
  vector = require 'hump.vector'

  -- graphics love
  g = love.graphics
   
  -- Game world
  love.physics.setMeter(30)
  world = love.physics.newWorld( 0, 0, true )
    --These callback function names can be almost any you want:
    world:setCallbacks(beginContact)
  gameover = false
  
  -- instantiate our player and set initial values
  require "Player"
  p = Player:new()
  sRelp = ""
  admin = false
  
  require "entities/SolarSystem"
  s = SolarSystem:new()  
  
  -- SOUNDS
  damage = love.audio.newSource("Sounds/damage.wav","static")
  
  -- IMAGES
  --bkgrnd = g.newImage("imgs/nightsky.jpg")
end

function love.update(dt)
  --update World
  world:update(dt)
  
  -- update Player
  p:update(dt)
  
  -- update Solar System
  s:update(dt)
  
  if love.keyboard.isDown("z") then
    zoom = 0.5 --zoom + 0.1
  end
  if love.keyboard.isDown("x") then
    zoom = 1 --zoom - 0.1
  end
  if love.keyboard.isDown("c") then
    zoom = 0.25 --zoom - 0.1
  end
  if love.keyboard.isDown("a") then
    admin = true
  end
  
  
  
  -- determine sun position relative to player
  sx = s.sun.body:getX( )
  sy = s.sun.body:getY( )
  px = p.body:getX( )
  py = p.body:getY( )
  
  if sy >= py then 
    -- South
    if sx >= px then sRelp = "SE"
    else sRelp = "SW" end
  else
    -- North
    if sx >= px then sRelp = "NE"
    else sRelp = "NW" end
  end
  
end

function love.draw()
  g.setFont( g.newFont(14) )
  g.print("The Sun is " ..sRelp, g.getWidth() - 400, 400)

  --g.draw(bkgrnd,0 - bkgrnd:getWidth()/2,0 - bkgrnd:getHeight()/2)

  if gameover then
    g.setColor(255, 255, 255) -- white
    g.print("GAME OVER", g.getWidth()/2 - 35, g.getHeight()/2 + 50)
  end
  
  camera:setScale(zoom,zoom)
  
  g.setColor(255, 255, 255) -- white
  
  --ADMIN
  if admin then
    g.print("FPS: " .. love.timer.getFPS(), 2, 2)
    g.print("Number of Asteroids: " .. #s.asteroids, 2, 20)
  end
  
  -- Health
  for i=1,p.health,1 do
    -- Heart
    love.graphics.setColor(255, 0, 0) -- red
    g.arc( "fill", (g.getWidth() - (70 * p.health) - 200) + 62.5 + 70*i, 50, 12.5, math.pi, 2*math.pi)
    g.arc( "fill",  (g.getWidth() - (70 * p.health) - 200) + 87.5 + 70*i, 50, 12.5, math.pi, 2*math.pi)
    g.polygon('fill',  (g.getWidth() - (70 * p.health) - 200) + 50 + 70*i, 50,  (g.getWidth() - (70 * p.health) - 200) + 100 + 70*i, 50,  (g.getWidth() - (70 * p.health) - 200) + 75 + 70*i, 100)
  end
  
  -- Score
  g.setColor(255, 255, 255) -- white
  g.print("Score: " .. p.value,g.getWidth() - 400, 150)
  
  camera:set()

  -- Draw player
  p:draw()
  
  -- Draw entities
  s:draw()
 
  camera:unset()
end

function beginContact(a, b, coll)
    x,y = coll:getNormal()
    -- Two of the same type colliding
    if a:getUserData() == b:getUserData() then
      -- Mark asteroid to be removed
      if a:getUserData() == 'Asteroid' then
        if a:getShape():getRadius() > b:getShape():getRadius() then
          b:setUserData("DESTROYME")
        else
          a:setUserData("DESTROYME")
        end
      end
    end
    
    -- The player colliding with something
    if a:getUserData() == "Player" then
      sizeOfPlayer = a:getShape():getRadius()
      object = b:getShape():getRadius()
      
      if object > sizeOfPlayer then
        p.health = p.health - 1
        
        love.audio.stop(damage)
        love.audio.play(damage)
      end
    end
end
