function love.load()
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
  
  require "entities/Asteroid"
  a = Asteroid:new()
end

function love.update(dt)
  --update World
  world:update(dt)
  
  -- update the player's position
  p:update(dt)
 
  -- update the asteroid's position
  a:update(dt) 
end

function love.draw()
	 g.print("FPS: " .. love.timer.getFPS(), 2, 2)
   
   -- Draw player
   p:draw()
   
   -- Draw asteroid
   a:draw()
   
   love.graphics.print(text, 10, 10)
end

function beginContact(a, b, coll)
    x,y = coll:getNormal()
    text = text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y
end


function endContact(a, b, coll)
    text = text.."\n"..a:getUserData().." uncolliding with "..b:getUserData()
end
