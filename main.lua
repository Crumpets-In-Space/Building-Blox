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
  
  -- instantiate our player and set initial values
  require "Player"
  p = Player:new()
  
  require "entities/SolarSystem"
  s = SolarSystem:new(3)  

  -- SOUNDS
  explosion = love.audio.newSource("Sounds/explosion.wav","static")

end

function love.update(dt)
  --update World
  world:update(dt)
  
  -- update Player
  p:update(dt)
  
  -- update Solar System
  s:update(dt)
  
  if love.keyboard.isDown("z") then
    zoom = zoom + 0.1
  end
  if love.keyboard.isDown("x") then
    zoom = zoom - 0.1
  end
end

function love.draw()
  g.polygon('fill', 100, 100, 200, 100, 150, 200)
  camera:setScale(zoom,zoom)
  g.print("FPS: " .. love.timer.getFPS(), 2, 2)
  camera:set()

  --g.print("Score: " .. p)

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
        print("loose health")
      end
    end
end


function endContact(a, b, coll)
    --text = text.."\n"..a:getUserData().." uncolliding with "..b:getUserData()
end