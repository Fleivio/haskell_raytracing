module Visual.Light (Light (..)) where

import Math.Vector
import Visual.Color

data Light = Light
  { lgtPosition :: Vec3,
    lgtColor :: RGB
  }
  deriving (Show, Eq)
