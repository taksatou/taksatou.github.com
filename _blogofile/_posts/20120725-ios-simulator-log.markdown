---
categories: ios
date: 2012/07/25 20:30:00
title: xcodeのiosエミュレータのコンソールログはsystem.logに吐かれる
image: /images/ios-logo.png
---

![ios](/images/ios-logo.png)


タイトルの通りです。

iosエミュレータで標準出力に書いたものはsystem.logに吐かれます。

ちなみに最近のxcodeのiosプロジェクトは以下のようなコマンドでシンタックスチェックができます。

$$code(lang=bash)
$ clang -Wall -Wextra -Wno-unused-parameter -fsyntax-only  -miphoneos-version-min=4.3 -xobjective-c -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator5.1.sdk *.m
$$/code


参考：　[http://sakito.jp/emacs/emacsobjectivec.html](http://sakito.jp/emacs/emacsobjectivec.html)




