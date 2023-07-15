module Math.Vector (Vector, Position, vector, vectorZero, add, sub, dot, dot4, modul, mul, cross, normalize, getX, getY, getZ, getW) where

type Vector = (Float, Float, Float, Float)
type Position = Vector

vector :: Float -> Float -> Float -> Vector
vector x y z = (x, y, z, 1)

getX :: Vector -> Float
getX (x, _, _, _) = x

getY :: Vector -> Float
getY (_, y, _, _) = y

getZ :: Vector -> Float
getZ (_, _, z, _) = z

getW :: Vector -> Float
getW (_, _, _, w) = w

vectorZero :: Vector
vectorZero = (0,0,0,1)

add :: Vector -> Vector -> Vector
add (x1,y1,z1,w1) (x2,y2,z2,w2) = (x1 + x2, y1 + y2, z1 + z2, w1 + w2)

sub :: Vector -> Vector -> Vector
sub (x1,y1,z1,w1) (x2,y2,z2,w2) = (x1 - x2, y1 - y2, z1 - z2, w1 - w2)

dot :: Vector -> Vector -> Float
dot (x1,y1,z1,_) (x2,y2,z2,_) = x1 * x2 + y1 * y2 + z1 * z2

dot4 :: Vector -> Vector -> Float
dot4 (x1,y1,z1,w1) (x2,y2,z2,w2) = x1 * x2 + y1 * y2 + z1 * z2 + w1 * w2

modul :: Vector -> Float
modul (x,y,z,w) = sqrt $ x**2 + y**2 + z**2 + w**2

mul :: Vector -> Float -> Vector
mul (x,y,z,w) d = (x*d, y*d, z*d, w*d)

cross :: Vector -> Vector -> Vector
cross (x1,y1,z1,_) (x2,y2,z2,_) = vector x y z
    where x = y1 * z2 + z1 * y2
          y = - (x1 * z2 + z1 * x2)
          z = x1 * y2 + x2 * y1

normalize :: Vector -> Vector
normalize v = if modul v == 0 then vectorZero else v `mul` t
    where t = 1 / modul v
