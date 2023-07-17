module Visual.Material (Material (..), Coefficient, glass, wood, mirror, rubber, metal, plastic, vanta) where

import Visual.Color

type Coefficient = Double

type Reflective = Coefficient

type Transparency = Coefficient

type Diffuse = Coefficient

data Material = Material
  { mColor :: RGB,
    mRk :: Reflective,
    mTk :: Transparency,
    mDk :: Diffuse
  }
  deriving (Show, Eq)

glass :: Material
glass = Material {mColor = RGB 0.0 0.0 0.0, mRk = 0.0, mTk = 0.9, mDk = 0.0}

wood :: Material
wood = Material {mColor = RGB 0.6 0.3 0.1, mRk = 0.4, mTk = 0.0, mDk = 0.4}

mirror :: Material
mirror = Material {mColor = RGB 0.8 0.8 0.8, mRk = 0.9, mTk = 0.0, mDk = 0.01}

rubber :: Material
rubber = Material {mColor = RGB 0.1 0.1 0.1, mRk = 0.0, mTk = 0.0, mDk = 0.9}

metal :: Material
metal = Material {mColor = RGB 0.7 0.7 0.7, mRk = 0.9, mTk = 0.0, mDk = 0.4}

plastic :: Material
plastic = Material {mColor = RGB 1 0 0, mRk = 1, mTk = 0.0, mDk = 0.5}

vanta :: Material
vanta = Material {mColor = RGB 0.0 0.0 0.0, mRk = 0.0, mTk = 0.0, mDk = 1}