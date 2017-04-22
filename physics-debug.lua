-- debug.lua
-- Laurent Zubiaur 2017 - Public Domain

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

  local r,g,b = 0,0,255 -- dynamic
  if fixture:isSensor() then
    r,g,b = 255,255,0
  elseif body:getType() == 'static' then
    r,g,b = 0,255,0
  elseif body:getType() == 'kinematic' then
    r,g,b = 255,0,0
  end

  if shape:getType() == 'circle' then
    drawCircle(shape, r,g,b)
  elseif shape:getType() == 'polygon' then
    drawPolygon(shape, r,g,b)
  else -- chain or edge
    love.graphics.setColor(r,g,b,255)
    love.graphics.line(shape:getPoints())
  end
  love.graphics.pop()
  return true
end

local function drawDebugPhysics(world, x,y, w,h)
  local r,g,b,a = love.graphics.getColor()
  local ps = love.graphics.getPointSize()
  local ls = love.graphics.getLineWidth()

  love.graphics.setPointSize(5)
  love.graphics.setLineWidth(2)

  world:queryBoundingBox(x,y, x+w,y+h, drawFixture)

  love.graphics.setColor(255,0,255,255)
  local joints = world:getJointList()
  for k,v in ipairs(joints) do
    local x1,y1,x2,y2 = v:getAnchors()
    if x2 then
      love.graphics.line(x1,y1, x2,y2)
    else
      love.graphics.point(x1,y1)
    end
  end

  -- TODO draw contact points?

  love.graphics.setPointSize(ps)
  love.graphics.setLineWidth(ls)
  love.graphics.setColor(r,g,b,a)
end

return drawDebugPhysics
