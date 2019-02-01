module ColourRGBRecord (Colour) where

data Colour = RGB 
    { red :: Int
    , green :: Int
    , blue :: Int
    } deriving Show