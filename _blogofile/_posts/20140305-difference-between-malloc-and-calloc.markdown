---
categories: programming, os
date: 2014/03/05 21:25:23
title: malloc+memsetとcallocの違いについて
---

`malloc`と`calloc`の違いは、表面的には引数の数と`calloc`は確保した領域を0で初期化するという点くらいですが、以下のコードを大きな`n`で実行すると、今時のOSだと`malloc` + `memset`のほうが大幅に遅くなる可能性があります。

$$code(lang=c)
void *p = malloc(n * sizeof(type));
memset(p, 0, n * sizeof(type));
$$/code

$$code(lang=c)
void *p = calloc(n, sizeof(type));
$$/code


カーネルはセキュリティ上の理由からメモリを0で初期化してからユーザプロセスに渡します。

しかし、仮想メモリをサポートしたシステムでは、実際にそのメモリに書き込みが発生するまでカーネルはread onlyな領域を複数プロセスで共有させることができるため、既に初期化してあるページであればこの処理を省略できる場合があります。

`brk`で拡張した領域は0で初期化されているので、`calloc`は新規確保した領域は初期化を省略することができ、結果的に`calloc`を実行したタイミングでは初期化が実際にはほとんど発生しない、ということがありえます。

一方`memset`の場合は実際にメモリへの書込みが発生する上、ページの共有もできなくなるためswapする可能性もあります。

<p>
<p>


ちなみに、(カーネルではなく)`calloc`自身が0初期化する処理と、`memset`の処理は微妙に違います。
なぜなら、`memset`は対象の領域がアラインされているかどうかについての情報なしに処理する必要があるので、境界部分は1byteずつやるしかありません。

じゃあ`memset`のほうが遅いのかというと、コンパイラによってはアラインされていることを推測できる場合もあったり、callocはライブラリ関数なので移植性のために最適化しにくかったりするので、結局のところ微妙です。


[http://stackoverflow.com/questions/2688466/why-mallocmemset-is-slower-than-calloc](http://stackoverflow.com/questions/2688466/why-mallocmemset-is-slower-than-calloc ) 
