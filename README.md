# NAM(Markov's Normal Algorithm) files compiler to executable

Generated nam programs, which input is word s for applying NAM substitute formulas, and output is the last word which is the result of applying NAM to the original word S

## Required packages:

- clang
- ghc

## Usage:

```
bash setup.sh                 #build compiler
cd program                    #compiler has been created in program directory
./main path-to-nam-file       #run compilation for NAM file
./nam                         #run compiled NAM program
```

## NAM syntax

a -> b -- simple substitution

a => b -- final substitution

Example is provided in nam_example.txt
