module Casting.Scene (Scene, scene) where

import Math.Vector
import Visual.Color
import Visual.Light
import Visual.Object

-- backgroundColor = (0.5, 0.5, 0.5) :: Color

-- ambientLight = (0.1, 0.1, 0.1) :: Color

type Scene = ([Light], [InstanceObject])

scene :: Scene
scene =
  ( [light (vector 100 100 0) (1, 1, 1) 50],
    [(Sphere 1, vector 0 0 0, (red, 0, 0, 0, 0, 0.5)), (Sphere 10, vector 0 0 0, (blue, 0, 0, 0, 0, 0.5))]
  )