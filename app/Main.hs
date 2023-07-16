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

colorTable :: [[RGB]]
colorTable = map (map castR) rs
    where 
          castR r = rayTrace r scene 
          rs = rayCast camera

grayTable :: [[Float]]
grayTable = map (map toGray) colorTable

genStringTable :: [[Float]] -> [String]
genStringTable grays = [ [ dealInt c | c <- line] ++ "\n" | line <- grays]
    where dealInt c 
            | c <= 0 = ' '
            | c < 0.25 = '.'
            | c < 0.5 = '-'
            | c < 0.75 = '+'
            | c < 1 = '*'
            | otherwise = '#'

stringColorTable :: [String]
stringColorTable  = [concat [ show c | c <- line] ++ "\n" | line <- colorTable]


main :: IO ()
main = putStrLn . concat $ stringColorTable