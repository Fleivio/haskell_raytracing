module Ppm.Ppm (makePgm) where

import Visual.Color
-- Image output: We can write a ppm (Portable Pixmap) file by converting a list of
-- colors (length is width * height) into a big string
makePgm :: Integer -> Integer -> [ RGB ] -> String
makePgm width height xs = "P3\n" ++ show width ++ " " ++ show height ++ "\n255\n" ++ stringify xs
                  where stringify [] = ""
                        stringify ((RGB r g b) : xs') = show (scale255 r) ++ " "
                                                        ++ show (scale255 g) ++ " "
                                                        ++ show (scale255 b) ++ " "
                                                        ++ stringify xs'