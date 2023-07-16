module Casting.Trace(rayTrace) where

import Visual.Color
import Math.Ray
import Math.Intersection
import Casting.Scene
import Casting.LightRays

maxDepth :: Int
maxDepth = 10

rayTrace' :: Int -> Ray -> Scene -> RGB
rayTrace' depth ray (Scene lsrc objs sBackLgt sAmbLgt)
    | depth == maxDepth = black
    | otherwise         = maybe sBackLgt localColor ptIntersec

        where localColor i = sAmbLgt `colAdd` multipleLightsAt lsrc i objs
              ptIntersec = closestIntersection ray objs

rayTrace :: Ray -> Scene -> RGB
rayTrace = rayTrace' 0