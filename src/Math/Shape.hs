module Math.Shape(Shape(..), infinitePlane) where

import Math.Vector

type Vertices = [Vec3]
type Mesh = [[Vec3]]

data Shape
  = Sphere Double Vec3
  | Plane Vec3 Vec3
  | Polygon Vertices
  | Polyhedron Mesh
  | None
  deriving (Show, Eq)

infinitePlane :: Shape -> Shape
infinitePlane (Polygon (v1 : v2 : v3 : _)) = Plane v1 (vNormalize $ vCross (v2 .-. v1) (v3 .-. v1))
infinitePlane p@(Plane _ _) = p
infinitePlane _ = None