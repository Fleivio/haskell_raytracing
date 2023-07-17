module Math.Ray (Ray(..), rPointAt) where

import Math.Vector

data Ray = Ray {ryOrigin :: Vec3, ryDir :: Vec3 } deriving (Show, Eq) 

rPointAt :: Ray -> Double -> Vec3
rPointAt (Ray o d) t = o .+. (d .*. t)