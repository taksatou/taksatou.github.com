---
categories: history, web
date: 2014/02/13 18:00:22
title: TCPの黒歴史：謎のオプションskeeterとbubbaについて
image: /images/ie10.png
---

![ie](/images/ie10.png ) 

TCPについて調べてたら、`skeeter`と`bubba`という謎のオプションを見つけた。
調べてみたところ、TCPを策定した人達の黒歴史らしい。

* [TCP options: Bubba and Skeeter](http://mailman.postel.org/pipermail/internet-history/2001-November/000073.html ) 

以下意訳です。


あー、これは忘れられそうもないんだけど黒歴史だね。
ben levyとstevと私[^1] がFTPをやってたときにつくったものなんだ。
Bridghan[^2]とstevがけしかけたんだけど、アイディアはシンプルで、鍵管理システムなしに暗号化できるように、デフィー・ヘルマン鍵共有をtcpで直接するためのものだった。
それには認証の仕組みは想定してなくて、パスワードみたいなものが共有されている前提だったんだ。
シンプルな実装で大体は動いてたんだけど、介入者攻撃には脆弱だったのが欠点だった。

なんで"skeeter"[^3]  と"bubba"[^4] かって？それはstevに聞いてくれ。

<hr>

なかなかセンスのあるネーミングですね。気になる人はstev氏に聞いてみてください。


**参考**

* [Transmission Control Protocol (TCP) Parameters](http://www.iana.org/assignments/tcp-parameters/tcp-parameters.xhtml ) 
* [Re: [tcpm] IANA TCP options registry ...](http://www.ietf.org/mail-archive/web/tcpm/current/msg05424.html ) 


[^1]: Craig Partridge
[^2]: たぶんDave Bridgham のこと [http://en.wikipedia.org/wiki/FTP_Software](http://en.wikipedia.org/wiki/FTP_Software)
[^3]: トンボのことらしい
[^4]: でかい人のことらしい
