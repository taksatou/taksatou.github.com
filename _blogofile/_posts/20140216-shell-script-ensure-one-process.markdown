---
categories: shell, unix
date: 2014/02/16 18:35:51
title: シェルスクリプトでプロセスの多重起動を防止する簡単で安全な方法
---

`flock(1)`を使うのが一番安全かつ簡単


$$code(lang=bash)
LOCKFILE=/tmp/my.lockfile

(
    flock -n 200 || exit 1

    # do something
) 200>$LOCKFILE
$$/code

タイムアウトを設定したければ`-w`オプションをつかえばよい。
            
リードライトロックとしてつかえるので、更新系のスクリプトは1つしか起動したくないけど参照系は並列実行を許す、みたいなことも比較的簡単にできる。
            
