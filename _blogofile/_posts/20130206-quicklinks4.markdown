---
categories: quicklinks
date: 2013/02/06 21:50:00
title: Quicklinks 4
---

[前回](http://mojavy.com/blog/2012/11/14/quicklinks3/) から2ヵ月くらいあいてしまいました。古いブックマークはブックマークしたこと自体を忘れてしまうのでもうちょいまめにまとめたいです。

#### [Q-Gears](http://q-gears.sourceforge.net/index.phtml?content=1)

FF7のゲームエンジンのクローンを目指したものだそうです。
LinuxやWindowsで動くようにクロスプラットフォームな設計になっていて、将来的にはsquareの他のゲームも動かすためのフレームワークとしても提供することも考えているようです。

* [http://q-gears.sourceforge.net/gears.pdf](http://q-gears.sourceforge.net/gears.pdf)

この資料にはシステムの概要が書かれてます。リバースエンジニアリングして集めた情報と思われますが、読み物としてもおもしろそうです。

#### [Riemann](http://riemann.io/)

Clojureで書かれたnetwork event stream processing systemとのこと。

[ここ](http://riemann.io/concepts.html)のイラストと説明を見れば大体イメージはわくと思います。
コンセプト的にはfluentdに近い気がしますが、集める対象がログではなくイベントそれ自体なので守備範囲はちょっと違うようです。
Riemann自体が落ちたときにどうなるか、とか実際に運用するとなると色々気になるところはありそうですが試してみる価値はありそうです。

設定をClojureで書けるというのもとがってていいと思います。


#### [whistlepig](https://github.com/wmorgan/whistlepig)

Cで書かれた軽量なリアルタイム全文検索のためのライブラリです。
複数プロセスでも同時にインデックスを読み書きできるようで、なかなか便利そうです。今度詳細を調べてみようと思います。

#### [Montezuma](http://code.google.com/p/montezuma/)

こっちはFerretをCommon Lispに移植したもの。ちなみにFerretはLuceneをRubyに移植したものです。
これはこれで便利だと思います。


#### [OpenRTB](http://code.google.com/p/openrtb/)

広告業界ではread-time biddingが最近のトレンドのようなので、関係者はこれを読んで理解を深めましょう。


#### [iOS Security Internals](http://365.rsaconference.com/servlet/JiveServlet/previewBody/3488-102-1-4589/MBS-402.pdf)

jailbreakやったりする人がつくった資料のようです。
これもなかなか興味深いです。


#### [UNREAL4](http://www.unrealengine.com/unreal_engine_4/)

Unity3でも十分すごいと思いましたが、最近のゲームエンジンはどれもすごいですね。

* http://www.wmtdesigners.com/wordpress/game-2012-06-19


#### [Leap Motion](https://www.leapmotion.com/)

xboxのkinect的なものですが、それよりはるかに上回る精度らしいです。プレオーダーしたので届いたら色々遊んでみます。

