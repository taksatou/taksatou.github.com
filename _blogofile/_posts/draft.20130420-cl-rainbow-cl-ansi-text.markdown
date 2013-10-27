---
categories: common lisp
date: 2013/04/20 10:39:13
title: cl-rainbowがcl-ansi-textにマージされました
image: /images/lisp-alien-logo.png
draft: True
---

![lisp](/images/lisp-alien-logo.png)


ちょっと前に[cl-rainbow](http://mojavy.com/blog/2013/02/19/rainbow-for-common-lisp/ ) というcommon lispのライブラリをつくってquicklispに登録申請したところ [cl-ansi-text](https://github.com/pnathan/cl-ansi-text ) という類似ライブラリの作者から一緒にまとめて1つのライブラリにしないかという提案をいただきました。[^1] 

cl-ansi-textはcl-rainbowはやろうとしていることは同じですが、それぞれお互いに無い機能が実装されていました。
特にこだわりもなかったのでcl-rainbowをcl-ansi-textにとりこんでもらうことにしました。

とりこんでもらった機能は、RGBのカラーコードをダウンサンプルして256色のターミナルで表示できるエスケープシーケンスをはくようにするところ。その他の部分はcl-ansi-textのAPIにあわせました。

使い方は以下のとおり

$$code(lang=lisp)
(-ansi-text:with-color (#x556b2f) (format t "darkolivegreen"))
$$/code

単にエスケープシーケンスで囲った文字列を返すだけのcl-rainbowのAPIも残してもらえばよかったような気もしますが、必要になったらpull requestしたいと思います。


[^1]: 経緯は[https://github.com/taksatou/cl-rainbow/issues/1](https://github.com/taksatou/cl-rainbow/issues/1 ) にあります
