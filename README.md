Very simple box2d debug draw

![alt tag](screenshot.png)

Example

``` lua
local drawDebugPhysics = require 'physics-debug'

function love.draw()
  drawDebugPhysics(world, 0,0, 800,600)
end
```

Run the test

```
cd love-physics-debug
love .
```
