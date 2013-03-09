SolarSystem = {}

function SolarSystem:new()
  local object = {

  }

  setmetatable(object, { __index = SolarSystem })
  return object
end

function SolarSystem:update()

end
