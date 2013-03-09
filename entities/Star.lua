Star = {}

function Star:new(s)
  
  if not size then
    s = math.random(200, 1000)
  end

  local object = {
    size = s 
  }

  setmetatable(object, { __index = Star })
  return object
end

function Star:update()

end
