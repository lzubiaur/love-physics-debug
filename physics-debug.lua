-- debug.lua

local Debug = {}

local function drawCircle(circle,r,g,b)
  local x,y = circle:getPoint()
  love.graphics.setColor(r,g,b,64)
  love.graphics.circle('fill', x,y, circle:getRadius())
  love.graphics.setColor(r,g,b,255)
  love.graphics.circle('line', x,y, circle:getRadius())
end

local function drawPolygon(polygon,r,g,b)
  local points = { polygon:getPoints() }
  love.graphics.setColor(r,g,b,64)
  love.graphics.polygon('fill', points)
  love.graphics.setColor(r,g,b,255)
  love.graphics.polygon('line', points)
end

local function drawFixture(fixture)
  local body = fixture:getBody()
  local shape = fixture:getShape()
  love.graphics.push()
  love.graphics.translate(fixture:getBody():getPosition())
  love.graphics.rotate(body:getAngle())

  local color = { 0, 0, 255 }
  if fixture:isSensor() then
    color = { 255, 255, 0 }
  elseif body:getType() == 'static' then
    color = { 0, 255, 0 }
  elseif body:getType() == 'kinematic' then
    color = { 255, 255, 0 }
  end

  if shape:getType() == 'circle' then
    drawCircle(shape, unpack(color))
  elseif shape:getType() == 'polygon' then
    drawPolygon(shape, unpack(color))
  end
  love.graphics.pop()
  return true
end

function Debug.drawPhysics(world, x,y, w,h)
  local r,g,b,a = love.graphics.getColor()
  world:queryBoundingBox(x,y, x+w,y+h, drawFixture)
  love.graphics.setColor(r,g,b,a)
end

return Debug
