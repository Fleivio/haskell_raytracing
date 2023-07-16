module Casting.Camera (Camera (..), rayCast) where

import Math.Ray
import Math.Vector

type Eye = Vec3

type Near = Float

type Resolution = Float

data Camera = Camera {eye :: Eye, near :: Near, res :: Resolution} deriving (Show, Eq)

resolutionVec :: Camera -> [Float]
resolutionVec Camera {res = r} = [-r .. r]

genRay :: Camera -> Vec3 -> Ray
genRay Camera {eye = e} p = Ray e (vNormalize $ p .-. e)

rayCast :: Camera -> [[Ray]]
rayCast c@Camera {near = n} = map (map (genRay c)) vecs
  where
    vecs =
      [ [Vec3 a b n | a <- rv]
        | b <- rv
      ]
    rv = resolutionVec c
