---
categories: linux
date: 2014/02/10 12:23:41
title: 
draft: True
---

iotopをつかうとどのプロセスがioを消費しているか調べることができる。
でもiotopを使いたくなるようなときは既に負荷があがってしまっている本番環境だったりするので、
iotopなんてインストールされてないし、aptやyumを起動するのにも時間がかかってしまったりする。

もっと簡単に調べる方法はないかと思ってiotopがどうやってioを調べているか調べてみた


大まかなコールスタックは以下の通り(一部省略)

$$code()
iotop:__main__
  iotop.ui:main
    iotop.ui:run_iotop_window  # ここでNETLINK_GENERICでnetlinkにつなげる(後述)
    
    
$$/code

以下はメモ

* iotopは2000行くらいのpythonコードからなる
* topっぽいUIはcursesをつかって実装されている

http://linuxjm.sourceforge.jp/html/LDP_man-pages/man7/netlink.7.html


