---
categories: objective-c
date: 2012/07/18 11:30:00
title: objective-cのメモリマネージメントについて
image: /images/nextstep-logo.png
---

![objective-c](/images/nextstep-logo.png)


現在のところ3つの方法がある

## 1. Gabage Collection

* Objective-C 2.0から導入された。
* ただし、iOSの実行環境には含まれない。
* Max OS Xでなら使えるらしい。

## 2. Manual Reference Counting

* retainは参照カウントを1あげる。releaseは1さげる
* 参照カウントが0でdeallocするとすぐに削除される
* NSMutableArrayのaddObjectやremoveObjectAtIndexなどはオブジェクトの参照カウントを増減させる。
* 余分にreleaseしたりするとcrashする

## 3. Automatic Reference Counting (ARC)

* システムが自動的に参照カウントをしてくれる。
* 強い変数と弱い変数がある

#### 強い変数

* デフォルトでは、オブジェクトのポインタは強い変数。そのようなポインタにアサインした参照は自動的にretainされる。
* 新しい参照をアサインする前に古い参照はreleaseされる
* _ _strong キーワードをつかって明示的に強い変数を宣言できる。
* プロパティはデフォルトではstrongではない
* C++のshared_ptrのようなもの？

#### 弱い変数

* 循環参照している場合や、しても開放されるようにするときに使える。
* 親が子の強い参照を持っており、子が親の弱い参照を持っている場合、retainのサイクルが形成されなくなるのでオブジェクトを開放できる。
* _ _weakキーワードを使う。
* iOS4ではサポートされていない
* C++のweak_ptrのようなもの？

#### Non-ARCのコード

* init, alloc, copy, new, mutableCopyをprefixにもつメソッドはそのオブジェクトの所有権を返す、というネーミングコンベンションに従っている場合は自動的にARCが適用される。
* 名前のコンベンションとは関係なしに、明示的にオブジェクトの所有権を返すメソッドをコンパイラに伝える方法もある。

## 参考

<br>
<iframe src="http://rcm-jp.amazon.co.jp/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=armyofpigs-22&o=9&p=8&l=as4&m=amazon&f=ifr&ref=ss_til&asins=0321811909" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>

