module Casting.Trace(rayTrace, rayCast) where

import Visual.Color
import Math.Intersection
import Casting.Scene
import Casting.LightRays
import Visual.Material
import Math.Ray
import Math.Vector

maxDepth :: Int
maxDepth = 4

localColor :: Ray -> Scene -> RGB
localColor ray (Scene lsrc obst sBackLgt sAmbLgt) = maybe sBackLgt locColor inters
    where inters = closestIntersection ray obst
          locColor i = (mColor (mat i) `colCombine` sAmbLgt) `colAdd` multipleLightsAt lsrc i obst

reflectedColor :: Int -> Ray -> Scene -> RGB
reflectedColor depth ray s = clamp . (`colMult` (1/fromIntegral depth )) $ maybe black refColor inters
    where inters = closestIntersection ray (objs s)
          refColor i = rayTrace' (depth + 1) (Ray rPos dirRay) s `colMult` mRk (mat i)
            where   rPos = pos i .-. (dirRay .*. 0.1)
                    dirRay = vNeg $ vReflect opRayDir nNormalS
                    opRayDir = vNormalize $ vNeg $ ryDir ray
                    nNormalS = normal i

rayTrace' :: Int -> Ray -> Scene -> RGB
rayTrace' depth ray s
    | depth >= maxDepth = black
    | otherwise = clamp $ localColor ray s `colAdd` reflectedColor depth ray s

rayCast :: Ray -> Scene -> RGB
rayCast ray s = clamp $ localColor ray s

rayTrace :: Ray -> Scene -> RGB
rayTrace = rayTrace' 1