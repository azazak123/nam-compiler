module Lib
    ( someFunc, loop, (-->), (==>), replace
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

loop :: Eq a => ([a] -> [a]) -> [a] -> [a]
loop nam arr = if result == arr then arr else loop nam result
  where
    result = nam arr

(-->) :: Eq a => [a] -> [a] -> [a] -> [a]
(-->) a b arr = if result == arr then arr else (-->) a b result
  where
    result = concat $ replace a b arr False

(==>) :: Eq a => [a] -> [a] -> [a] -> [a]
(==>) a b arr = if result == arr then arr else (==>) a b result
  where
    result = concat $ replace a b arr True

replace :: Eq a => [a] -> [a] -> [a] -> Bool -> [[a]]
replace a b arr end
  | length arr >= length a = fst lastElement : (if not end && snd lastElement then [drop (length a) arr] else (replace a b (if snd lastElement then drop (length a) arr else tail arr) end))
  | otherwise = [arr]
  where
    check arr
      | arr == a = (b, True)
      | otherwise = ([head arr], False)
    lastElement = check (take (length a) arr)