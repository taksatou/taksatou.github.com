---
categories: go, tips
date: 2013/06/28 20:47:04
title: Goのxxx and not used というコンパイルエラーを回避するwork around
image: /images/gopherbw-250.png
draft: True
---

![gopher](/images/gopherbw-250.png ) 

Goでは未使用の変数やimportはエラー扱いで、`declared and not used`とか`imported and not used`といわれてコンパイルできない。
意図は理解できるけど開発途中の段階ではこの仕様がとてもめんどくさい。

いろいろ試行錯誤して便利な方法を模索してみたのだけど、結局は[Effective Go](http://golang.org/doc/effective_go.html#blank_unused ) に書いてあるブランク識別子(blank identifier)をつかう方法が一番ましなwork aroundっぽい。

以下はサンプルコードの抜粋。

$$code
package main

import (
    "fmt"
    "io"
    "log"
    "os"
)

var _ = fmt.Printf // For debugging; delete when done.
var _ io.Reader    // For debugging; delete when done.

func main() {
    fd, err := os.Open("test.go")
    if err != nil {
        log.Fatal(err)
    }
    // TODO: use fd.
    _ = fd
}
$$/code


`For debugging; delete when done.` などというコメントはそのうち無意識に無視するようになって絶対に消し忘れるので、pre commit hook とかではじけるようにしておいたほうがよい。

ちなみにgoのソースには[gitのpre-commitサンプル](http://golang.org/misc/git/pre-commit ) がついてるのでそちらも参考に。


