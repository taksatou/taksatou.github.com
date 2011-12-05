---
categories: tmux
date: 2011/12/06 01:05:10
title: tmuxに独自コマンドを追加する
---

これは[ターミナルマルチプレクサ Advent Calendar 2011](http://atnd.org/events/22320)の6日目です。
5日目はyoshikawさんの[開発版GNU Screenを使ってみよう](http://yskwkzhr.blogspot.com/2011/12/lets-use-development-version-gnu-screen.html)でした。

---


tmuxは比較的若いプロジェクトなこともあってか、かゆいところに手が届かないシチュエーションがちょくちょくあります。
個人的に不満だったのはバッファの挙動です。

tmuxでバッファに文字列をコピーした場合、バッファの一覧はキューのような構造で新しいものほど前方になる動きをします。
でもこの動きだとホスト名とかよくつかうコマンドとかをずっと前の方においておきたいのに、バッファに何か追加するたびに後ろにずれていって不便に感じることがよくありました。
要するにキューではなくスタックのように動いてほしかったわけです。

というわけでtmuxいじってみたら意外と簡単だったので、以下ソースの簡単な解説をまじえつつ紹介してみます。



### 1. ソースをとってくる ###
本家サイトからソースをおとします。とりあえず現在の最新版(1.5)でいいと思います。

[http://tmux.sourceforge.net/](http://tmux.sourceforge.net/)


### 2. 依存パッケージを入れる ###
[tmatsuuさんの記事](http://d.hatena.ne.jp/tmatsuu/20111130/1322677832)にもちょっとありましたが、
tmuxはlibeventとnlcursesに依存しているのでライブラリのヘッダも必要です。
ubuntuだとたぶん以下パッケージを入れとけば大丈夫です。

$$code(lang=bash)
sudo apt-get install libevent-dev libncurses5-dev
$$/code

### 3. とりあえずビルド ###

$$code(lang=bash)
./configure && make
$$/code

ここまでできたら準備OKです。


### 4. ソースをながめる ###
