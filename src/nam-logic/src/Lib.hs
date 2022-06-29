module Lib
  ( someFunc,
    loop,
    (-->),
    (==>),
    replace,
    increment,
  )
where

loop :: Eq a => [a] -> (([a], (Bool, Bool)) -> ([a], (Bool, Bool))) -> [a]
loop arr nam = loop' nam arr True

loop' :: Eq a => (([a], (Bool, Bool)) -> ([a], (Bool, Bool))) -> [a] -> Bool -> [a]
loop' nam arr end
  | not $ fst . snd $ result = fst result
  | otherwise = if fst result == arr then arr else loop' nam (fst result) $ True
  where
    result = nam (arr, (end, True))

(-->) :: Eq a => [a] -> [a] -> ([a], (Bool, Bool)) -> ([a], (Bool, Bool))
(-->) a b arr
  | (snd . snd $ arr) && (fst . snd $ arr) && (fst arr /= result) = (result, (True, False))
  | otherwise = arr
  where
    result = concat $ replace a b (fst arr) True

(==>) :: Eq a => [a] -> [a] -> ([a], (Bool, Bool)) -> ([a], (Bool, Bool))
(==>) a b arr
  | (snd . snd $ arr) && (fst . snd $ arr) && (fst arr /= result) = (result, (False, False))
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

increment :: [Char] -> [Char]
increment arr =
  loop
    arr
    ( ("" --> "*")
        . ("/" ==> "1")
        . ("0/" ==> "1")
        . ("1/" --> "/0")
        . ("1*" --> "/0")
        . ("0*" ==> "1")
        . ("*1" --> "1*")
        . ("*0" --> "0*")
    )

someFunc :: IO ()
someFunc =
  getLine
    >>= ( putStrLn
            . ( `loop`
                  ( ("" --> "*")
                      . ("/" ==> "1")
                      . ("0/" ==> "1")
                      . ("1/" --> "/0")
                      . ("1*" --> "/0")
                      . ("0*" ==> "1")
                      . ("*1" --> "1*")
                      . ("*0" --> "0*")
                  )
              )
        )
