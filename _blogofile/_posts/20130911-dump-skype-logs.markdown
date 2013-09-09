---
categories: ruby, tips, rails
date: 2013/09/8 19:15:50
title: skypeのチャットログをダンプする
draft: True
---

過去ログをgrepかけたりしたかったのでつくった。

<script src="https://gist.github.com/taksatou/6027743.js"></script>

$$code(lang=bash)
./skype_dump.rb path/to/main.db <chatname>
$$/code

のようにして使う。

sqliteのファイルはOSXなら`$HOME/Library/Application Support/Skype/<skypename>/main.db` あたりにある。


わざわざactive_recordつかう必要性はあんまりなかったけど、ちょうど別件で変則的なリレーションをはりたい場面があったのでそれを調べるついで。

