Universe = {}

function Universe:new()
  local object = {
    solarSystems = {}
  }

  setmetatable(object, { __index = Universe })
  return object
end

function Universe:update()

end
