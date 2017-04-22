Very simple box2d debug draw

![alt tag](screenshot.png)

## Installation

Copy the `physics-debug.lua` file in your project and include the module in your code.

```
local drawDebugPhysics = require 'physics-debug'
```

### Documentation

```
function drawDebugPhysics(world, x,y, w,h)
```

* world: the physics world object created using `love.physics.newWorld`
* x,y: origin points of the world to draw
* w,h: size of the world part to draw

## Example

``` lua
local drawDebugPhysics = require 'physics-debug'

function love.draw()
  drawDebugPhysics(world, 0,0, 800,600)
end
```

## Run the test

```
git clone https://github.com/lzubiaur/love-physics-debug
cd love-physics-debug
love .
```
