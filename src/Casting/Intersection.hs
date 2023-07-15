module Casting.Intersection(Intersection, closestIntersection) where

import Math.Vector
import Visual.Object
import Math.Ray
import Visual.Material

type Intersection = (Vector, Ray, Material, Position)
                --   normal, raio, material, posição

solve2 :: Float -> Float -> Float -> Maybe (Float, Float)
solve2 a b c = let d = b * b - 4 * a * c
               in if d < 0
                  then Nothing
                  else let t1 = (-b - sqrt d) / (2 * a)
                           t2 = (-b + sqrt d) / (2 * a)
                       in Just (t1, t2)

-- por enquanto apenas esferas
-- https://gamedev.stackexchange.com/questions/96459/fast-ray-sphere-collision-code
intersect :: Ray -> InstanceObject -> [(Float, Intersection)]
intersect r@(rayOrigin, rayDir) 
          (object, obCenter, material) 
    = case object of
        Sphere radius-> let m = sub rayOrigin obCenter
                            b = dot rayDir m
                            c = dot m m - radius * radius
                        in
                            case solve2 1 (2 * b) c of
                                Nothing -> []
                                Just (t1, t2) -> 
                                    let t = if t1 < 0 then t2 else t1
                                        t' = max t 0
                                        p = rPointAt r t'
                                        n = normalize $ sub p obCenter
                                    in [(t', (n, r, material, p))]
        None -> []

closestIntersection :: Ray -> [InstanceObject] -> Maybe Intersection
closestIntersection r os = let intersections = concatMap (intersect r) os
                           in if null intersections
                              then Nothing
                              else let (_, i) = minimum intersections
                                   in Just i