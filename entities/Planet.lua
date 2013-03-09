Planet = {}

function Planet:new()
  local object = {
    size = math.random(10, 40)
  }

  setmetatable(object, { __index = Planet })
  return object
end

function Planet:update()

end
