cd src/compiler
bash ./build.sh >/dev/null 2>&1
cd ../..
mkdir -p program
mkdir -p program/lib
cp src/nam-logic/app/Main.hs program/lib/Main.hs
cp src/nam-logic/src/Lib.hs program/lib/Lib.hs
cp src/compiler/build/main program/main