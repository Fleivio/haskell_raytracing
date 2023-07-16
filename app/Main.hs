module Main (main) where

import Math.Vector
import Math.Intersection
import Visual.Object
import Casting.Camera
import Visual.Color
import Casting.Scene
import Casting.Trace

camera :: Camera
camera = Camera (Vec3 0 0 (-100)) (-70) 5

camera2 :: Camera
camera2 = Camera (Vec3 0 0 (-100)) 0 50

colorTable :: [[RGB]]
colorTable = map (map castR) rs
    where 
          castR r = rayTrace r scene 
          rs = rayCast camera2

grayTable :: [[Float]]
grayTable = map (map toGray) colorTable

genStringTable :: [String]
genStringTable = [ [ toASCII c | c <- line] ++ "\n" | line <- colorTable]

stringColorTable :: [String]
stringColorTable  = [concat [ show c | c <- line] ++ "\n" | line <- colorTable]


main :: IO ()
main = putStrLn . concat $ genStringTable