-- main.lua

local debug = require 'physics-debug'

local world = nil
local w,h = nil,nil

function love.load()
  w,h = love.graphics.getDimensions()
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 10 * love.physics.getMeter(), true)

  do
    -- dynamic
    local body = love.physics.newBody(world, 200,10, 'dynamic')
    love.physics.newFixture(body, love.physics.newCircleShape(10))
  end

  do
    -- static
    local body = love.physics.newBody(world, 150,150, 'static')
    love.physics.newFixture(body, love.physics.newPolygonShape(0,0, 200,20, 200,60, 150,70))
  end

  do
    -- sensor
    local body = love.physics.newBody(world, 250,250, 'static')
    local fixture = love.physics.newFixture(body, love.physics.newPolygonShape(0,0, 200,0, 100,60))
    fixture:setSensor(true)
  end

  do
    -- edge
    local body = love.physics.newBody(world, 250, 300, 'static')
    love.physics.newFixture(body, love.physics.newEdgeShape(0,0,300,-10))
  end

  do
    -- chain
    local body = love.physics.newBody(world, 350, 400, 'kinematic')
    love.physics.newFixture(body, love.physics.newChainShape(false, 0,0,200,10,250,-20,350,30))
  end

  do
    local bodyA = love.physics.newBody(world, 40,50, 'dynamic')
    love.physics.newFixture(bodyA, love.physics.newCircleShape(10))
    local bodyB = love.physics.newBody(world, 20,20, 'static')
    love.physics.newFixture(bodyB, love.physics.newRectangleShape(0,0, 20,20))
    love.physics.newDistanceJoint(bodyA,bodyB,bodyA:getX(),bodyA:getY(),bodyB:getX(),bodyB:getY(),true)
  end

  -- TODO test other joint type

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
