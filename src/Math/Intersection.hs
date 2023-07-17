module Math.Intersection(Intersection(..), closestIntersection, isPathFree) where

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
isPathFree origin destiny objs = let r = Ray rayOrig rayDir
                                     intersec = closestIntersection r objs
                                 in case intersec of 
                                    Nothing -> True
                                    Just i -> distanceToDestiny <= vDistance (pos i) origin
    where rayDir = vNormalize $ destiny .-. origin
          rayOrig = origin 
          distanceToDestiny = destiny <-> origin

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
                                   in Just $ snd closest

