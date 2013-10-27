---
categories: hadoop
gdate: 
title: 
image: /images/raspberry-pi-150.png
draft: True
---

### Hadoop Distributed File System: HDFS

http://hadoop.apache.org/docs/r1.0.4/hdfs_user_guide.html

スケーラブルで高い耐障害性を目指して設計された分散ファイルシステム。巨大なデータを高スループットで処理することに最適化されている。
Hadoopの標準ストレージレイヤ。


### Hadoop MapReduce

http://hadoop.apache.org/docs/r1.0.4/mapred_tutorial.html

分散処理を実行するためのフレームワーク。計算モデルの名前がそのままコンポーネントの名前になっていたが、バージョン2.0系ではYARNと呼ぶようになった。詳細は以下リンクを参考。


http://www.cloudera.co.jp/blog/mr2-and-yarn-briefly-explained.html

http://www.publickey1.jp/blog/12/hadoop_3.html


### Hive: 

http://hive.apache.org/

HiveQLというSQLライクな独自言語をつかってHadoop上でジョブを実行するためのもの。
Facebookで開発された。

### Pig

http://pig.apache.org/

Pig Latinという独自言語をつかってHadoop上でジョブを実行するためのもの。
Yahooで開発された。

[^1] 

[^1]: PigとHiveでできることはほぼ同じ。実行速度はHiveの方がちょっと速い場合が多い。導入するのはPigの方が簡単。

### HBase

http://hbase.apache.org/

Hadoopの上に構築された(non-relationalな)行指向の分散データベース。ランダム読み書きを低レイテンシで処理することが可能。

[^2] 

[^2]: HDFS単体ではランダム読み書きはできない


### Flume

http://flume.apache.org/FlumeUserGuide.html

Flume: Flume is a framework for populating Hadoop with data. Agents are populated throughout ones IT infrastructure – inside web servers, application servers and mobile devices, for example – to collect data and integrate it into Hadoop.


### Scribe

xxx



Oozie: Oozie is a workflow processing system that lets users define a series of jobs written in multiple languages – such as Map Reduce, Pig and Hive -- then intelligently link them to one another. Oozie allows users to specify, for example, that a particular query is only to be initiated after specified previous jobs on which it relies for data are completed.


Ambari: Ambari is a web-based set of tools for deploying, administering and monitoring Apache Hadoop clusters. It's development is being led by engineers from Hortonworoks, which include Ambari in its Hortonworks Data Platform.


Avro: Avro is a data serialization system that allows for encoding the schema of Hadoop files. It is adept at parsing data and performing removed procedure calls.


Mahout: Mahout is a data mining library. It takes the most popular data mining algorithms for performing clustering, regression testing and statistical modeling and implements them using the Map Reduce model.


Sqoop: Sqoop is a connectivity tool for moving data from non-Hadoop data stores – such as relational databases and data warehouses – into Hadoop. It allows users to specify the target location inside of Hadoop and instruct Sqoop to move data from Oracle, Teradata or other relational databases to the target.


HCatalog: HCatalog is a centralized metadata management and sharing service for Apache Hadoop. It allows for a unified view of all data in Hadoop clusters and allows diverse tools, including Pig and Hive, to process any data elements without needing to know physically where in the cluster the data is stored.


BigTop: BigTop is an effort to create a more formal process or framework for packaging and interoperability testing of Hadoop's sub-projects and related components with the goal improving the Hadoop platform as a whole.

