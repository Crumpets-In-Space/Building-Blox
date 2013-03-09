SolarSystem = {}

function SolarSystem:new(sizeOfStar)
  if sizeOfStar then
    s = Star:new(sizeOfStar)
  else
    s = Star:new()
  end
  plan = {} 
  ast = {}

  numOfPlanets = ((sun.size+9)*math.floor(sun.size/100))

  for i=1,numOfPlanets,+1 do
    plan[i] = Planet:new()
  end

  for i=i,(math.random(100)),+1 do
    ast[i] = Astroid:new()
  end

  local object = {
    sun = s
    planets = plan
    astroids = ast
  }

  setmetatable(object, { __index = SolarSystem })
  return object
end

function SolarSystem:update()

end
