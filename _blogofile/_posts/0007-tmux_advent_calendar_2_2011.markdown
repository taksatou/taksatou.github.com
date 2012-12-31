---
categories: tmux, advent calendar
date: 2011/12/13 00:58:29
title: tmuxでマウスを使う
image: /images/terminal.png
---

これは[ターミナルマルチプレクサ Advent Calendar 2011](http://atnd.org/events/22320)の13日目です。
12日目はnetmarkjpさんの[GNU screen でシリアル通信 + xmodem転送](http://netmark.jp/2011/12/gnu-screen-xmodem.html)でした。


今日はtmuxのマウスまわりの設定について紹介してみます。


tmuxにはマウスで操作するための機能がいくつか提供されています。ChangeLogを見る限りでは結構前からマウスサポートはされているようですが、mac portから入れたtmuxでは動かなかったのでソースから最新版をいれることをおすすめします。
macでソースから入れる方法は初日に[matsuuさんが紹介してくれている](http://d.hatena.ne.jp/tmatsuu/20111130/1322677832)のでそちらを参考にしてください。


tmux-1.5の時点で使えるマウス関連の設定項目は以下の通りです。

mode-mouse
: onにすると、マウスで画面をドラッグしたときにコピーモードに入ります。マウスホイールでスクロールすることもできます。

mouse-select-pane
: マウスクリックでpaneを選択できるようになります。

mouse-select-window
: statusを有効にしているときに、window名の部分をクリックすることでwindowを切り替えられます。

mouse-utf8
: マウスの入力をutf-8として扱うための設定だそうです。効果はよくわかりませんでした。


なお、shiftを押しながらターミナルをクリックすれば、本来のマウスの動作になります。

macのiTerm, windowsのputty, ubuntuのgnome-terminalで動作確認できました。
たまに画面が乱れることがありますが、再描画すると直ります。

# まとめ

以下を.tmux.confにコピペするとtmuxでマウスがつかえます。

$$code(lang=bash)

set -g mode-mouse on
set -g mouse-resize-pane on
set -g mouse-select-pane on
set -g mouse-select-window on

$$/code



本当は、set-clipboardという機能も紹介したかったのですが、ちゃんと動かすことができなかったのでまたの機会にします。
以上非常に簡単でしたがマウスサポート機能の紹介でした。



