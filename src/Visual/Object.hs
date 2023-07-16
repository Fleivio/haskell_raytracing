module Visual.Object (Shape (..), Object (..)) where

import Math.Vector
import Visual.Material

data Shape
  = Sphere Float
  | None
  deriving (Show, Eq)

data Object = Object
  { objShape :: Shape,
    objCenter :: Vec3,
    objMaterial :: Material
  }
  deriving (Show, Eq)
