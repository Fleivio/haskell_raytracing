module Casting.Scene (Scene(..), scene) where

import Visual.Color
import Visual.Light
import Math.Vector
import Visual.Object
import Visual.Material

backgroundColor :: RGB
backgroundColor = RGB 0 0 0

ambientLight :: RGB
ambientLight = RGB 0.01 0.01 0.01

lgtSourc :: [Light]
lgtSourc = [Light (Vec3 0 300 0) white,
            Light (Vec3 100 100 0) white]

ob :: [Object]
ob = [Object (Sphere 10) vZero metal, Object (Sphere 10) (Vec3 30 0 0) wood]

data Scene = Scene {lgtSources :: [Light], objs :: [Object], backLgt :: RGB, ambLgt :: RGB}

scene :: Scene
scene = Scene lgtSourc ob backgroundColor ambientLight

