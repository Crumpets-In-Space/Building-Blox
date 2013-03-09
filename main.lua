function love.load()
  -- graphics love
  g = love.graphics
  
  -- instantiate our player and set initial values
  require "Player"
  p = Player:new()
end

function love.update(dt)
  -- update the player's position
  p:update(dt)
  
end

function love.draw()
	 g.print("FPS: " .. love.timer.getFPS(), 2, 2)
   p:draw()
end