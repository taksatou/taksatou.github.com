---
categories: elasticsearch, solr, aws, web
date: 2014/02/10 01:05:25
title: 全文検索システムの比較 - Elasticsearch vs Solr vs Amazon CloudSearch
---

Elasticsearch、Solr、及び Amazon CloudSearchの比較検討を行った。

## 目次

[TOC]

## 候補の選定方法

候補を選定するにあたって、以下の特徴をもっていることを前提とした。
LuceneやGroongaを使えば何でもできるが、ここでは対象としない。

* ウェブベースのインターフェースを持つ
* インデックスの更新はほぼリアルタイムに反映される
* スケールアウトが容易


## Solr

![solr](/images/solr-150.png ) 

[https://lucene.apache.org/solr/](https://lucene.apache.org/solr/ ) 

Luceneをバックエンドにした全文検索システム。バージョン4になってから大幅に機能が増強された。


### 長所

* 実績が十分ある
* 機能豊富

### 短所

* クラスタを構築して運用するには手間がかかりそう
* SolrCloudはzookeeperに依存するためサーバ台数もかさむ

## Elasticsearch

![Elasticsearch](/images/elasticsearch-logo.png ) 

[http://www.elasticsearch.org/](http://www.elasticsearch.org/ ) 

Solrと同じくLuceneをバックエンドにした全文検索システム。開発者の言[^1]によると、Solrより洗練された分散モデルで[^2] 、使いやすいAPIを備えている。 


### 長所

* アーキテクチャやUIが今風
* クラスタの構築が簡単
* KibanaやLogstashと連携できる
* Percolate APIというpush通知のような機能を簡単に実装するためのものがある

### 短所

* 後発な分ノウハウの蓄積にやや不安が残る
* 未実装機能がいくらかある(あった。現時点(2014-02-09)では機能的にはほぼ追いついているように見える  [http://solr-vs-elasticsearch.com/](http://solr-vs-elasticsearch.com/ )  )


## Amazon CloudSearch

![amazon](/images/aws-logo-s.png ) 

[http://aws.amazon.com/jp/cloudsearch/](http://aws.amazon.com/jp/cloudsearch/ ) 

AWS上で提供されている全文検索システム。EC2と同じく時間とトラフィックで課金される。現時点ではまだベータ。


### 長所

* 自動的にスケーリングしてくれる(エントリ数、リクエスト数に応じてインスタンスが自動的に増える)
* pdfやdocをそのまま送るだけでも適当にうまくやってくれる
* DynamoDBのデータをそのまま流してインデックスできる

### 短所

* 現状では東京リージョンがない
* テキスト解析のカスタマイズが限定的。現状、Stemming, Stopwords, Synonymsのみカスタム可能。
* N-gramとか形態素解析は自前で処理してからアップロードする必要がある
* ヒット位置を取る方法がない
* テキスト本文をインデックスと一緒に格納することはできない


## 比較項目別のまとめ

### 拡張性

SolrもElasticsearchもLuceneをバックエンドにしているので、Luceneでできることは基本的にはどちらでもできるはず。
Amazonは現状ではあまり拡張性はない。

### 性能

基本性能はSolrもElasticsearchも大差はなさそう。
Amazonは自動的にノードが追加されるので性能の問題はなさそう。ただし、ノードが自動追加されるタイミングとその時の挙動は未確認。

### 安定性

数年先行している分Solrがよいと思われるが、Elasticsearchも既に十分本番稼動実績はある。
Amazonはベータなので未知数。

### リアルタイムデータ更新

いずれもほぼリアルタイムに更新できる。

### 日本語対応

SolrとElasticsearchはほぼ同等。kuromojiやmecabをつかえば形態素解析もできる。
Amazonはそれ自体では対応していないが、Luceneのtokenizer等を使って自前で前処理することで対応は可能。

### スケーラビリティ

Amazonは完全に自動的にスケールアウトしてくれる。
Elasticsearchはインデックスのシャード数を作成時に決めておく必要があるが、スケールアウトは容易だと思われる。
Solrはv4からはElasticsearchと大体同等のスケーラビリティを備えるようになった。


## 参考リンクまとめ

* [http://stackoverflow.com/questions/10213009/solr-vs-elasticsearch](http://stackoverflow.com/questions/10213009/solr-vs-elasticsearch ) 
* [http://stackoverflow.com/questions/2271600/elasticsearch-sphinx-lucene-solr-xapian-which-fits-for-which-usage](http://stackoverflow.com/questions/2271600/elasticsearch-sphinx-lucene-solr-xapian-which-fits-for-which-usage ) 
* [http://blog.kakipo.com/trouble-with-fluentd-and-elasticsearch/](http://blog.kakipo.com/trouble-with-fluentd-and-elasticsearch/ ) 
* [https://github.com/atilika/kuromoji](https://github.com/atilika/kuromoji ) 
* [http://www.elasticsearch.org/blog/percolator/](http://www.elasticsearch.org/blog/percolator/ ) 
* [http://blog.feedbin.me/2013/11/10/powering-actions-with-elasticsearch-percolate/](http://blog.feedbin.me/2013/11/10/powering-actions-with-elasticsearch-percolate/ ) 
* [http://docs.aws.amazon.com/cloudsearch/latest/developerguide/text-processing.html](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/text-processing.html ) 
* [http://blog.mikemccandless.com/2011/06/lucenes-near-real-time-search-is-fast.html](http://blog.mikemccandless.com/2011/06/lucenes-near-real-time-search-is-fast.html ) 
* [https://wiki.apache.org/solr/Solr4.0](https://wiki.apache.org/solr/Solr4.0 ) 
* [http://www.slideshare.net/kucrafal/battle-of-the-giants-apache-solr-vs-elasticsearch](http://www.slideshare.net/kucrafal/battle-of-the-giants-apache-solr-vs-elasticsearch ) 

## 所感

後発な分Elasticsearchが一番洗練されているように思います。
Solrは無難に導入できそうですが、スケールアウトが必要になったとき手間がかかりそうです。
Amazonはメリットも多いですが、現状では制限が多いので使いづらいと思います。


**追記**

* 2014/02/12 23:59:13： ElasticSearch →  Elasticsearchに直しました


[^1]: [http://stackoverflow.com/questions/2271600/elasticsearch-sphinx-lucene-solr-xapian-which-fits-for-which-usage](http://stackoverflow.com/questions/2271600/elasticsearch-sphinx-lucene-solr-xapian-which-fits-for-which-usage ) 
[^2]: 昔のSolrは単純なレプリケーションとシャーディングしかなかったので、クラスタを構築するのは大変だった


