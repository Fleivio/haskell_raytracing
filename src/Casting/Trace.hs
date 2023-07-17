module Casting.Trace(rayTrace) where

import Visual.Color
import Math.Intersection
import Casting.Scene
import Casting.LightRays
import Visual.Material
import Math.Ray
import Math.Vector

maxDepth :: Int
maxDepth = 3

localColor :: Ray -> Scene -> RGB
localColor ray (Scene lsrc objs sBackLgt sAmbLgt) = maybe sBackLgt locColor inters
    where inters = closestIntersection ray objs
          locColor i = (mColor (mat i) `colCombine` sAmbLgt) `colAdd` multipleLightsAt lsrc i objs

--errado
reflectedColor :: Int -> Ray -> Scene -> RGB
reflectedColor depth ray s = clamp . (`colMult` (1 / fromIntegral depth))  $ maybe black refColor inters
    where inters = closestIntersection ray (objs s)
          refColor i = rayTrace' (depth + 1) (Ray orRay dirRay ) s `colMult` mRk (mat i)
            where dirRay = vNormalize $ vReflect (ryOrigin ray .-. pos i) (normal i) 
                  orRay = pos i .+. dirRay

rayTrace' :: Int -> Ray -> Scene -> RGB
rayTrace' depth ray s
    | depth >= maxDepth = black
    | otherwise = localColor ray s
        
rayTrace :: Ray -> Scene -> RGB
rayTrace = rayTrace' 1