Universe = {}

function Universe:new()
  local object = {
    solarSystems = {}
    solarSystems[1] = SolarSystem:new(1)
  }

  setmetatable(object, { __index = Universe })
  return object
end

function Universe:update()

end
