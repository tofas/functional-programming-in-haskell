data Quaternion = Q
    { qR :: Double
    , qI :: Double
    , qJ :: Double
    , qK :: Double
    } deriving Show

-- instance Show Quaternion where
--    show q = "(" ++ 
--        show (qR q) ++ " + " ++
--        show (qI q) ++ " i + " ++
--        show (qJ q) ++ " j + " ++ 
--        show (qK q) ++ " k)"

instance Num Quaternion where
    q0 + q1 = Q (qR q0 + qR q1) (qI q0 + qI q1) (qJ q0 + qJ q1) (qK q0 + qK q1)
    q0 * q1 = undefined -- defer implementation of methods, no force of value -> CRASH
    abs = undefined
    signum = undefined
    fromInteger = undefined
    negate = undefined

main :: IO()
main = print $ Q 1 2 3 4

-- we can change data for newtype, it wraps the parent data class
-- into a new type. This eliminates compiler overhead when creating
-- new dataclases