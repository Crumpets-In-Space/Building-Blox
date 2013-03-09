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

  require "entities/Planet"
  for i=1,10,1 do
    --plan[i] = Planet:new()
  end

  require "entities/Asteroid"
  for i=1,(math.random(10)),1 do
    ast[i] = Asteroid:new()
  end

  local object = {
    --sun = s,
    --planets = plan,
    asteroids = ast
  }

  setmetatable(object, { __index = SolarSystem })
  return object
end

function SolarSystem:update()
  for i,v in ipairs(self.asteroids) do
    if v.body == nil then
      
    end
  end
end

function SolarSystem:draw()
  for i,v in ipairs(self.asteroids) do
    v:draw()
  end
end