Planet = {}

function Planet:new()
  local object = {
    size = math.random(50, 100)
  }

  setmetatable(object, { __index = Planet })
  return object
end

function Planet:update()

end
