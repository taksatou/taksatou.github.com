---
categories: linux, unix, tips
date: 2013/1/8 20:30:00
title: おやつの時間をお知らせしてくれるUnixコマンド：at teatime (他...)
image: /images/banana-200.png
---

![banana](/images/banana-200.png)


[Favorite Linux Commands(http://clippy.in/b/YJLM9W)](http://clippy.in/b/YJLM9W) で紹介されてたコマンドのうち知らなかったものをメモ。


## at

入力されたコマンドを指定されたタイミングで実行するようにスケジュールする。
cronに登録するほどでもない単発のコマンドを実行したいときとかにつかう。
時間の指定には現在の時刻からの経過時間や絶対時間の他にteatimeやmidnightといった文字列もつかえる。
ちなみにteatimeは午後4時。
出力先を指定しなければコマンドの出力はcronと同じようにメールにとぶ。$TTYにリダイレクトしてやればコマンドを実行した端末に表示させることもできる。

例
$$code
echo "echo おやつの時間です > $TTY"| at teatime
echo "echo はろー > $TTY" | at now + 3 minute
$$/code

## mtr

tracerouteとpingをあわせたようなもの。tracerouteより表示がみやすい。
ネットワークのどこで時間がかかってるのか一目でわかる。

例
$$code
mtr mojavy.com
$$/code

## column

入力テキストをいい感じのカラム表示にフォーマットしてくれる。
縦に長い出力するコマンドとか、そのままだと出力がみづらいときとかにつかう。

例
$$code
gem list | column
mount | column -t
grep -v '^#' /etc/apt/sources.list | column -t
$$/code

## reset

端末をリセットする。
うっかりバイナリファイルをcatとかしてしまって端末が壊れてしまった場合に端末を閉じずに復帰できる。

## sshfs

ssh経由でリモートのファイルシステムをマウントできる。

例
$$code
sshfs name@server:/path/to/dir /path/to/mount/point
fusermount -u /path/to/mount/point  # unmount
$$/code

## その他

以下はコマンド自体の機能ではないけど覚えておくと便利かもしれないもの

### curl ifconfig.me

ifconfig.meというサイトがある。自分のグローバルIPがわかる。

### dig +short txt <keyword>.wp.dg.cx

dnsクエリでwikipediaのエントリーがみれる。

例
$$code(lang=bash)
$ dig +short txt banana.wp.dg.cx
"Banana is the common name for herbaceous plants of the genus Musa and for the fruit they produce. It is one of the oldest cultivated plants. They are native to tropical South and Southeast Asia, and are likely to have been first domesticated in Papua New " "Guinea. Today, they are cultivated throughout the tropics. They are grown in at least 107 countries, primarily for their... http://en.wikipedia.org/wiki/Banana"
$$/code

