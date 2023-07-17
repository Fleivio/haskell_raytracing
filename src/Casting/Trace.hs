module Casting.Trace(rayTrace) where

import Visual.Color
import Math.Intersection
import Casting.Scene
import Casting.LightRays
import Visual.Material
import Math.Ray
import Math.Vector

maxDepth :: Int
maxDepth = 5

localColor :: Ray -> Scene -> RGB
localColor ray (Scene lsrc objs sBackLgt sAmbLgt) = maybe sBackLgt locColor inters
    where inters = closestIntersection ray objs
          locColor i = (mColor (mat i) `colCombine` sAmbLgt) `colAdd` multipleLightsAt lsrc i objs

--errado
reflectedColor :: Int -> Ray -> Scene -> RGB
reflectedColor depth ray s = clamp . (`colMult` (1/fromIntegral depth )) $ maybe black refColor inters
    where inters = closestIntersection ray (objs s)
          refColor i = rayTrace' (depth + 1) (Ray rPos dirRay) s `colMult` mRk (mat i)
            where   k = 2 * (nNormalS ... opRayDir)
                    rPos = pos i .+. (dirRay .*. 0.1)
                    dirRay = vNeg $ nNormalS .*. k .-. opRayDir
                    opRayDir = vNormalize $ vNeg $ ryDir ray
                    nNormalS = vNormalize $ normal i

            -- where orRay = pos i .+. (dirRay .*. 0.1)
            --       dirRay = vReflect opRayDir (normal i)
            --       opRayDir = vNormalize $ pos i .-. ryOrigin ray

-- reflected_ray :: Integer -> Intersection -> Color
-- reflected_ray depth (normal, hitpoint,(_,in_ray_dir),(color,kr,_)) 
--    | kr == 0.0 = black
--    | otherwise = let k = 2 * ((normalize normal) `dot` (normalize (neg in_ray_dir)))
-- 	             out_ray_dir = (scalarmult (normalize normal) k) `sub` (neg in_ray_dir)
-- 		     reflected_col = raytrace (depth + 1) (hitpoint, out_ray_dir)
--                  in scalarmult reflected_col kr


rayTrace' :: Int -> Ray -> Scene -> RGB
rayTrace' depth ray s
    | depth >= maxDepth = black
    | otherwise = clamp $ localColor ray s `colAdd` reflectedColor depth ray s

rayTrace :: Ray -> Scene -> RGB
rayTrace = rayTrace' 1