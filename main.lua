function love.load()
  -- graphics love
  g = love.graphics
  
  -- instantiate our player and set initial values
  require "Player"
  p = Player:new()
  
  require "entities/Asteroid"
  a = Asteroid:new()
end

function love.update(dt)
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
end