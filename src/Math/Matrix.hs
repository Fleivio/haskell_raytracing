module Math.Matrix(Matrix, mIdentity, mScale, mScaleFactor, mScaleVec,
                  mChangeBase, mLookAt, mMul, mRotateX, mRotateY, mRotateZ, mApp,
                  mTranslate, mTranslateVec) where

import Math.Vector

type Matrix = ( Vector,
                Vector,
                Vector,
                Vector
              )

mIdentity :: Matrix
mIdentity = ((1, 0, 0, 0),
            (0, 1, 0, 1),
            (0, 0, 1, 0),
            (0, 0, 0, 1))

mScale :: Float -> Float -> Float -> Matrix
mScale x y z = ((x, 0, 0, 0),
                (0, y, 0, 0),
                (0, 0, z, 0),
                (0, 0, 0, 1))

mScaleVec :: Vector -> Matrix
mScaleVec (x, y, z, _) = mScale x y z

mScaleFactor :: Float -> Matrix
mScaleFactor f = mScale f f f

mTranslate :: Float -> Float -> Float -> Matrix
mTranslate x y z = ((1, 0, 0, x),
                    (0, 1, 0, y),
                    (0, 0, 1, z),
                    (0, 0, 0, 1))

mTranslateVec :: Vector -> Matrix
mTranslateVec (x, y, z, _) = ((1, 0, 0, x),
                              (0, 1, 0, y),
                              (0, 0, 1, z),
                              (0, 0, 0, 1))

mRotateX :: Float -> Matrix
mRotateX a = ((1, 0, 0, 0),
              (0, cos a, -sin a, 0),
              (0, sin a, cos a, 0),
              (0, 0, 0, 1))

mRotateY :: Float -> Matrix
mRotateY a = ((cos a, 0, sin a, 0),
              (0, 1, 0, 0),
              (-sin a, 0, cos a, 0),
              (0, 0, 0, 1))

mRotateZ :: Float -> Matrix
mRotateZ a = ((cos a, -sin a, 0, 0),
              (sin a, cos a, 0, 0),
              (0, 0, 1, 0),
              (0, 0, 0, 1))

mChangeBase :: Vector -> Vector -> Vector -> Matrix
mChangeBase v1 v2 v3 = (v1, v2, v3, (0, 0, 0, 1))

mLookAt :: Vector -> Vector -> Vector -> Matrix
mLookAt eye center up = mMul translateEye camBasis
    where translateEye = mTranslateVec $ mul eye (-1)
          camBasis     = mChangeBase r u n
                where n = normalize $ sub center eye
                      r = normalize $ cross n up
                      u = normalize $ cross r n

mApp :: Matrix -> Vector -> Vector
mApp (v1, v2, v3, v4) (x, y, z, w) = (dot4 v1 (x, y, z, w),
                                      dot4 v2 (x, y, z, w),
                                      dot4 v3 (x, y, z, w),
                                      dot4 v4 (x, y, z, w))

mMul :: Matrix -> Matrix -> Matrix
mMul (v1, v2, v3, v4) (v5, v6, v7, v8) = (mApp (v1, v2, v3, v4) v5,
                                         mApp (v1, v2, v3, v4) v6,
                                         mApp (v1, v2, v3, v4) v7,
                                         mApp (v1, v2, v3, v4) v8)