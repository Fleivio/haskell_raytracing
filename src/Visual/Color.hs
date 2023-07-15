module Visual.Color(Color, white, black, red, green, blue, colAdd, colMult, colMultCol) where


type Color = (Float, Float, Float)

white :: Color
white = (1,1,1)
black :: Color
black = (0,0,0)
red :: Color
red = (1,0,0)
green :: Color
green = (0,1,0)
blue :: Color
blue = (0,0,1)

colAdd :: Color -> Color -> Color
colAdd (r1,g1,b1) (r2,g2,b2) = (r1 + r2, g1 + g2, b1 + b2)

colMult :: Color -> Float -> Color
colMult (r,g,b) d = (r * d, g * d, b * d)

colMultCol :: Color -> Color -> Color
colMultCol (r1,g1,b1) (r2,g2,b2) = (r1 * r2, g1 * g2, b1 * b2)