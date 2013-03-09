Star = {}

function Star:new()
  local object = {
  }

  setmetatable(object, { __index = Star })
  return object
end

function Star:update()

end
