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

local function drawEdge(edge,r,g,b)
  love.graphics.setColor(r,g,b,255)
  love.graphics.line(edge:getPoints())
end

local function drawChain(chain,r,g,b)
  local points = { chain:getPoints() }
  love.graphics.setColor(r,g,b,255)
  for i=1,#points-2,2 do
    love.graphics.line(points[i],points[i+1],points[i+2],points[i+3])
  end
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
  elseif shape:getType() == 'edge' then
    drawEdge(shape, unpack(color))
  elseif shape:getType() == 'chain' then
    drawChain(shape, unpack(color))
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
