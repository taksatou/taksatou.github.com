---
categories: unix, osx, mach-o, elf
date: 2013/05/17 19:46:31
title: Mach-Oバイナリのライブラリロードパスをカスタマイズする方法
image: /images/matrix3.png
---

![matrix](/images/matrix3.png)

ライブラリの単体テストをするときとかに、実行プログラムがロードする共有ライブラリのパスを任意のディレクトリで上書きしたいときがある。

例えば以下のようなディレクトリ構成で、`project/t/mytest`というバイナリをビルドするときに`project/src/libmy.so`をリンクするようにしておけば作業しやすい。

$$code
└── project
    ├── src
    │   ├── libmy.a
    │   ├── libmy.so -> libmy.so.1
    │   ├── libmy.so.1
    │   ├── Makefile
    │   ├── mylib.c
    │   ├── mylib.h
    │   └── mylib.o
    └── t
        ├── Makefile
        ├── mytest
        ├── mytest.c
        └── mytest.o
$$/code

こういうときは、`mytest`をビルドするときに以下のようにしてrpathを相対パスで追加していた。

$$code
$ cc -I../src -L../src -Wl,-rpath=../src *.c -lmy -o mytest
$ readelf -d mytest
Dynamic section at offset 0xe30 contains 22 entries:
  Tag        Type                         Name/Value
 0x0000000000000001 (NEEDED)             Shared library: [libmy.so.1]
 0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
 0x000000000000000f (RPATH)              Library rpath: [../src]
 0x000000000000000c (INIT)               0x4004c8
 0x000000000000000d (FINI)               0x4006f8
 0x000000006ffffef5 (GNU_HASH)           0x400298
 0x0000000000000005 (STRTAB)             0x4003c0
 0x0000000000000006 (SYMTAB)             0x4002d0
 0x000000000000000a (STRSZ)              134 (bytes)
 0x000000000000000b (SYMENT)             24 (bytes)
 0x0000000000000015 (DEBUG)              0x0
 0x0000000000000003 (PLTGOT)             0x600fe8
 0x0000000000000002 (PLTRELSZ)           48 (bytes)
 0x0000000000000014 (PLTREL)             RELA
 0x0000000000000017 (JMPREL)             0x400498
 0x0000000000000007 (RELA)               0x400480
 0x0000000000000008 (RELASZ)             24 (bytes)
 0x0000000000000009 (RELAENT)            24 (bytes)
 0x000000006ffffffe (VERNEED)            0x400460
 0x000000006fffffff (VERNEEDNUM)         1
 0x000000006ffffff0 (VERSYM)             0x400446
 0x0000000000000000 (NULL)               0x0
$$/code


しかし、OSXの場合は上記のように単に実行バイナリ側にrpathを追加しただけだと、ローダがrpathを設定するコマンドより先にライブラリをロードするコマンドを実行しようとして該当ファイルがみつけられなくて以下のようなエラーになってしまう.
$$code
dyld: Library not loaded: libmy.1.dylib
  Referenced from: /Users/path/to/project/t/./mytest
  Reason: image not found
zsh: trace trap  ./mytest
$$/code

`otool -l <executable file>`でロードコマンドの詳細をみると以下のようなエントリがみつかるが、ここのnameの値はライブラリ側の`install_path`が設定される。

$$code
-- 中略
Load command 11
          cmd LC_LOAD_DYLIB
      cmdsize 40
         name libmy.1.dylib (offset 24)
   time stamp 2 Thu Jan  1 09:00:02 1970
      current version 1.0.0
compatibility version 0.0.0
$$/code


`install_path`は`soname`のかわりのようなもので、なにも指定しなければ出力ファイル名になる。
ここに`@executable_path`や`@rpath`をつかうことによって、このダイナミックライブラリをリンクする側のバイナリに応じて挙動をかえることができる。
これらの変数(?)の詳細は参考リンクに解説がある。


要は、ELFのrpathとおなじような挙動にしたければ、 `-Wl,-install_name,@rpath/libmy.1.dylib` というようなオプション付きでライブラリをビルドすればよい。

また、`-Wl,-install_name,@executable_path/../src/libmy.1.dylib`のようにすると実行ファイルからの相対パスにすることができる。

この情報はリンクされる側のライブラリに埋めこまれている点に注意。

ELFに比べると柔軟にロードパスを制御することができると思われるが、うまく活用するのはちょっと難しそう。


#### 参考リンク

* [@executable_path, @load_path and @rpath ](https://wincent.com/wiki/@executable_path,_@load_path_and_@rpath ) 
* [DynamicLibraryDesignGuidelines](https://developer.apple.com/library/mac/#documentation/DeveloperTools/Conceptual/DynamicLibraries/100-Articles/DynamicLibraryDesignGuidelines.html ) 

