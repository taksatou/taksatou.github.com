---
categories: common lisp, ruby
date: 2013/2/19 20:30:00
title: Rainbow for Common Lisp 作りました
image: /images/cl-rainbow-demo.png
---

![lisp](/images/cl-rainbow-demo.png)

[昨日](http://mojavy.com/blog/2013/02/18/ltsv-for-common-lisp/)のテンプレを流用して今日はcl-rainbowという地味なライブラリの宣伝をします。

[https://github.com/taksatou/cl-rainbow](https://github.com/taksatou/cl-rainbow)

cl-rainbowとは、[rubygemにあるrainbow](https://github.com/sickill/rainbow)をCommon Lispに移植したものです。
これを使うとターミナルの出力を簡単に色付けできます。

### インストール

現在(2013-02-19) quicklisp登録申請中です。登録されれば以下でインストールできます。

$$code
(ql:quickload 'cl-rainbow)
$$/code

### 使い方

以下のように使います。

$$code
(setf cl-rainbow:*enabled* t)
(print (cl-rainbow:color :red "red string"))
(print (cl-rainbow:color #x5599ff "rgb color code"))
(loop for c across "RAINBOW" do (format t "~A" (cl-rainbow:color (random #xffffff) c)))
$$/code

特に解説は不要だと思いますが、端末はカラー表示に対応している必要があります。

RGBのカラーコード指定すると、256色にダウンサンプルして一番近い色を表示します。

その他、例にはのせてませんが、端末が対応していれば斜体や太字にもできます。詳細はソースを見てください。

### まとめ

ログ出力のときとかにちょっと便利なときがあるかもしれません。

リードマクロで文字列リテラルをごにょごにょして色付けできるようにするともうちょっと便利になるような気がするので、そのうちチャレンジしてみたいと思います。

フィードバック等ありましたらコメント頂けるとうれしいです。
