---
categories: dns, web
date: 2014/12/23 20:02:30
title: dnsimpleでダイナミックDNSをつかう
image: /images/dnsimple.png
---

![dnsimple](/images/dnsimple.png ) 

[dnsimple](https://dnsimple.com/r/4388f43fedebae ) ではAPIからのDNSレコードアップデートができるので、簡単にダイナミックDNSがつかえる。 

手順は以下の通り。

1. 普通にdnsimpleでAレコードを登録する
2. 登録したレコードのrecord idをしらべる。 record id は管理画面のURL `https://dnsimple.com/domains/example.com/records/<record id>/edit` をみればわかる。
3. レコードを更新するスクリプトをcronに登録する。 スクリプトは [http://developer.dnsimple.com/ddns/](http://developer.dnsimple.com/ddns/ ) でダウンロードできる。 `RECORD_ID`には上記の値、`DOMAIN_ID`にはApexドメインを設定する。

