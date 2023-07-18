module Casting.LightRays(multipleLightsAt) where

import Math.Vector
import Visual.Color
import Visual.Light
import Visual.Object
import Visual.Material
import Math.Intersection
import Math.Ray
import Data.Fixed(mod')

diffuseIntensityAt :: Vec3 -> Vec3 -> Double
diffuseIntensityAt lightDir n = max 0 (nNormal ... nLight)
    where
        nNormal = vNormalize n
        nLight = vNormalize lightDir

diffuseLight :: Light -> Intersection -> [Object] -> RGB
diffuseLight (Light lightPosition lightColor)
             (Intersection iNormal _ (Material mCol _ _ _ ) iPos )
             objs =  if lightReachPoint
                     then combCols `colMult` lightIntensity
                     else black
    where combCols = colCombine lightColor mCol
          lightReachPoint = isPointLig iPos lightPosition objs
          lightIntensity = diffuseIntensityAt (lightPosition .-. iPos) iNormal

diffuseLights :: [Light] -> Intersection -> [Object] -> RGB
diffuseLights lights inters os = clamp $ foldl colAdd black (map (\l -> diffuseLight l inters os) lights)


specularIntensityAt :: Vec3 -> Vec3 -> Vec3  -> Double
specularIntensityAt lightDir n viewDir = cos phi ** 100
    where
        reflectedDir = vNormalize $ vReflect nLight nNormal
        nNormal = vNormalize n
        nLight = vNormalize lightDir
        nView = vNormalize viewDir
        phi = vAngle reflectedDir nView `mod'` pi

specularLight :: Light -> Intersection -> [Object] -> RGB
specularLight (Light lightPosition lightColor)
              (Intersection iNormal ry' _ iPos)
              objs = if lightReachPoint
                     then lightColor `colMult` lightIntensity
                     else black
    where   viewDir = vNeg $ ryDir ry'
            lightReachPoint = isPointLig iPos lightPosition objs
            lightIntensity = specularIntensityAt (lightPosition .-. iPos) iNormal viewDir

specularLights :: [Light] -> Intersection -> [Object] -> RGB
specularLights lights inters os = clamp $ foldl colAdd black (map (\l -> specularLight l inters os) lights)

multipleLightsAt :: [Light] -> Intersection -> [Object] -> RGB
multipleLightsAt lights inters os = clamp $ specularLights lights inters os `colMult` rk `colAdd`
                                    diffuseLights lights inters os `colMult` dk
    where dk = mDk $ mat inters
          rk = mRk $ mat inters