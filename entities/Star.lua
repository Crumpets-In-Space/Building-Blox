Star = {}

function Star:new(s)
  
  if not s then
    s = math.random(50, 100)
  end

  local object = {
    size = s 
  }

  setmetatable(object, { __index = Star })
  return object
end

function Star:update()

end
