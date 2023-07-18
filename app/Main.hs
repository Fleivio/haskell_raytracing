module Main (main) where

import Casting.Camera
import Visual.Color
import Casting.Scene
import Casting.Trace
import Ppm.Ppm (makePgm)

cam :: Camera
cam = hugeCamera

colorTraced :: [[RGB]]
colorTraced = map (map castR) rs
    where 
          castR r' = rayTrace r' scene 
          rs = castRay cam

colorCasted :: [[RGB]]
colorCasted = map (map castR) rs
    where 
          castR r' = rayCast r' scene 
          rs = castRay cam

_grayTable :: [[Double]]
_grayTable = map (map toGray) colorTraced

_genStringTable :: [String]
_genStringTable = [ [ toASCII c | c <- line] ++ "\n" | line <- colorTraced]

_stringColorTable :: [String]
_stringColorTable  = [concat [ show c | c <- line] ++ "\n" | line <- colorTraced]


main :: IO ()
main = do 
    writeFile "traced.ppm" (makePgm resol resol (concat colorTraced))
    writeFile "casted.ppm" (makePgm resol resol (concat colorCasted))
    where 
        resol = fromIntegral $ length colorTraced