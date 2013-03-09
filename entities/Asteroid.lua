Asteroid = {}

function Asteroid:new()
  local object = {
  }

  setmetatable(object, { __index = Asteroid })
  return object
end

function Asteroid:update()

end
