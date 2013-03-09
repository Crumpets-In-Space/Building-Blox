function love.load()
  --camera
  require "camera"
  excessAtEdgeOfScreen = 10
  zoom = 1
  
  -- graphics love
  g = love.graphics
   text       = ""
   
  -- Game world
  world = love.physics.newWorld( 0, 0, true )
    --These callback function names can be almost any you want:
    world:setCallbacks(beginContact, endContact)
  gameover = false
  
  -- instantiate our player and set initial values
  require "Player"
  p = Player:new()
  sRelp = ""
  
  require "entities/SolarSystem"
  s = SolarSystem:new()  

  -- SOUNDS
  explosion = love.audio.newSource("Sounds/explosion.wav","static")
  
  
  -- IMAGES
  bkgrnd = g.newImage("background.jpg")

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
  g.setFont( g.newFont(20) )
  g.print("The Sun is " ..sRelp, g.getWidth() - 400, 400)

  --g.draw(bkgrnd,0,0)
  
  for i=1,p.health,1 do
    -- Heart
    love.graphics.setColor(255, 0, 0) -- red
    g.arc( "fill", (g.getWidth() - (70 * p.health) - 200) + 62.5 + 70*i, 50, 12.5, math.pi, 2*math.pi)
    g.arc( "fill",  (g.getWidth() - (70 * p.health) - 200) + 87.5 + 70*i, 50, 12.5, math.pi, 2*math.pi)
    g.polygon('fill',  (g.getWidth() - (70 * p.health) - 200) + 50 + 70*i, 50,  (g.getWidth() - (70 * p.health) - 200) + 100 + 70*i, 50,  (g.getWidth() - (70 * p.health) - 200) + 75 + 70*i, 100)
  end
  
  if gameover then
    g.setColor(255, 255, 255) -- white
    g.print("GAME OVER", g.getWidth()/2 - 35, g.getHeight()/2 + 50)
  end
  
  camera:setScale(zoom,zoom)
  
  g.setColor(255, 255, 255) -- white
  g.print("FPS: " .. love.timer.getFPS(), 2, 2)
  
  g.print("Score: " .. p.value,g.getWidth() - 400, 150)
  
  camera:set()

  -- Draw player
  p:draw()
  
  -- Draw entities
  s:draw()
 
  g.print(text, 10, 10)
  camera:unset()
end

function beginContact(a, b, coll)
    x,y = coll:getNormal()
    --text = text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y
    
    -- Two of the same type colliding
    if a:getUserData() == b:getUserData() then
      -- Mark asteroid to be removed
      if a:getUserData() == 'Asteroid' then
        if a:getShape():getRadius() > b:getShape():getRadius() then
          b:setUserData("DESTROYME")
        else
          a:setUserData("DESTROYME")
        end
        -- Play audio sound for collisions on the screen
        if a:getBody():getX() < camera.x + g.getWidth() and a:getBody():getX() > camera.x then
          if a:getBody():getY() < camera.y + g.getHeight() and a:getBody():getY() > camera.y then
            love.audio.play(explosion)
          end
        end
      end
    end
    
    -- The player colliding with something
    if a:getUserData() == "Player" then
      sizeOfPlayer = a:getShape():getRadius()
      object = b:getShape():getRadius()
      
      if object > sizeOfPlayer then
        p.health = p.health - 1
      end
    end
end


function endContact(a, b, coll)
    --text = text.."\n"..a:getUserData().." uncolliding with "..b:getUserData()
end