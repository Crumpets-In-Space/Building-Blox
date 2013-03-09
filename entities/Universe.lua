Universe = {}

function Universe:new()
  local object = {
  }

  setmetatable(object, { __index = Universe })
  return object
end

function Universe:update()

end
