---
categories: tmux, advent calendar
date: 2011/12/13 00:58:29
title: tmuxでマウスを使う
draft: True
image: /images/terminal.png
---

これは[ターミナルマルチプレクサ Advent Calendar 2011](http://atnd.org/events/22320)の13日目です。

12日目はnetmarkjpさんの[](http://netmark.jp/)でした。


今日はtmuxのマウスまわりの設定について紹介してみます。


tmuxでも結構前からマウスサポートはされていて、バージョンあがるごとに徐々に機能がふえてきているようです。
tmux-1.5の時点で使えるマウスの設定項目は以下の通りです。


mode-mouse
: onにすると、マウスで画面をドラッグしたときにコピーモードに入ります。マウスホイールでスクロールすることもできまあす。

mouse-select-pane
: マウスクリックでpaneを選択できるようになります。

mouse-select-window
: statusを有効にしているときに、window名の部分をクリックすることでwindowを切り替えられます。

mouse-utf8
: マウスの入力をutf-8として扱うための設定だそうです。効果はよくわかりませんでした。
