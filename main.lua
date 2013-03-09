function love.load()
  --camera
  require "camera"
  
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

end

function love.update(dt)
  --update World
  world:update(dt)
  
  -- update Player
  p:update(dt)
  
  -- update Solar System
  s:update(dt)
end

function love.draw()
  camera:set()
  g.print("FPS: " .. love.timer.getFPS(), 2, 2)

  --g.print("Score: " .. p)

  -- Draw player
  p:draw()
  
  -- Draw entities
  s:draw()
 
  love.graphics.print(text, 10, 10)
  camera:unset()
end

function beginContact(a, b, coll)
    x,y = coll:getNormal()
    --text = text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y
    
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
end


function endContact(a, b, coll)
    --text = text.."\n"..a:getUserData().." uncolliding with "..b:getUserData()
end