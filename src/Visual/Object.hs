module Visual.Object (Shape (..), Object (..)) where

import Visual.Material

import Math.Shape

data Object = Object
  { objShape :: Shape,
    objMaterial :: Material
  }
  deriving (Show, Eq)
