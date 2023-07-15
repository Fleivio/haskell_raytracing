module Visual.Object(InstanceObject, Object(..), oObject, oPosition, oMaterial) where

import Math.Vector
import Visual.Material

data Object = Sphere Float | None
            deriving (Show, Eq)

type InstanceObject = (Object, Vector, Material)

oObject :: InstanceObject -> Object
oObject (o, _, _) = o

oPosition :: InstanceObject -> Position
oPosition (_, p, _) = p

oMaterial :: InstanceObject -> Material
oMaterial (_, _, m) = m

