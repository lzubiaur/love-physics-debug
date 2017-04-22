-- main.lua

local debug = require 'physics-debug'

local world = nil
local w,h = nil,nil

function love.load()
  w,h = love.graphics.getDimensions()
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 10 * love.physics.getMeter(), true)

  local circle = love.physics.newBody(world, 200,10, 'dynamic')
  love.physics.newFixture(circle, love.physics.newCircleShape(10))

  local polygon = love.physics.newBody(world, 150,150, 'static')
  love.physics.newFixture(polygon, love.physics.newPolygonShape(0,0, 200,20, 200,60, 150,70))

end

function love.update(dt)
  world:update(dt)
end

function love.draw()
  debug.drawPhysics(world, 0,0, w,h)
end

function love.keypressed(key, scancode, isrepeat)
  if key == 'escape' then
    love.event.quit()
  end
end
