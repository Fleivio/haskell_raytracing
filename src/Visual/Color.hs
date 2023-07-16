{-# LANGUAGE AllowAmbiguousTypes #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}

module Visual.Color (RGB(..), Color (..)) where

class Color a where
  colMax :: Float
  colMin :: Float
  colAdd :: a -> a -> a
  colMult :: a -> Float -> a
  colCombine :: a -> a -> a
  clamp :: a -> a
  toGray :: a -> Float
  toASCII :: a -> Char

  white :: a
  black :: a
  red :: a
  green :: a
  blue :: a

data RGB = RGB {r :: Float, g :: Float, b :: Float} deriving Eq

aciiTable :: String
aciiTable = "`.-':_,^=;><+!rc*/z?sLTv)J7(|Fi{C}fI31tlu[neoZ5Yxjya]2ESwqkP6h9d4VpOGbUAKXHm8RD#$Bg0MNWQ%&@"

brighLevels :: [Float]
brighLevels = [0, 0.0751, 0.0829, 0.0848, 0.1227, 0.1403, 0.1559, 0.185, 0.2183, 0.2417, 0.2571, 0.2852, 0.2902, 0.2919, 0.3099, 0.3192, 0.3232, 0.3294, 0.3384, 0.3609, 0.3619, 0.3667, 0.3737, 0.3747, 0.3838, 0.3921, 0.396, 0.3984, 0.3993, 0.4075, 0.4091, 0.4101, 0.42, 0.423, 0.4247, 0.4274, 0.4293, 0.4328, 0.4382, 0.4385, 0.442, 0.4473, 0.4477, 0.4503, 0.4562, 0.458, 0.461, 0.4638, 0.4667, 0.4686, 0.4693, 0.4703, 0.4833, 0.4881, 0.4944, 0.4953, 0.4992, 0.5509, 0.5567, 0.5569, 0.5591, 0.5602, 0.5602, 0.565, 0.5776, 0.5777, 0.5818, 0.587, 0.5972, 0.5999, 0.6043, 0.6049, 0.6093, 0.6099, 0.6465, 0.6561, 0.6595, 0.6631, 0.6714, 0.6759, 0.6809, 0.6816, 0.6925, 0.7039, 0.7086, 0.7235, 0.7302, 0.7332, 0.7602, 0.7834, 0.8037, 0.9999]

instance Show RGB where
  show (RGB r g b) = "(" ++ show r ++ " " ++ show g ++ " " ++ show b ++ ")"

instance Color RGB where
  colMax = 1
  colMin = 0
  colAdd c1 c2 = RGB (r c1 + r c2) (g c1 + g c2) (b c1 + b c2)
  colMult c d = RGB (r c * d) (g c * d) (b c * d)
  colCombine c1 c2 = RGB (r c1 * r c2) (g c1 * g c2) (b c1 * b c2)
  clamp (RGB r1 g1 b1) = RGB (clamp' r1) (clamp' g1) (clamp' b1)
    where
      clamp' x = max 0 (min x 1)
  toGray (RGB r1 g1 b1) = 0.299 * r1 + 0.587 * g1 + 0.114 * b1

  white = RGB 1 1 1
  black = RGB 0 0 0
  red = RGB 1 0 0
  green = RGB 0 1 0
  blue = RGB 0 0 1

  toASCII c = aciiTable !! round (toGray c * 100)
