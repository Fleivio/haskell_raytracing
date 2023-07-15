module Visual.Light(Light, light) where

import Visual.Material
import Math.Vector
import Visual.Color

type Light = (Position, Material)

light :: Position -> Color -> Shininess -> Light
light p c s = (p, (c, 0, 0, 0, 0, s))