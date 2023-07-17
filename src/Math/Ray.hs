module Math.Ray (Ray(..), rPointAt, rReflect) where

import Math.Vector

data Ray = Ray {ryOrigin :: Vec3, ryDir :: Vec3 } deriving (Show, Eq) 

rPointAt :: Ray -> Double -> Vec3
rPointAt (Ray o d) t = o .+. (d .*. t)

-- Retorna um raio refletido por um vetor normal
-- Raio incidente -> Vetor normal -> Ponto de origem do novo raio
rReflect :: Ray -> Vec3 -> Vec3 -> Ray
rReflect (Ray _ d) n orig = Ray orig (vReflect d n)
    