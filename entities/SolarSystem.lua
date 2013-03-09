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

  plan[1] = Planet:new()

  require "entities/Asteroid"
  for i=1,(math.random(1000,2000)),1 do
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
        for j=1,(math.random(3)),1 do
          if j==3 then r = 2
          else r = 1.3
          end
          ass = Asteroid:new(self.asteroids[i].shape:getRadius()/r, self.asteroids[i].body:getX() + (5*j),  self.asteroids[i].body:getY() + (5*j))
          ass.body:applyForce(math.random(-300,300),math.random(-300,300))
          table.insert(self.asteroids, ass)
        end
      end
      table.remove(self.asteroids, i)
    end
  end
end

function SolarSystem:draw()
  excessAtEdgeOfScreen = 10
  
  for i,v in ipairs(self.asteroids) do
    if v.body:getX() < camera.x + 1200 + excessAtEdgeOfScreen and v.body:getX() > camera.x - excessAtEdgeOfScreen then
      if v.body:getY() < camera.y + 800 + excessAtEdgeOfScreen and v.body:getY() > camera.y - excessAtEdgeOfScreen then
        v:draw()
      end
    end
  end

  for i,v in ipairs(self.planets) do
    v:draw()
  end
end
