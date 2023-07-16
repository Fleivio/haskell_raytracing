module Casting.Camera (Camera (..), rayCast, smallCamera, baseCamera, hugeCamera ) where

import Math.Ray
import Math.Vector

type Eye = Vec3

type Near = Float

type Resolution = Integer

data Camera = Camera {eye :: Eye, near :: Near, res :: Resolution} deriving (Show, Eq)

resolutionVec :: Camera -> [Integer]
resolutionVec Camera {res = r} = [-r .. r]

genRay :: Camera -> Vec3 -> Ray
genRay Camera {eye = e} p = Ray e (vNormalize $ p .-. e)

rayCast :: Camera -> [[Ray]]
rayCast c@Camera {near = n} = map (map (genRay c)) vecs
  where
    vecs =
      [ [Vec3 (fromInteger a) (fromInteger b) n | a <- rv]
        | b <- rv
      ]
    rv = resolutionVec c

smallCamera :: Camera
smallCamera = Camera (Vec3 0 0 (-100)) (-70) 5

baseCamera :: Camera
baseCamera = Camera (Vec3 0 0 (-100)) 0 50

hugeCamera :: Camera
hugeCamera = Camera (Vec3 0 0 (-100)) 400 200