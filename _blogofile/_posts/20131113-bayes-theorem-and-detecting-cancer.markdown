---
categories: statistics
date: 2013/11/12 03:01:16
title: ベイズの定理から見るガン検査
filter: latex, syntax_highlight, markdown
---

[http://www.huffingtonpost.jp/2013/11/10/cancer-test_n_4252707.html](http://www.huffingtonpost.jp/2013/11/10/cancer-test_n_4252707.html) 

高校生がすい臓がん発見の画期的方法を開発したという記事が話題になってます。[^1] 

この検査法の改善が統計的にどういう意味をもつのか実際にベイズの定理をつかって計算してみます。

ここでは以下のような問題を考えることとします。

> あるガン検査法は、被験者ががんの場合はp1の確率で陽性になり、被験者ががんでなければp2の確率で陰性になります。被験者ががん患者である確率がp3のとき、がん患者が検査の結果実際に陽性だと判定される確率を求めなさい。


Xを被検査者はガンであるという事象、Yを検査の結果が被検査者はガンであると示す事象として、それぞれ以下のように置き換えることができます。

<p>
$$latex
\\ p1 = P(X|Y)
\\ p2 = P(X^C|Y^C)
\\ p3 = P(Y)
$
</p>

<p>
ただし、
$$latex P(A|B) $ はBが起こったときにAが起こる確率(条件付き確率)、
$$latex A^C $ はAが起こらないという事象(補事象)を表します。
</p>

求めたい確率は $$latex P(Y|X) $ なので、ベイズの定理より
<p>
$$latex
P(Y|X) = \frac{\displaystyle P(Y)\cdot P(X|Y)}{\displaystyle P(X)}
$
</p>

ここで $$latex P(X) $ は検査結果が真陽性となる確率と偽陰性となる確率を足したものなので、
<p>
$$latex
P(X) = P(Y)\cdot P(X|Y) + P(Y^C)\cdot P(X|Y^C)
$
</p>

また、
<p>
$$latex 
P(X|Y^C) = 1 - P(X^C|Y^C)
$ 
</p>
なので、

<p>
$$latex
P(Y|X) 
\vspace{8} \\ = \frac{\displaystyle P(Y)\cdot P(X|Y)}{\displaystyle  P(Y)\cdot P(X|Y)+P(Y^C)\cdot (1 - P(X^C|Y^C))} 
\vspace{5} \\ = \frac{\displaystyle  p1\cdot p3}{\displaystyle  p1\cdot p3 + (1-p3)\cdot (1-p2)}
$ 
</p>

となります。


以上の結果に実際に値をあてはめてみます。

2008年のすい臓がん推定患者数は29584 [^2]、同年の人口は127692000 [^3]なので、`p3=0.23168 * 10^-3`。
また、簡単のためにp1, p2をひとまとめに誤検出の確率と仮定して`p1=p2=q`おくと、P(Y|X)が70%となるようなqは、**q=0.99990**となります。

このことから、99.99%の精度をもつ検出方法でも実際には30%も見逃してしまうということがわかります。

さらに、「400倍の精度で検査できる」という部分を誤検出の確率が400分の1になったという意味だと解釈して、
`q'=1-(1-q)/400`とおいてがん患者が検査の結果実際に陽性だと判定される確率を再度計算すると**P(Y|X)=0.99892**となります。

つまり30%見逃していたのが1%程度まで減ったということです。
これはすばらしい成果といえるのではないでしょうか。

最初は30%も見逃すとかどんなひどい検査だったんだ、などと思ってしまうかもしれませんが、上記の計算で実際はそれほど単純な話ではないことがわかると思います。




<a href="http://www.amazon.co.jp/gp/product/4130420658/ref=as_li_ss_il?ie=UTF8&camp=247&creative=7399&creativeXSIN=4130420658&linkCode=as2&tag=armyofpigs-22"><img border="0" src="http://ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=4130420658&Format=_SL160_&ID=AsinImage&MarketPlace=JP&ServiceVersion=20070822&WS=1&tag=armyofpigs-22" ></a><img src="http://ir-jp.amazon-adsystem.com/e/ir?t=armyofpigs-22&l=as2&o=9&a=4130420658" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" /> [^4] 




[^1]: TEDの講演での、気が狂いそうになりながらも8000の候補の中から4000個くらい調べたところで目的のタンパク質をみつけた、というくだりを聞くと研究者の大変さに思いをはせずにはいられません
[^2]: [国立がん研究センターがん対策情報センター - http://ganjoho.jp/professional/statistics/statistics.html](http://ganjoho.jp/professional/statistics/statistics.html ) 
[^3]: [http://www.e-stat.go.jp/SG1/estat/List.do?lid=000001054002](http://www.e-stat.go.jp/SG1/estat/List.do?lid=000001054002 ) 
[^4]: この問題は統計学入門の練習問題4.7を参考にしています。
