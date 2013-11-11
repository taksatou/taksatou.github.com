---
categories: statistics, bayse
date: 2013/11/11 23:04:10
title: ベイズの定理から見るガン検査
filter: latex, syntax_highlight, markdown
---

http://www.huffingtonpost.jp/2013/11/10/cancer-test_n_4252707.html

15歳ですい臓がん発見の画期的方法を開発したという記事が話題になってますが、ベイズの定理をつかって実際にこれが統計的にどういう意味をもつのか実際に計算してみました。

まず、仮に以下のような問題を考えてみます。

あるガン検査法では、被験者がガンの場合は0.95の確率で陽性になり、被験者がガンでなければ0.95の確率で陰性になります。被験者がガン患者である確率が0.005のとき、ガン患者が検査の結果実際に陽性だと判定される確率を求めなさい。


計算してみるとわかりますが、これは予想に反して驚くほど小さな値となります。

以下計算式


2008年のデータでは10万人あたり23.2なので、 [^2] 

[^2]: http://ganjoho.jp/professional/statistics/statistics.html

国立がん研究センターがん対策情報センター
Center for Cancer Control and Information Services, 
National Cancer Center, Japan



ちなみにこれは以下の教科書の練習問題を参考にしたものです

<a href="http://www.amazon.co.jp/gp/product/4130420658/ref=as_li_ss_il?ie=UTF8&camp=247&creative=7399&creativeASIN=4130420658&linkCode=as2&tag=armyofpigs-22"><img border="0" src="http://ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=4130420658&Format=_SL160_&ID=AsinImage&MarketPlace=JP&ServiceVersion=20070822&WS=1&tag=armyofpigs-22" ></a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=armyofpigs-22&l=as2&o=9&a=4130420658" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />

この教科書の4章の練習問題(4.7)に以下のような問題があります。


ガンを診断するための検査法(たとえば、腫瘍マーカー)があるとしよう。Cを被検査者はガンであるという事象、Aを検査の結果が被検査者はガンであると示す(すなわち、検査結果が陽性となる)事象とする。 $$latex P(A|C) = 0.95, P(A^C|C^C) = 0.95 $ であれば、検査結果は一応信頼できるものといえよう。検査を浮ける人の中で、実際にガンの確率が $$latex P(C) = 0.005 $ のとき、$$latex P(C|A) $ を求めよ。(数字は仮のものである) [^1] 

[^1]: なお、P(A|C) はCが起こったときにAが起こる確率(条件付き確率)、$$latex A^C $ はAが起こらないという事象(補事象)を表します。
