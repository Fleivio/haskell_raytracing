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

localColor :: Scene -> Maybe Intersection -> RGB
localColor (Scene lsrc obst sBackLgt sAmbLgt) intrs = maybe sBackLgt locColor intrs
    where locColor i = (mColor (mat i) `colCombine` sAmbLgt) `colAdd` multipleLightsAt lsrc i obst

reflectedColor :: Int -> Scene -> Maybe Intersection -> RGB
reflectedColor depth s intr = clamp $ maybe black refColor intr
    where refColor i = rayTrace' (depth + 1) (Ray rPos dirRay) s `colMult` mRk (mat i)
            where   rPos = pos i .-. (dirRay .*. 0.1)
                    dirRay = vNeg $ vReflect opRayDir nNormalS
                    opRayDir = vNeg $ ryDir ( ry i )
                    nNormalS = normal i


calcColor :: Int -> Ray -> Scene -> RGB
calcColor d r s = localColor s intrs `colAdd` reflectedColor d s intrs
    where intrs = closestIntersection r (objs s)

rayTrace' :: Int -> Ray -> Scene -> RGB
rayTrace' depth ray s
    | depth >= maxDepth = black
    | otherwise = scale $ calcColor depth ray s
        where scale = clamp . (`colMult` (1 / fromIntegral depth))

rayCast :: Ray -> Scene -> RGB
rayCast ray s = clamp $ localColor s intrs
    where intrs = closestIntersection ray (objs s)

rayTrace :: Ray -> Scene -> RGB
rayTrace = rayTrace' 1