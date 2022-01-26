import Lib
main =
  getLine
    >>= (putStrLn.('loop'
      (
        ("/" ==> "1")
