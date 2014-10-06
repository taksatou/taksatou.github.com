---
categories: adtech
date: 2014/10/06 21:05:33
title: www2014のアドテク関連のResearch Trackメモ
---

[www2014のResearch Track](http://www2014.kr/program/research-track/ ) に`Online Experiments & Advertising`というのがあったので、概要だけメモ。


## [Adscape: Harvesting and Analyzing Online Display Ads](http://dl.acm.org/citation.cfm?id=2567992)

クローラを用いて広告データを収集することによって、現状のディスプレイ広告でどのようなターゲティングが行われているのかについてを分析している。
340通りのユーザプロファイルを用いて180件のウェブサイトをクロールし、17万5000件の広告を収集したとのこと。

プロファイルの内容によってどのカテゴリの広告が配信されやすいかとか、ウェブページあたりの広告主数の分布とか、実験結果は結構おもしろい。


## [Statistical Inference in Two-Stage Online Controlled Experiments with Treatment Selection and Validation](http://dl.acm.org/citation.cfm?id=2568028)

より進んだA/Bテストの方法について。Bingのデータを用いているが、他の分野でも適用できる。
Bonferroni法やHolm法といった従来の多重比較における補正方法より実用的なものが紹介されている。

## [An Experimental Evaluation of Bidders’ Behavior in Ad Auctions](http://dl.acm.org/citation.cfm?id=2568004)

実際に人間を使ってadwords的なオークションのゲームを行い、理論通りの挙動をするかを検証するというもの。
概ね期待通りの価格に近づくが、予想に反して平衡に逹しないという結果が得られたとのこと。
