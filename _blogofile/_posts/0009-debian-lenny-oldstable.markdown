---
categories: python
date: 2012/06/6 10:30:00
title: debian lennyのEnd Of Life対応
image: /images/debian_logo.png
---

![debian](/images/debian_logo.gif)

debian lennyは2012-02-06にEnd of lifeを迎えました。
それに伴いlennyのリポジトリもoldstable扱いとなりパスが変わったため、デフォルトのsources.listでは404 Not Foundとなってパッケージがインストールできなくなってしまいました。
早めにアップデートしたほうが好ましいですが、そのまま引き続きlennyを使いたい場合もあると思います。
そのような場合は以下のようにsources.listを変更してやれば今までどおりパッケージをとれるようになります。

$$code(lang=bash)

deb http://archive.debian.org/debian-security/ lenny/updates main
deb-src http://archive.debian.org/debian-security/ lenny/updates main

deb http://archive.debian.org/debian/ lenny main
deb-src http://archive.debian.org/debian/ lenny main

$$/code

backportsなどもarchiveのほうにあるのでお好みで追加してください。

# 参考

* [http://archive.debian.org/](http://archive.debian.org/)
* [http://wiki.debian.org/DebianLenny](http://wiki.debian.org/DebianLenny)
* [http://wiki.debian.org/DebianOldStable](http://wiki.debian.org/DebianOldStable)

<br>
