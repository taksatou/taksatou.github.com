---
categories: xcode, mac
date: 2012/07/12 12:30:00
title: Xcodeのキーバインディングをもっとemacsっぽくする
image: /images/xcode-logo.png
---

![xcode](/images/xcode-logo.png)

xcodeのキーバインディングはデフォルトでemacsっぽいものが使えますが、普段emacsを使ってる身としては中途半端すぎて逆にいらつきます。

C-xC-sで変な文字が入ったり、escで補完リストのポップアップをトグル表示とかやめてほしかったので、
このあたりのうざい動きを抑えつつ最低限の設定を追加した設定をつくりました。

<script src="https://gist.github.com/3095366.js"> </script>


これを/Users/takayuki.sato/Library/Developer/Xcode/UserData/KeyBindings あたりに保存すれば、
xcodeのkey bindingsの設定に読ませることができると思います。

もっと良い設定があれば教えてほしいです。

