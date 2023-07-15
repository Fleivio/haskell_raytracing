module Math.Ray (Ray, rOrigin, rDirection, rPointAt, ray) where

import Math.Vector

type Ray = (Position, Vector)

ray :: Position -> Vector -> Ray
ray = (,)

rOrigin :: Ray -> Position
rOrigin (o, _) = o

rDirection :: Ray -> Vector
rDirection (_, d) = d

rPointAt :: Ray -> Float -> Position
rPointAt (o, d) t = add o (mul d t)

rReflect :: Ray -> Vector -> Ray
rReflect (o, d) n = (o, sub d (mul n (2 * dot d n)))

