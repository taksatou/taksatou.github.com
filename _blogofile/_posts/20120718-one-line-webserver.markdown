---
categories: ruby, python, web
date: 2012/07/18 12:30:00
title: ワンライナーでウェブサーバを起動する方法
image: /images/ruby-logo.png
---

![ruby](/images/ruby-logo.png)

とりあえずウェブサーバがたちあがりさえすればいいときは、pythonのSimpleHTTPServerを使うのが便利です。
起動したカレントディレクトリ以下のファイルをブラウズできるので、テスト用のスタティックなスタブデータを一時的に配置したいときとかにも使えます。最近の一般的なlinuxディストリビューションであればデフォルトではいってるpythonで使えると思います。

$$code(lang=bash)
$ python -mSimpleHTTPServer 3333
$$/code


デフォルトポートは8000ですが、引数で指定することもできます。

ちなみにrubyでもwebrickを使って同様のことができますが、[こちら](http://d.hatena.ne.jp/rx7/20090812/p1) で紹介されているwebrickのワンライナーは長すぎて覚えられないのでいつもpythonを使ってます。

<br>

リクエストに応じたロジックを入れたい場合はrubyのsinatraの方が便利です。

$$code(lang=bash)
$ ruby -rsinatra -e 'get("/"){sleep 3}'
$$/code


ポートを変更する場合は以下のようにします

$$code(lang=bash)
$ ruby -rsinatra -e 'set :port,3333; get("/"){sleep 3}'
$$/code



## 参考

* [コマンド1つで今すぐWebサーバを起動させるためのワンライナー(Ruby or Python)](http://d.hatena.ne.jp/rx7/20090812/p1)
