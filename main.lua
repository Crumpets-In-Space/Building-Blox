function love.load()
  player = {
    image = love.graphics.newImage("hamster.png"),
    x = 50,
    y = 50,
    speed = 100
  }
end

function love.update(dt)
   if love.keyboard.isDown("right") then
      player.x = player.x + (player.speed * dt)
   elseif love.keyboard.isDown("left") then
      player.x = player.x - (player.speed * dt)
   end
   if love.keyboard.isDown("down") then
      player.y = player.y + (player.speed * dt)
   elseif love.keyboard.isDown("up") then
      player.y = player.y - (player.speed * dt)
   end
end

function love.draw()
   love.graphics.draw(player.image, player.x, player.y)
end