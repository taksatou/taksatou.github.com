---
categories: ruby, mustache
date: 2013/10/01 00:08:09
title: mustache基礎文法最速マスター
---

mustacheはシンプルなテンプレートエンジンなので本家の英語マニュアル [mustache(5)](http://mustache.github.io/mustache.5.html ) を見ても大したことはないですが、日本語情報の需要もそれなりにあると思うのでまとめておきます。

以下の内容はrubygemの`mustache-0.99.4`で確認しています。
他の言語の場合は適宜置きかえてください。

## 目次

[TOC]


## 変数の展開

`{{name}}`のように2つのブレースで囲ったタグは、`name`という名前のキーの値でおきかえられます。

対応するキーが見つからなかった場合はデフォルトでは空文字になります。


$$code(lang=ruby)
Mustache.render("Hello, {{world}}!", world: "mustache") # => "Hello, mustache!"
Mustache.render("{{no_such_key}}") # => ""
$$/code

## 変数のエスケープ

デフォルトではHTMLエスケープが有効になjります。アンエスケープされたHTMLが使いたい場合は`{{{name}}}`のように3つのブレースで囲います。

$$code(lang=ruby)
Mustache.render("{{html}}",  html: "<b>GitHub</b>") # => "&lt;b&gt;GitHub&lt;/b&gt;"
Mustache.render("{{{html}}}", html: "<b>GitHub</b>") # => "<b>GitHub</b>"
$$/code

## 条件分岐

`{{#name}} ... {{/name}}`のように、2つのタグに`#`と`/`をそれぞれつけたタグで囲われたブロックはセクションといいます。

セクションのキーに対応する値にbool値を渡せばif文のような使い方ができます。
`#`のかわりに`^`をつかうと真偽を反転できます。


$$code(lang=ruby)
template = <<DOC
{{#condition}}
It is true.
{{/condition}}
{{^condition}}
No not true.
{{/condition}}
DOC
Mustache.render(template, condition: true) # => "It is true.\n"
Mustache.render(template, condition: false) # => "No not true.\n"
$$/code

## ループ

セクションのキーに対応する値に配列を渡した場合は、それぞれの要素を引数として中のブロックが繰り返し評価されます。

$$code(lang=ruby)
template = <<DOC
{{#animals}}
{{name}}
{{/animals}}
DOC
data = {animals: [{name: "cat"}, {name: "dog"}, {name: pig"}]}
Mustache.render(template, data) # => "cat\ndog\npig\n"
$$/code

## 無名関数 (Lambda)

セクションのキーに対応する値に呼び出し可能なオブジェクトを渡した場合は、そのブロック内のテキストを引数として実行され、その返り値が結果として出力されます。

$$code(lang=ruby)
template = <<DOC
{{#proc}}
mojavy is bad
{{/proc}}
DOC
Mustache.render(template, proc: ->text{text.gsub(/bad/, 'nice')}) # => "mojavy is nice\n"
$$/code

## コメント

`!`をつけるとコメントになります

$$code(lang=ruby)
Mustache.render("Comment here: {{! ignore me }}") # => "Comment here: "
$$/code

## まとめ

mustacheの基本的な機能について簡単なサンプルコードとともに解説しました。
ここではrubyのmustacheを使用しましたが、他の言語でも同様の機能が使えます。
一部の機能については省略しているので、より詳細な情報については本家ドキュメントを参照してください。


