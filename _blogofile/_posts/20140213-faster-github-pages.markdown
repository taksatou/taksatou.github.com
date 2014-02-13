---
categories: github, web
date: 2014/02/13 09:10:00
title: あなたのgithub pagesを無料で高速化する方法
image: /images/github-logo-transparent-200.png
---

![github](/images/github-logo-transparent-200.png ) 

このブログはgithub pages上に構築していますが、github pagesに引きずられて自分のブログも重くなるということが時々ありました。

がんばってブログを書いた次の日にアクセスできなくなってたりすると悲しいので何とか高速かつ安定した配信をする方法ないかなーと思って調べてみたところ、なんとgithub pagesに置いたコンテンツをCDNから配信させることができるようになったらしいです!

[Faster, More Awesome GitHub Pages](https://github.com/blog/1715-faster-more-awesome-github-pages ) 

どういうドメインでgithub pagesを配信しているかによって対応方法は違うので以下を読んで各自適切な設定をして下さい。


**目次**

[TOC]

## デフォルトのgithub pagesのドメイン( username.github.io ) を使用している場合

既に対応しています。
なにもやる必要はありません。


## カスタムサブドメイン ( www.example.com ) を使用している場合

CNAMEの向き先をusername.github.io に向けるだけで対応できます。

## Apexドメイン ( example.com ) を使用している場合

Apexドメインというのはサブドメインでない基本のドメイン部分のことで、そこを直接github pagesにIPに向くようにAレコードに設定している場合です。

この場合はDNSのプロバイダがALIASレコードをサポートしていれば、ALIASが `username.github.io` を向くようにすることで対応できます。

ALIASレコードに対応していない場合は残念ながらCDNを有効にできません。ちなみにお名前.comはALIASには対応していないので、その場合は他のDNSプロバイダに移行するしかありません。

### お名前.comからDNSimpleに移行する場合

このブログは残念ながらお名前.comでApexドメインをgithub pagesのIPに向けていたのでDNSimpleに移行することにしました。以下はお名前.comからDNSimpleに移行した際の手順です。

なお、この場合はタイトルに反して無料ではありません。

(ちなみにここではドメインの移管はせずに、DNSの設定だけをDNSimpleに移しました)

#### 1. DNSimpleに登録する

DNSimpleはユーザビリティに主眼を置いたDNSサービスのようで[^1] 、APIでDNSレコードを更新したりAWSやHerokuやgithub pagesといったクラウドサービスとの連携が簡単にできます。

<a href="https://dnsimple.com/r/4388f43fedebae">
![dnsimple](/images/dnsimple.png ) 

**DNSimple**
</a>

登録時に対象ドメインを聞かれるので、そのとき移行したいドメインを入力します。

ちなみに月額3ドルから[^2] ですが30日は無料でつかえます。誰かを紹介すると、紹介した人とされた人の両方の無料期間が伸びます。上のリンクにはキャンペーンコードが埋め込まれているので、この記事を読んだ人はぜひ上のリンクから登録してください。

登録が完了するだけで一通りのUIが使えるようになりますが、DNS機能が有効になるのは決済情報を入力してからです。


#### 2. DNSimpleでgithub pagesとの連携を開始する

[dnsimpleの管理画面](https://dnsimple.com/domains ) に行くとServicesというボタンがあるのでそこからgithub pagesと連携を開始します。


#### 3. ネームサーバの設定をする

お名前.com の以下のページの「他のネームサーバーを利用」からDNSimpleのネームサーバを指定します。

[https://www.onamae.com/domain/navi/ns_update/input?btn_id=navi_menu_domain_nsupdate_leftmenu_12](https://www.onamae.com/domain/navi/ns_update/input?btn_id=navi_menu_domain_nsupdate_leftmenu_12 ) 

登録するサーバは以下です。

* ns1.dnsimple.com
* ns2.dnsimple.com
* ns3.dnsimple.com
* ns4.dnsimple.com

[参考 - DNSimple Name Servers](http://support.dnsimple.com/articles/dnsimple-nameservers ) 

この段階ではお名前.com側で設定しているAレコードはそのまま残しておきます。変更するのはネームサーバのみです。
そうしておかないと、ネームサーバの変更が伝搬するまでの間にお名前.comに問いあわせが来た場合NXDOMAIN扱いになってします。

#### 4. dnsの更新を確認する

更新前は以下

$$code
% dig mojavy.com
mojavy.com.             259     IN      A       207.97.227.245
$$/code

もしくは以下

$$code
% dig mojavy.com
mojavy.com.             259     IN      A       204.232.175.78
$$/code

のようになっていたはずですが、反映が完了すれば上記とは違うIPが返ってくるはずです。
反映までには時間がかかるので気長に待ちます。完全に反映されるには3日ほどかかるようです。

$$code
% dig mojavy.com
mojavy.com.             3600    IN      A       103.245.222.133

% dig taksatou.github.io
taksatou.github.io.     2973    IN      CNAME   github.map.fastly.net.
github.map.fastly.net.  15      IN      A       103.245.222.133
$$/code

#### 5. CDNの確認

[webpagetest](http://www.webpagetest.org/ ) のような計測ツールを使ってもいいですが、CDNからのレスポンスは`X-xxx`のようなヘッダがつくようなのでcurlでも確認できます。

$$code
% curl -v mojavy.com 2>&1  > /dev/null  | grep 'X-'
< X-Served-By: cache-ty67-TYO
< X-Cache: HIT
< X-Cache-Hits: 5
< X-Timer: S1392104522.668435574,VS0,VE0
$$/code


もう完全に反映されたと思ったらお名前.com側で設定しているAレコードは無効にして大丈夫です。


## その他参考

* [https://help.github.com/articles/setting-up-a-custom-domain-with-pages](https://help.github.com/articles/setting-up-a-custom-domain-with-pages ) 


## まとめ

* github pagesをつかえば無料でCDNから配信できる!
* Apexドメインは慎重に使うべきだったという教訓を得た
* DNSimple便利


[^1]: The satisfaction of not having to use GoDaddy!  らしい
[^2]: 登録ドメイン数に応じて自動的にプランが切りかわるようです。
