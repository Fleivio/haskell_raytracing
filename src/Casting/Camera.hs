module Casting.Camera(Camera, rayCast) where

import Math.Vector
import Math.Ray

type Eye = Vector
type Near = Float
type Resolution = Float

type Camera = (Eye, Near, Resolution)

resolutionVec :: Camera -> [Float]
resolutionVec (_, _, r) = [-r..r]

genRay :: Camera -> Vector -> Ray
genRay (e, n, _) p = ray e (normalize $ sub p e)

rayCast :: Camera -> [[Ray]]
rayCast c@(e, n, r) = map (map (genRay c)) vecs
    where vecs = [[vector x y n | x <- rv] 
                                | y <- rv]
          rv = resolutionVec c
