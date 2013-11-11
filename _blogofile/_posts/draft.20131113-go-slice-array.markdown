---
categories: go
date: 2013/11/06 14:20:51
title: Goのarrayとsliceの違い
draft: True
---

sliceとarrayの取り扱いについて混乱しがち

http://blog.golang.org/go-slices-usage-and-internals
を読むのが一番いいですが、長いので要点だけまとめておく


## arrayとは

arrayとは番号付けされた同種の型をもつ要素のシーケンスのこと。他のプログラミング言語にある配列に相当するものと基本的には同じものだという理解でいいと思いますがけど、要素数も含めて型の一部という点には注意が必要です



## sliceとは

> A slice is a descriptor for a contiguous segment of an array and provides access to a numbered sequence of elements from that array. A slice type denotes the set of all slices of arrays of its element type. The value of an uninitialized slice is nil.




## 参照

* [The Go Programming Language Specification](http://golang.org/ref/spec )
* [Effective Go](http://golang.org/doc/effective_go.html )


### ねたmemo


* `...`の意味について
* makeとnewの違い
* 参考にするとよいgo projectまとめ
