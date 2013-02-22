---
categories: python, unix
date: 2013/2/22 23:55:00
title: pythonのsubprocess.Popen()でpipeしてwaitするとデッドロックしてはまった件
image: /images/python-logo.gif
---

![python](/images/python-logo.gif)

pythonのsubprocess.Popen()を使っていてはまってしまったのでメモ。

処理を並列化するために、Popenで起動した複数の子プロセスに対してpipeで入力データを渡して処理させてやろうと以下のようなコードを書いた。
(ここでは便宜上catコマンドを起動しているが、実際はワーカープロセスのコマンド)

$$code(lang=python)
import subprocess

children = [subprocess.Popen("cat", stdin=subprocess.PIPE) for i in xrange(10)]
#
# do something
#
for child in children:
    child.stdin.close()
    child.wait()

$$/code

子プロセスは標準入力がEOFを返したら終了するようにしてあったので、上のコードでも問題なさそうに見えるがwaitでデッドロックする。
python2.7.3以降だと問題なかったのだけど、python2.5や2.6だと必ずデッドロックしてしまう。

さんざん悩んだあげくsubprocess.pyのソースを読んでみたら、close_fds=TrueをPopenの引数に渡してやればよいことに気づいた。

要するに、子プロセスが自分の標準入力のパイプをオープンしたままexecしてしまっていたのが原因だった。
forkするとファイルディスクリプタも引き継ぐので、pipeで開いた書込み側のファイルディスクリプタを親と子の両方できちんと閉じてやらないと、標準入力の書込み側がオープンしたままの状態になってしまいEOFがこなくなってしまう。

Popenではclose_fdsにTrueを渡してやるとexecするまえに3以上のファイルディスクリプタをすべて閉じるようになっている。
(O_CLOEXECフラグを使うのではなく単にループして全部なめるような実装になっていた)

というわけで、pipe使うときに標準入出力以外のファイルディスクリプタを引き継ぐ必要性はあまりないと思うので、close_fdsを設定するのを忘れないように気をつけましょう
(Linux以外のプラットフォームでどうなるかは未調査です)
