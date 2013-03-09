SolarSystem = {}

function SolarSystem:new()
  s = Star.new()
  plan = {} 
  ast = {}

  for i=1,(sun.size/10),+1 do
    plan[i] = Planet:new()
  end

  for i=i,(math.random(20)),+1 do
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
