---
categories: programming
date: 2013/2/05 23:00:00
image: /images/stackoverflow-200.png
title: 人気プログラミング言語ランキング(stackoverflow調べ)
---

![stack](/images/stackoverflow-200.png)

なんとなく気になったのでstackoverflowのでの人気プログラミング言語ランキングをつくってみました。(2013-02-05現在)

$$code
1.   c#              411382pt
2.   java            361120pt
3.   php             337941pt
4.   javascript      321791pt
5.   c++             175790pt
6.   python          160796pt
7.   html            145373pt
8.   objective-c     119891pt
9.   sql             115147pt
10.  css             113039pt
11.  c               83501pt
12.  ruby            64350pt
13.  xml             56444pt
14.  regex           51670pt
15.  vb.net          41260pt
16.  html5           27217pt
17.  linq            26200pt
18.  actionscript-3  24286pt
19.  perl            24092pt
20.  r               23256pt
21.  delphi          18866pt
22.  tsql            18119pt
23.  matlab          15289pt
24.  xaml            14115pt
25.  scala           13444pt
26.  vba             12300pt
27.  css3            11564pt
28.  xslt            11032pt
29.  haskell         9827pt
30.  assembly        7580pt
31.  razor           7385pt
32.  actionscript    6440pt
33.  excel-vba       6309pt
34.  groovy          5551pt
35.  vbscript        4926pt
36.  c++11           4894pt
37.  vb6             4886pt
38.  xhtml           4675pt
39.  plsql           4548pt
40.  svg             4540pt
41.  f#              4341pt
42.  python-3.x      4229pt
43.  awk             3481pt
44.  wsdl            3249pt
45.  lua             3183pt
46.  erlang          3077pt
47.  coffeescript    2754pt
48.  c#-3.0          2615pt
49.  latex           2570pt
50.  lisp            2395pt
51.  mathematica     2395pt
52.  prolog          2317pt
53.  scheme          2199pt
54.  uml             2093pt
55.  applescript     2092pt

-- 次点

go         1648pt
ocaml      1329pt
d          877pt

$$/code


### 補足

* stackoverflow APIを利用して調べました。stackoverflow公式のものではありません。
* ランキングは質問につけられたタグの件数順です。
* プログラミング言語のタグは、tag infoのエントリに/language/i がマッチするかどうかで抽出し、明かにプログラミング言語じゃないものは手動で適当に除外しました。
* マークアップ言語とかバージョン違いで複数ある言語とか微妙なのはそのまま残しました。
* 次点以下の言語は、apiをしばらくクロールしてもでてこなかった言語のうち思いついたものを手動でしらべました。


### 所感

C#が1位なのはちょっと意外でしたがそれ以外は大体イメージ通りでした。
質問が多い順でもあるので、下位にある言語は質問が少なくて逆にイケてると言えなくもないですね。

D言語すばらしい。

ともあれ、stackoverflowのAPIは結構充実してるので色々遊べそうです。

* [http://api.stackoverflow.com/1.0/usage](http://api.stackoverflow.com/1.0/usage)
