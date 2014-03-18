---
categories: unix, programming
date: 2014/03/18 21:41:12
title: pthreadの取り消しポイント(cancellation point)についてのメモ
---

cancellation pointsとは、スレッドのキャンセル種別が`deferred`のときに、そこに到達したときにはじめて実際にそのスレッドのキャンセル要求が処理されるような関数のこと。

`POSIX.1` で定義している関数は取り消しポイント(`cancellation points`)であるかどうかが規定されている。

基本的にはブロックするような関数は大体cancellation pointsになる。

## 参考

* [http://pubs.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_09.html](http://pubs.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_09.html ) 
* [pthread_cancel(3)](http://linuxjm.sourceforge.jp/html/LDP_man-pages/man3/pthread_cancel.3.html ) 
