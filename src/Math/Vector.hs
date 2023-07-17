module Math.Vector (Vector (..), Vec3 (..)) where

class Vector a where
  vZero :: a
  (.+.) :: a -> a -> a
  (.-.) :: a -> a -> a
  (./.) :: a -> Double -> a
  (.*.) :: a -> Double -> a
  (<->) :: a -> a -> Double
  (...) :: a -> a -> Double
  (.\/.) :: a -> a -> Double
  (.><.) :: a -> a -> a
  vDot :: a -> a -> Double
  vNeg :: a -> a
  vDistance :: a -> a -> Double
  vAngle :: a -> a -> Double
  vModul :: a -> Double
  vNormalize :: a -> a
  vCross :: a -> a -> a
  vReflect :: a -> a -> a

data Vec3 = Vec3 {x :: Double, y :: Double, z :: Double} deriving (Show, Eq)

instance Vector Vec3 where
  vZero = Vec3 0 0 0

  (Vec3 x1 y1 z1) .+. (Vec3 x2 y2 z3) = Vec3 (x1 + x2) (y1 + y2) (z1 + z3)

  (Vec3 x1 y1 z1) .-. (Vec3 x2 y2 z3) = Vec3 (x1 - x2) (y1 - y2) (z1 - z3)

  (Vec3 x1 y1 z1) ./. f = Vec3 (x1 / f) (y1 / f) (z1 / f)

  (Vec3 x1 y1 z1) .*. f = Vec3 (x1 * f) (y1 * f) (z1 * f)

  (Vec3 x1 y1 z1) ... (Vec3 x2 y2 z3) = (x1 * x2) + (y1 * y2) + (z1 * z3)

  (Vec3 x1 y1 z1) <-> (Vec3 x2 y2 z3) = sqrt $ (x1 - x2) ** 2 + (y1 - y2) ** 2 + (z1 - z3) ** 2

  (Vec3 x1 y1 z1) .><. (Vec3 x2 y2 z2) = Vec3 (y1 * z2 - z1 * y2) (z1 * x2 - x1 * z2) (x1 * y2 - y1 * x2)

  v1 .\/. v2 = acos $ (v1 ... v2) / (vModul v1 * vModul v2)

  vDot = (...)

  vNeg v = v .*. (-1)

  vDistance = (<->)

  vAngle = (.\/.)

  vModul (Vec3 x1 y1 z1) = sqrt $ x1 ** 2 + y1 ** 2 + z1 ** 2

  vNormalize v = v ./. vModul v

  vCross v1 v2 = v1 .><. v2

  vReflect vec nor = nor .*. p .-. vec
    where p = (vec ... nor) * 2
