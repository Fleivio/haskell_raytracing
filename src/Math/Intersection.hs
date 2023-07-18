module Math.Intersection(Intersection(..), closestIntersection, isPathFree, isPointLig) where

import Math.Vector
import Visual.Object
import Math.Ray
import Visual.Material

import Data.List (sortOn)

data Intersection = Intersection{ normal :: Vec3, ry :: Ray, mat :: Material, pos :: Vec3 } deriving (Show, Eq)

solve2 :: Double -> Double -> Double -> Maybe (Double, Double)
solve2 a b c = let d = b * b - 4 * a * c
               in if d < 0
                  then Nothing
                  else let t1 = (-b - sqrt d) / (2 * a)
                           t2 = (-b + sqrt d) / (2 * a)
                       in Just (t1, t2)

isPathFree :: Vec3 -> Vec3 -> [Object] -> Bool
isPathFree origin destiny objs = let r = Ray origin rayDir
                                     intersec = closestIntersection r objs
                                 in case intersec of 
                                    Nothing -> True
                                    Just i -> (pos i <-> origin) > (origin <-> destiny) 
    where rayDir = vNormalize $ destiny .-. origin

isPointLig :: Vec3 -> Vec3 -> [Object] -> Bool
isPointLig position light obst = isPathFree light (position .+. vNormalize (light .-. position)) obst

intersect :: Ray -> Object -> [(Double, Intersection)]
intersect r@(Ray rayOrigin rayDir)
          (Object shape obCenter material)
    = case shape of
        Sphere radius-> let m = rayOrigin .-. obCenter
                            b = rayDir ... m
                            c =  m ... m - radius * radius
                        in
                            case solve2 1 (2 * b) c of
                                Nothing -> []
                                Just (t1, t2) ->
                                    let t = if t1 < 0 then t2 else t1
                                        t' = max t 0
                                        p = rPointAt r t'
                                        n = vNormalize $ p .-. obCenter
                                    in [(t', Intersection n r material p)]
        None -> []

closestIntersection :: Ray -> [Object] -> Maybe Intersection
closestIntersection r os = let intersections = concatMap (intersect r) os
                           in if null intersections
                              then Nothing
                              else let closest = head $ sortOn fst intersections
                                   in if fst closest > 1000 then Nothing else Just . snd $ closest

