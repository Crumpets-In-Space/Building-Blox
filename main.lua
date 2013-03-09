function love.load()
  -- graphics love
  g = love.graphics
  
  -- instantiate our player and set initial values
  require "Player"
  p = Player:new()
end

function love.update(dt)
  if love.keyboard.isDown("right") then
    p:move('right')
  elseif love.keyboard.isDown("left") then
    p:move('left')
  end
  
  if love.keyboard.isDown("down") then
    p:move('down')
  elseif love.keyboard.isDown("up") then
    p:move('up')
  end
  
  -- update the player's position
  p:update(dt)
 
end

function love.draw()
   g.draw(p.image, p.x, p.y)
end
