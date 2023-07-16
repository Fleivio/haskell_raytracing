module Casting.LightRays(multipleLightsAt, singleLightAt) where

import Math.Vector
import Visual.Color
import Visual.Light
import Visual.Object
import Visual.Material
import Math.Intersection

lightIntensityAt :: Vec3 -> Vec3 -> Float
lightIntensityAt lightDir normal = max 0 (nNormal ... nLight)
    where
        nNormal = vNormalize normal
        nLight = vNormalize lightDir

singleLightAt :: Light -> Intersection -> [Object] -> RGB
singleLightAt lg (Intersection iNormal _ iMaterial iPos ) os = if lightReachPoint
                                                               then totalLight `colMult` mDk iMaterial
                                                               else black
    where lgtPlusMatColor = colCombine (lgtColor lg) (mColor iMaterial)
          lDirection = lgtPosition lg .-. iPos
          lightReachPoint = isPathFree iPos (lgtPosition lg) os
          lightIntensity = lightIntensityAt lDirection iNormal
          totalLight = lgtPlusMatColor `colMult` lightIntensity

multipleLightsAt :: [Light] -> Intersection -> [Object] -> RGB
multipleLightsAt lights inters os = foldl colAdd black (map (\l -> singleLightAt l inters os) lights)