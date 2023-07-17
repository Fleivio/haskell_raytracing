module Visual.Light (Light (..), sphereOfLights) where

import Math.Vector ( Vec3(Vec3), Vector((.+.)) )
import Visual.Color

data Light = Light
  { lgtPosition :: Vec3,
    lgtColor :: RGB
  }
  deriving (Show, Eq)

sphereOfLights :: Vec3 -> Double -> [Light]
sphereOfLights center radius = [
  let x = radius * cos theta * sin phi
      y = radius * sin theta * sin phi
      z = radius * cos phi
  in  Light (center .+. Vec3 x y z) (RGB 0.2 0.2 0.2) |
  theta <- [0, 1 .. (2 * 3.14)],
  phi <- [0, 1 .. 3.14]]