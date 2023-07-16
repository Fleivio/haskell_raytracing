module Casting.Scene (Scene(..), scene) where

import Visual.Color
import Visual.Light
import Math.Vector
import Visual.Object
import Visual.Material

backgroundColor :: RGB
backgroundColor = RGB 0 0 0

ambientLight :: RGB
ambientLight = RGB 0.1 0.1 0.1

lgtSourc :: [Light]
lgtSourc = [Light (Vec3 0 300 0) white]

ob :: [Object]
ob = [Object (Sphere 10) vZero metal]

data Scene = Scene {lgtSources :: [Light], objs :: [Object], backLgt :: RGB, ambLgt :: RGB}

scene :: Scene
scene = Scene lgtSourc ob backgroundColor ambientLight

