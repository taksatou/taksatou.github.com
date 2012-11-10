---
categories: common lisp, algorithms
date: 2012/11/10 20:30:00
title: cl-frontcodeをつくってみた
image: /images/lisplogo_flag2_256.png
---

![lisp](/images/lisplogo_flag2_256.png)

[先週くらい](http://mojavy.com/blog/2012/10/31/quick-links/)に読んだWEB+DB PRESS Vol.42 に載っていた[Front Coding](http://en.wikipedia.org/wiki/Incremental_encoding) という圧縮アルゴリズムを実装してみました。

[http://d.hatena.ne.jp/naoya/20080914/1221382329](http://d.hatena.ne.jp/naoya/20080914/1221382329) のパクりです。

ソースは[https://github.com/taksatou/cl-frontcoding](https://github.com/taksatou/cl-frontcoding)です。

学習目的でつくったので実用的なライブラリではないですが、CLOSやマクロを使いつつパッケージ作成〜テストまで一通りやりました。

CLOSもマクロも基本的な使い方をするだけなら意外と簡単でした。

CLOSとかマクロは本を読んでもいまいちよくわからない上に、深淵なイメージが膨らんで心理的ハードルがあがってしまうだけなので、よくわからないなりになにか作ってみると理解が進んでいいと思います。

