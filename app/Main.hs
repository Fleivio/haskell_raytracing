module Main (main) where

import Math.Vector
import Math.Intersection
import Visual.Object
import Casting.Camera
import Visual.Color
import Casting.Scene
import Casting.Trace
import Ppm.Ppm (makePgm)
import Math.Ray 

cam :: Camera
cam = hugeCamera

colorTable :: [[RGB]]
colorTable = map (map castR) rs
    where 
          castR r = rayTrace r scene 
          rs = rayCast cam

grayTable :: [[Double]]
grayTable = map (map toGray) colorTable

genStringTable :: [String]
genStringTable = [ [ toASCII c | c <- line] ++ "\n" | line <- colorTable]

stringColorTable :: [String]
stringColorTable  = [concat [ show c | c <- line] ++ "\n" | line <- colorTable]


main :: IO ()
main = do 
    print $ vReflect (Vec3 (-1) (-1) 0) (Vec3 0 1 0)
    writeFile "test.ppm" (makePgm resol resol colorString)
    where 
        resol = fromIntegral $ length colorTable
        colorString = concat colorTable