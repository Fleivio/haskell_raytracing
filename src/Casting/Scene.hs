module Casting.Scene (Scene(..), scene) where

import Visual.Color
import Visual.Light
import Math.Vector
import Visual.Object
import Visual.Material

backgroundColor :: RGB
backgroundColor = RGB 0.1 0.1 0.1

ambientLight :: RGB
ambientLight = RGB 0.2 0.2 0.2

lgtSourc :: [Light]
-- lgtSourc = sphereOfLights (Vec3 1000 0 0) 40
lgtSourc = [
            Light (Vec3 1000 0 0) white
      ]

ob :: [Object]
ob = [Object (Sphere 10) (Vec3 (-30) 0 0) plastic,
      Object (Sphere 2) (Vec3 0 0 (-8)) metal,
      Object (Sphere 10) (Vec3 10 (-20) 0) wood]

data Scene = Scene {lgtSources :: [Light], objs :: [Object], backLgt :: RGB, ambLgt :: RGB}

scene :: Scene
scene = Scene lgtSourc ob backgroundColor ambientLight

