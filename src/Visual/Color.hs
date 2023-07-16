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

  white :: a
  black :: a
  red :: a
  green :: a
  blue :: a

data RGB = RGB {r :: Float, g :: Float, b :: Float} deriving (Show, Eq)

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