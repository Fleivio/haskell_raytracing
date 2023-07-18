module Main (main) where

import Casting.Camera
import Visual.Color
import Casting.Scene
import Casting.Trace
import Ppm.Ppm (makePgm)

cam :: Camera
cam = hugeCamera

colorTable :: [[RGB]]
colorTable = map (map castR) rs
    where 
          castR r' = rayTrace r' scene 
          rs = rayCast cam

_grayTable :: [[Double]]
_grayTable = map (map toGray) colorTable

_genStringTable :: [String]
_genStringTable = [ [ toASCII c | c <- line] ++ "\n" | line <- colorTable]

_stringColorTable :: [String]
_stringColorTable  = [concat [ show c | c <- line] ++ "\n" | line <- colorTable]


main :: IO ()
main = do 
    writeFile "test.ppm" (makePgm resol resol colorString)
    where 
        resol = fromIntegral $ length colorTable
        colorString = concat colorTable