---
categories: memo, haskell
date: 2011/11/06 20:32:51
title: cabal installでこけたときのメモ
image: /images/haskell_logo.png
draft: True
---

![haskell](/images/haskell_logo.png)

cabal install -v hlint

とかしたときに失敗することがある

$$code(lang=haskell)
--中略
No uhc found
Creating dist/build (and its parents)
Creating dist/build/autogen (and its parents)
Preprocessing library uniplate-1.6.5...
Building uniplate-1.6.5...
Building library...
Creating dist/build (and its parents)
/usr/bin/ghc --make -package-name uniplate-1.6.5 -hide-all-packages -fbuilding-cabal-package -i -idist/build -i. -idist/build/autogen -Idist/build/autogen -Idist/build -optP-include -optPdist/build/autogen/cabal_macros.h -odir dist/build -hidir dist/build -stubdir dist/build -package-id base-4.3.1.0-167743fc0dd86f7f2a24843a933b9dce -package-id containers-0.4.0.0-18deac99a132f04751d862b77aab136e -package-id syb-0.3-8db7bc4339a1cb8a6f2a46c40447ef0b -O -XHaskell98 -XCPP Data.Generics.Str Data.Generics.Compos Data.Generics.SYB Data.Generics.Uniplate.Data Data.Generics.Uniplate.Data.Instances Data.Generics.Uniplate.DataOnly Data.Generics.Uniplate.Direct Data.Generics.Uniplate.Operations Data.Generics.Uniplate.Typeable Data.Generics.Uniplate.Zipper Data.Generics.Uniplate Data.Generics.UniplateOn Data.Generics.UniplateStr Data.Generics.UniplateStrOn Data.Generics.Biplate Data.Generics.PlateDirect Data.Generics.PlateTypeable Data.Generics.PlateData Data.Generics.PlateInternal Data.Generics.Uniplate.Internal.Data Data.Generics.Uniplate.Internal.DataOnlyOperations Data.Generics.Uniplate.Internal.Utils
<command line>: cannot satisfy -package-id syb-0.3-8db7bc4339a1cb8a6f2a46c40447ef0b
    (use -v for more information)
World file is already up to date.
cabal: Error: some packages failed to install:
hlint-1.8.18 depends on uniplate-1.6.5 which failed to install.
uniplate-1.6.5 failed during the building phase. The exception was:
ExitFailure 1
$$/code

そういうときは以下のコマンドでなおるときがある

$$code(lang=bash)
ghc-pkg check
ghc-pkg update
ghc-pkg recache
$$/code

- [http://haskell.1045720.n5.nabble.com/Dynamic-loading-of-module-td4737439.html](http://haskell.1045720.n5.nabble.com/Dynamic-loading-of-module-td4737439.html)

