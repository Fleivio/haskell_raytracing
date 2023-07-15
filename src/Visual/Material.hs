module Visual.Material ( Material, Reflective, Refractive, Diffuse, Specular, Shininess,
                        mColor, mReflective, mRefractive, mDiffuse, mSpecular, mShininess) where

import Visual.Color

type Reflective = Float
type Refractive = Float
type Diffuse = Float
type Specular = Float
type Shininess = Float

type Material = (Color, Reflective, Refractive, Diffuse, Specular, Shininess)

mColor :: Material -> Color
mColor (c, _, _, _, _, _) = c

mReflective :: Material -> Reflective
mReflective (_, r, _, _, _, _) = r

mRefractive :: Material -> Refractive
mRefractive (_, _, r, _, _, _) = r

mDiffuse :: Material -> Diffuse
mDiffuse (_, _, _, d, _, _) = d

mSpecular :: Material -> Specular
mSpecular (_, _, _, _, s, _) = s

mShininess :: Material -> Shininess
mShininess (_, _, _, _, _, s) = s