module Casting.Scene (Scene(..), scene) where

import Visual.Color
import Visual.Light
import Math.Vector
import Visual.Object
import Visual.Material

backgroundColor :: RGB
backgroundColor = RGB 0.2 0.2 0.2

ambientLight :: RGB
ambientLight = backgroundColor

lgtSourc :: [Light]
lgtSourc = [
            Light (Vec3 80 0 0) blue,
            Light (Vec3 80 0 0) white,
            Light (Vec3 (-80) (-80) 0) green
      ]

ob :: [Object]
ob = [Object (Sphere 20 (Vec3 (-30) 30 0)) plastic,
      Object (Sphere 5 (Vec3 (-50) 30 0)) rubber,
      Object (Sphere 20 (Vec3 0 (10) 40)) wood,
      Object (Sphere 5 (Vec3 (20) (-30) 0)) metal,
      Object (Sphere 5 (Vec3 (30) (-30) 0)) rubber,
      Object (Sphere 30 (Vec3 30 30 20)) mirror,
      Object (Plane (Vec3 0 (50) 0) (Vec3 0 (-1) 0)) mirror]

data Scene = Scene {lgtSources :: [Light], objs :: [Object], backLgt :: RGB, ambLgt :: RGB}

scene :: Scene
scene = Scene lgtSourc ob backgroundColor ambientLight

