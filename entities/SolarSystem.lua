SolarSystem = {}

function SolarSystem:new(sizeOfStar)
  require "entities/Star"
  if sizeOfStar then
    --s = Star:new(sizeOfStar)
  else
   -- s = Star:new()
  end
  plan = {} 
  ast = {}

  --numOfPlanets = ((s.size+9)*math.floor(s.size/100))
  --v = s.value

  require "entities/Planet"
  for i=1,10,1 do
   --plan[i] = Planet:new()
   --v += plan[i].value
  end

  require "entities/Asteroid"
  for i=1,(math.random(20)),1 do
    ast[i] = Asteroid:new()
--    v = v + ast[i].value
  end

  local object = {
    --sun = s,
    --planets = plan,
 --   value = v,
    asteroids = ast
  }

  setmetatable(object, { __index = SolarSystem })
  return object
end

function SolarSystem:update(dt)
  -- Remove destroyed asteroids
  for i=#self.asteroids,1,-1 do
    if self.asteroids[i]:isDestroyed() then
      if self.asteroids[i].shape:getRadius() > 3 then
        for i=1,(math.random(3)),1 do
          table.insert(self.asteroids, Asteroid:new(self.asteroids[i].shape:getRadius()/3, self.asteroids[i].body:getX() + (5*i),  self.asteroids[i].body:getY() + (5*i)))
        end
      end
      table.remove(self.asteroids, i)
    end
  end
end

function SolarSystem:draw()
  for i,v in ipairs(self.asteroids) do
    v:draw()
  end
end