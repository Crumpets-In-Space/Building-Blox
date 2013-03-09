Star = {}

function Star:new()
  local object = {
    size = math.random(200)
  }

  setmetatable(object, { __index = Star })
  return object
end

function Star:update()

end
