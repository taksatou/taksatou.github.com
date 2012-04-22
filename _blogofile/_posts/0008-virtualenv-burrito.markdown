---
categories: python
date: 2012/04/22 17:30:00
title: 1分でpython環境を整える方法
image: /images/python-logo.gif
---

![python](/images/python-logo.gif)

pythonではvirtualenvというユーティリティを使って複数の環境を切り替えることができます。しかしvirtualenvはセットアップがちょっとわかりにくかったりバージョンによってはこけたりしていまいち使いこなせていませんでした。久し振りにブログを書くついでにpython環境を再構築しようと思って調べたところ、[virtualenv-burrito](https://github.com/brainsik/virtualenv-burrito) というのが使いやすかったので紹介します。これを使えば非常に簡単にpython環境を整えることができます。

# インストール

$$code(lang=bash)
$ curl -s https://raw.github.com/brainsik/virtualenv-burrito/master/virtualenv-burrito.sh | $SHELL
$$/code

として再ログインするだけです。勝手にパスやシェルの補完設定もしてくれます。

# 使い方

新しい環境の構築は、
$$code(lang=bash)
$ mkvirtualenv newname
$$/code
<br>

環境の切り替えは、
$$code(lang=bash)
$ workon newname
$ # or
$ workon 2.7
$$/code
<br>

不要な環境の削除は、
$$code(lang=bash)
$ rmvirtualenv newname
$$/code
<br>

以上が基本的な使い方です。さらに詳しい使い方は[virtualenvwrapperのコマンドリファレンス](http://www.doughellmann.com/docs/virtualenvwrapper/command_ref.html)等をみてください。

# 解説

virtualenv-burrito自体はvirtualenv+virtualenvwrapperの環境を構築するだけなので、本格的に使いたい場合はvirtualenvについての理解が必要です。ただ、ほとんどの場合は単にバージョンとパッケージが切り替えられればいいと思うので、mkvirtualenvとworkonさえ覚えておけば十分です。
いくつか注意点もあります。

* pythonのバイナリはあらかじめインストールされている必要があります。
* python3だとうごきません。python3環境が作れないという意味ではなく、デフォルトパスのpythonバージョンが3だとvirtualenv-burritoのセットアップ途中でこけます。その場合はpython2系をつかってください。
* pipのインストールでこける場合があります。その場合は以下のようなコマンドで回避できます。 [(参考)](https://github.com/brainsik/virtualenv-burrito/issues/16)
$$code(lang=bash)
$ rm -Rf ~/.venvburrito/lib/python/distribute-0.6.24-py2.7.egg
$ mkvirtualenv -p $(which python3.2) --distribute py32
$$/code


# まとめ

いまからpython環境を構築するならvirtualenv-burritoつかっとくと、virtualenvとvirtualenvwrapperをセットアップするまでの手間が省けていいと思います

# 関連リンク

* [virtualenv-burrito](https://github.com/brainsik/virtualenv-burrito)
* [virtualenv](http://pypi.python.org/pypi/virtualenv)
* [virtualenvwrapper](http://www.doughellmann.com/docs/virtualenvwrapper/)
<br>
