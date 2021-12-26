module Lib
    ( someFunc, loop, (-->), (==>), replace
    ) where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

loop :: Eq a => (([a], Bool) -> ([a], Bool)) -> [a] -> Bool -> [a]
loop nam arr end
 | not $ snd result = fst result
 | otherwise = if fst result == arr then arr else loop nam (fst result) $ True
  where
    result = nam (arr, end)

(-->) :: Eq a => [a] -> [a] -> ([a], Bool) -> ([a], Bool)
(-->) a b arr
 | snd arr = (result, True)
 | otherwise = arr
  where
    result = concat $ replace a b (fst arr) True

(==>) :: Eq a => [a] -> [a] -> ([a], Bool) -> ([a], Bool)
(==>) a b arr
 | snd arr = (result, False)
 | otherwise = arr
  where
    result = concat $ replace a b (fst arr) True

replace :: Eq a => [a] -> [a] -> [a] -> Bool -> [[a]]
replace a b arr end
  | length arr >= length a = fst lastElement : (if end && snd lastElement then [drop (length a) arr] else (replace a b (if snd lastElement then drop (length a) arr else tail arr) end))
  | otherwise = [arr]
  where
    check arr
      | arr == a = (b, True)
      | otherwise = ([head arr], False)
    lastElement = check (take (length a) arr)