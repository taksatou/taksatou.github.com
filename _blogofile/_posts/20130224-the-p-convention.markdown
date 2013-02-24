---
categories: lisp, programming
date: 2013/02/24 14:42:00
title: The P Convention
image: /images/lisplogo_fancy_128.png
---

![lisp](/images/lisplogo_fancy_128.png)

Lispには'p'という接尾辞がつく名前の関数があるが、この'p'はpredicateのこと。

[The -P Convention](http://catb.org/jargon/html/p-convention.html)

ところが、HaskellやOCamlにも'p'という接尾辞がつく関数があって、そちらはprimeの意味で使うらしい。
シングルクオート(ダッシュ)記号は英語だとprimeというので、例えば`foo'`という名前の関数は`foo`という名前のヘルパー関数的なもの、ということになる。

[“foop”: a naming convention? It's a helper recursive function for “foo”; what does the suffix “p” mean?](http://stackoverflow.com/questions/5279286/foop-a-naming-convention-its-a-helper-recursive-function-for-foo-what-do)

ちなみに、OCamlだとシングルクオートが識別子につかえるのでfoo'という名前の関数も結構あるらしい。


まぎらわしい、かと思ったけど使う文脈が違うし意外とそうでもないか。
