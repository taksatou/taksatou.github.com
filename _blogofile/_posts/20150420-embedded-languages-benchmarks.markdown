---
categories: programming, lua, v8, ruby, lisp
date: 2015/04/21 01:10:40
title: 組み込み用プログラミング言語のパフォーマンス比較
image: /images/embed-close.png
---

組み込み用のプログラミング言語といえばLuaがよく使われるけど、最近はmrubyやsquirrelもあって選択肢が広がってきた感があるのでどういう特徴があるのかを知るためにベンチマークをやってみた。

今回対象にしたのは以下。

* Lua - v5.1
* LuaJIT - v2.0.2
* squirrel - v3.0.7
* V8 - v3.30
* mruby - v1.1.0
* ecl (Embeddable Common-Lisp) - v15.3.7

ここでのベンチマークは言語自体のスピードの比較ではなく、どちらかというと組み込む際に必要なオーバーヘッドやホスト言語側での処理にかかる部分に重点を置いた。

ベンチマークの処理には、関数呼出し比較用の`echo`関数と、テーブル操作比較用の`invert`関数をつかった。


また、なるべく公平になるように、組み込み言語側の関数は初期化時にグローバルスコープ(組み込み言語側のグローバルスコープ)に登録しておき、すべて同じインターフェースから呼ぶようにした。

使用したコードは以下。そのうち別の言語とか追加するかもしれない。

[https://github.com/taksatou/embench](https://github.com/taksatou/embench ) 


## 結果

#### echo 100000 回実行

![echo](/images/embench-echo-100000.png ) 


#### invert 100000 回実行

![invert](/images/embench-invert-100000.png ) 


[https://gist.github.com/taksatou/8de85bbfe79548864cf5#file-result-md](https://gist.github.com/taksatou/8de85bbfe79548864cf5#file-result-md ) 


#### 備考

* control は同等の処理をホスト言語側で実装したもの
* LuaJITは`LD_PRELOAD`で切り替えた
* eclはechoが遅くてやるきを失ったのでinvertのほうは省略


## 所感

* Luaがパフォーマンスと組み込みやすさの点でやはり一番使いやすい。LuaJITをつかうとさらに数割速くなる。
* squirrelは言語機能的にはluaのスーパーセットという感じで、パフォーマンスもluaと同じ程度。ただしドキュメントはあまりない。
* V8はマルチスレッド環境や大規模なものには向いてるかもしれない。組み込みはちょっとめんどくさい。
* mrubyはechoだと意外と健闘しているがテーブル操作は速くない。組み込みはLuaと同じくらい簡単。
* eclにはもうちょっとがんばってほしい。組み込み方法に問題があるのかもしれない。

