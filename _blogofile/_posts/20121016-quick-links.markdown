---
categories: quicklinks
date: 2012/10/16 2:30:00
title: Quick links
image: /images/link-icon.png
---

![link](/images/link-icon.png)

[http://glinden.blogspot.jp/2012/06/quick-links.html](http://glinden.blogspot.jp/2012/06/quick-links.html) のまねをして、ネタのメモがてら最近興味を引いたものなどを列挙してみる。


#### [ØMQ](http://www.zeromq.org/)

[http://www.zeromq.org/](http://www.zeromq.org/)

久しぶりにチェックしてみたらドキュメントやライブラリが充実してきてた。エラーハンドリングがちょっとやりづらいという噂もあるけど柔軟に使えて便利らしい。

#### [ArangoDB](http://www.arangodb.org/)

[http://www.arangodb.org/](http://www.arangodb.org/)

MongoDBと似たような方向性のNoSQL。パフォーマンスはMongoDBと大差ないみたい。ただ、MongoDBのようにデータサイズが肥大化することはないらしい。

* [http://www.arangodb.org/2012/09/04/bulk-inserts-mongodb-couchdb-arangodb](http://www.arangodb.org/2012/09/04/bulk-inserts-mongodb-couchdb-arangodb)
* [http://www.arangodb.org/2012/07/08/collection-disk-usage-arangodb](http://www.arangodb.org/2012/07/08/collection-disk-usage-arangodb)

#### [Apache Hama](http://hama.apache.org/)

[http://hama.apache.org/](http://hama.apache.org/)

後日詳細調査

* [Large-scale graph computing at Google](http://googleresearch.blogspot.jp/2009/06/large-scale-graph-computing-at-google.html)
* [Apache Giraph](http://incubator.apache.org/giraph/)
* [Golden Orb](http://goldenorbos.org/)
* [Signal Collect](http://code.google.com/p/signal-collect/)
* [Spark](http://www.spark-project.org/)
* [MapReduce以外の分散処理基盤BSP, Piccolo, Sparkの紹介](http://research.preferred.jp/2011/06/bsp_piccolo_spark_introduction/)

#### [Google Common Lisp Style Guide](https://google-styleguide.googlecode.com/svn/trunk/lispguide.xml)

[https://google-styleguide.googlecode.com/svn/trunk/lispguide.xml](https://google-styleguide.googlecode.com/svn/trunk/lispguide.xml)

Googleのコーディング規約は厳しいという話はよくきくが、Common Lispの規約も結構細かく書かれてる。GoogleでCommon Lispはどのくらいつかわれているのだろうか。

#### [Kube](http://imperavi.com/kube/)

[http://imperavi.com/kube/](http://imperavi.com/kube/)

シンプルなCSSフレームワーク。[bootstrap](http://twitter.github.com/bootstrap/)とか[Zurb](http://foundation.zurb.com/)とかもあるけど、あんまり凝ったことしないならこれくらいで十分。というかこれ以上は無理。


#### [Trading Systems Coding](http://www.investopedia.com/university/systemcoding)

[http://www.investopedia.com/university/systemcoding](http://www.investopedia.com/university/systemcoding)

このチュートリアル自体はあんまり役に立ちそうもないけどとっかかりとしてはいいかも？

#### [東京の地下鉄をGviz（Ruby Graphviz Wrapper）で描く](http://melborne.github.com/2012/10/02/draw-metro-map-with-gviz/)

[http://melborne.github.com/2012/10/02/draw-metro-map-with-gviz/](http://melborne.github.com/2012/10/02/draw-metro-map-with-gviz/)

素のdot言語を手でかくとぐちゃぐちゃになりがちなのでGviz使うとよさそうです。とはいえ、こんなにきれいな路線図を書くのはかなり大変だったのではなかろうか。

#### [Ubuntu12.04LTSのUnityを手なずける](http://d.hatena.ne.jp/ka8823ge/20120515)

[http://d.hatena.ne.jp/ka8823ge/20120515](http://d.hatena.ne.jp/ka8823ge/20120515)

メインでつかってるUbuntuを10.04LTSから12.04LTSにアップデートしたところ、案の定いくつかこわれてしまった。
Unityまわりの調整は↑を参考にした。以下はその他の問題と実施した対応のメモ。サウンドデバイスは相変わらずまともに動かない。


##### virtual boxが起動しなくなった

virtual boxを最新版にアップデートしてPCを再起動した。

##### vmware playerが起動しなくなった

Xのショートカットアイコンからは起動できなくなってしまったが、なぜかコマンドラインからvmplayerを起動すると大丈夫だった。

##### okularがsamba上のファイルをコマンドラインから起動できなくなった

なぜかnautilusからだと開くことができた。以前は逆にsambaをマウントしたディレクトリ上ではnautilusがつかえなかったがそこは直ったらしい。
