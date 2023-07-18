module Visual.Material (Material (..), Coefficient, glass, wood, mirror, rubber, metal, plastic, vanta) where

import Visual.Color

type Coefficient = Double

type Reflective = Coefficient

type Specular = Coefficient

type Transparency = Coefficient

type Diffuse = Coefficient

data Material = Material
  { mColor :: RGB,
    mSk :: Specular,
    mRk :: Reflective,
    mTk :: Transparency,
    mDk :: Diffuse
  }
  deriving (Show, Eq)

glass :: Material
glass = Material {mColor = RGB 0.0 0.0 0.0, mSk = 0.0, mRk = 1, mTk = 0.9, mDk = 0.0}

wood :: Material
wood = Material {mColor = RGB 0.6 0.3 0.1, mSk = 0.01, mRk = 0, mTk = 0.0, mDk = 0.8}

mirror :: Material
mirror = Material {mColor = RGB 0.5 0.5 0.5, mSk = 1.2, mRk = 1, mTk = 0.0, mDk = 0.9}

rubber :: Material
rubber = Material {mColor = RGB 0.1 0.1 0.1, mSk = 0.1, mRk = 0.1, mTk = 0.0, mDk = 0.9}

metal :: Material
metal = Material {mColor = RGB 0.3 0.3 0.33, mSk = 0.7, mRk = 0.6, mTk = 0.0, mDk = 0.8}

plastic :: Material
plastic = Material {mColor = RGB 1 0 0, mSk = 0.5, mRk = 0.2, mTk = 0.0, mDk = 0.5}

vanta :: Material
vanta = Material {mColor = RGB 0.0 0.0 0.0, mSk = 0.0, mRk = 0, mTk = 0.0, mDk = 0}