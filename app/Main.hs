module Main (main) where

import Math.Vector
import Casting.Intersection
import Visual.Object
import Visual.Color
import Casting.Camera

sphere :: InstanceObject
sphere = (Sphere 20, vector 0 0 10, (red, 0, 0, 0, 0, 0.5))

camera :: Camera
camera = (vector 0 0 (-100), 1, 20)

genIntersctTable :: [InstanceObject] -> [[Maybe Intersection]]
genIntersctTable os = intersect'
    where obIntersect r = closestIntersection r os
          intersect' = map (map obIntersect) rs
          rs = rayCast camera

genStringTable :: [[Maybe Intersection]] -> [String]
genStringTable is = [ [ dealInt i | i <- line] ++ "\n" | line <- is]
    where dealInt i = if i == Nothing then ' ' else 'o' 

main :: IO ()
main = putStrLn . concat $ genStringTable (genIntersctTable [sphere])