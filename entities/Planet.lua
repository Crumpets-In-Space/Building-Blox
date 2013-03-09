Planet = {}

function Planet:new()
  local object = {
  }

  setmetatable(object, { __index = Planet })
  return object
end

function Planet:update()

end
