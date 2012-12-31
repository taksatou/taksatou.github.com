---
categories: tmux, advent calendar
date: 2011/12/06 01:05:10
title: tmuxに独自機能を追加する
image: /images/terminal.png
---

これは[ターミナルマルチプレクサ Advent Calendar 2011](http://atnd.org/events/22320)の<s>6日目</s>7日目です。(netmark.jpさん,matsuuさん、すいません、出遅れました。)

5日目はyoshikawさんの[開発版GNU Screenを使ってみよう](http://yskwkzhr.blogspot.com/2011/12/lets-use-development-version-gnu-screen.html)でした。

6日目はnetmark.jpさんの[GNU screenをもうちょっとだけ便利に使おう！](http://netmark.jp/2011/12/gnu-screen-plusone.html)でした。

この記事ではtmuxのいじり方を簡単に紹介してみます。


# はじめに

tmuxは比較的若いプロジェクトなこともあってか、かゆいところに手が届かないシチュエーションがたまにあります。
個人的に不満だったのはバッファの挙動です。

tmuxでバッファに文字列をコピーした場合、list-buffersに新しいものほど前方になるように格納されていきます。
choose-bufferコマンドを使えばある程度簡単に過去のものもさかのぼれますがしばらくすると埋もれてしまいます。
tmuxのバッファにはホスト名とかよくつかうコマンドとかをいれておいて番号を指定して最速でとりだしたいのに、
場所が固定されていないといちいち探さなくてはならず不便に感じていました。
なんとかできないかと思ってソースをいじってみたら、意外と簡単だったので簡単な解説をまじえつつ手順を紹介してみます。

# 目次

[TOC]


# 準備

## ソースをとってくる
本家サイトからソースをおとします。とりあえず現在の最新版(1.5)でいいと思います。

[http://tmux.sourceforge.net/](http://tmux.sourceforge.net/)


## 依存パッケージを入れる
[tmatsuuさんの記事](http://d.hatena.ne.jp/tmatsuu/20111130/1322677832)にもちょっとありましたが、
tmuxはlibeventとnlcursesに依存しているのでビルドするにはライブラリのヘッダも必要です。
ubuntuだと以下パッケージを入れとけばたぶん大丈夫です。

$$code(lang=bash)
sudo apt-get install libevent-dev libncurses5-dev
$$/code

## ビルド

$$code(lang=bash)
./configure && make
$$/code

ここまでできたら準備OKです。


# ソース構成

結構たくさんファイルがありますが、ファイル名を見れば大体雰囲気がつかめると思います。

何か機能を追加したいだけなら、いじる必要のあるファイルはごく一部です。

tmux.h
: ほとんどのコマンドは全部ここに宣言がまとめられてるのでほぼ必ずいじります。
options-table.c
: オプション追加する場合はここに追加します。値の肩などを定義するテーブルが宣言されているので、中身を見れば大体わかると思います。


いじる必要はないですがarray.hはいろんなところでつかわれてるので目を通しとくとよいと思います。
Cでリストが使いたい場合は他のとこでも流用できそうな便利なヘッダです。


あとは必要に応じて関係しそうなところをみていけばよいです。


# いじってみる

バッファまわりを改造したいので、paste.cというファイルが主な対象になります。


細かい解説は省略しますが、paste_stackという構造体がグローバルで共有しているリストの本体で、array.hで宣言されているマクロで値がとりだせるようになっています。
本来の動作であるpaste_addを参考にしつつpaste_add_tailなんて関数を追加します。
後に追加した文字列ほど後ろにいってほしいですが、直前のものだけは先頭にあったほうが便利なのでちょっと変則的な感じになってますが、やっていることはシンプルです。

$$code(lang=diff)
diff -u tmux-1.5/paste.c tmux-1.5-patched/paste.c
--- tmux-1.5/paste.c    2011-07-09 18:42:38.000000000 +0900
+++ tmux-1.5-patched/paste.c    2011-12-06 23:36:31.921805251 +0900
@@ -119,6 +119,38 @@
        pb->size = size;
 }

+/*
+ * Add an item onto the tail of the stack, freeing the bottom if at limit. Note
+ * that the caller is responsible for allocating data.
+ */
+void
+paste_add_tail(struct paste_stack *ps, char *data, size_t size, u_int limit)
+{
+       struct paste_buffer     *pb;
+
+       if (size == 0)
+               return;
+
+       while (ARRAY_LENGTH(ps) >= limit) {
+               pb = ARRAY_LAST(ps);
+               xfree(pb->data);
+               xfree(pb);
+               ARRAY_TRUNC(ps, 1);
+       }
+
+       pb = xmalloc(sizeof *pb);
+
+       if (ARRAY_LENGTH(ps) > 0) {
+               ARRAY_ADD(ps, ARRAY_FIRST(ps));
+               ARRAY_SET(ps, 0, pb);
+       } else {
+               ARRAY_ADD(ps, pb);
+       }
+       ARRAY_INSERT(ps, 0, pb);
+
+       pb->data = data;
+       pb->size = size;
+}

$$/code


ここで追加した関数はtmux.hで宣言しておきます

$$code(lang=diff)
diff -u tmux-1.5/tmux.h tmux-1.5-patched/tmux.h
--- tmux-1.5/tmux.h     2011-07-09 18:42:38.000000000 +0900
+++ tmux-1.5-patched/tmux.h     2011-12-06 23:36:31.925805201 +0900
@@ -1487,6 +1487,7 @@
 int             paste_free_top(struct paste_stack *);
 int             paste_free_index(struct paste_stack *, u_int);
 void            paste_add(struct paste_stack *, char *, size_t, u_int);
+void            paste_add_tail(struct paste_stack *, char *, size_t, u_int);
 int             paste_replace(struct paste_stack *, u_int, char *, size_t);
 char           *paste_print(struct paste_buffer *, size_t);
$$/code


また、今回の機能は設定ファイルでon/offを切り替えられるようにしておきたいので、options-table.cも編集します。
$$code(lang=c)
diff -u tmux-1.5/options-table.c tmux-1.5-patched/options-table.c
--- tmux-1.5/options-table.c    2011-07-09 18:42:38.000000000 +0900
+++ tmux-1.5-patched/options-table.c    2011-12-06 23:36:31.921805251 +0900
@@ -57,6 +57,11 @@
          .default_num = 20
        },

+       { .name = "reverse-buffer",
+         .type = OPTIONS_TABLE_FLAG,
+         .default_num = 0
+       },
+
        { .name = "escape-time",
          .type = OPTIONS_TABLE_NUMBER,
          .minimum = 0,
$$/code


実際にバッファの制御関数を呼び出しているのはwindow-copy.cなので、さっき追加したオプションの値をみて切り替えられるようにします。

$$code(lang=diff)
diff -u tmux-1.5/window-copy.c tmux-1.5-patched/window-copy.c
--- tmux-1.5/window-copy.c      2011-07-09 18:42:38.000000000 +0900
+++ tmux-1.5-patched/window-copy.c      2011-12-06 23:36:31.921805251 +0900
@@ -1348,7 +1348,11 @@
        /* Add the buffer to the stack. */
        limit = options_get_number(&global_options, "buffer-limit");
-       paste_add(&global_buffers, buf, off, limit);
+       if (options_get_number(&global_options, "reverse-buffer")) {
+               paste_add(&global_buffers, buf, off, limit);
+       } else {
+               paste_add(&global_buffers, buf, off, limit);
+       }
 }

$$/code

あとは設定ファイルに以下を追加してmakeしたtmuxを起動してみます。

$$code(lang=bash)
set -g reverse-buffer on
$$/code

バッファにコピーした文字列がlist-buffersの後ろに追加されていけば成功です。
簡単ですよね？


# まとめ

以上、tmuxにreverse-bufferというオプションを追加して、バッファの挙動を変更できるようにしてみました。

端末制御のプログラムは普段あまり触れる機会がないし複雑そうなイメージがあって敬遠しがちですが、ちょっとした機能を追加するだけだったら意外と簡単だったりするのでどんどんいじってみるといいと思います。







