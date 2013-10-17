---
categories: go, programming
date: 2013/06/28 20:45:36
title: GoroutineでConcurrentにエラトステネスの篩を計算する
image: /images/gopherbw-250.png
draft: True
---

![gopher](/images/gopherbw-250.png ) 


Goの練習がてら[エラトステネスの篩](http://ja.wikipedia.org/wiki/%E3%82%A8%E3%83%A9%E3%83%88%E3%82%B9%E3%83%86%E3%83%8D%E3%82%B9%E3%81%AE%E7%AF%A9 ) を実装してみた。

[Project Eulerにちょうどいい問題(10001st prime)](http://projecteuler.net/problem=7 ) があったので、まずは単なるクロージャで書いてみる。[^1] 


$$code(lang=go)
package main

import (
    "fmt"
)

var (
    lim = 10000000
    tgt = 100001
)

func GetPrimes() func() int {
    sieve := make([]bool, lim)
    p := 2
    
    return func() int {
        for i := 2; i * p < lim; i++ {
            sieve[i*p] = true
        }
        ret := p
        for i := p + 1; i < lim; i++ {
            if sieve[i] == false {
                p = i
                break
            }
        }
        return ret
    }
}

func main() {
    p := GetPrimes()
    for i := 1; i < tgt; i++ { p() }
    fmt.Println(">> ", p())
}
$$/code


これをGoroutineで書き換えるのは簡単で、返り値のかわりにチャネルをつかうようにするだけ。

$$code(lang=go)
package main

import "fmt"

var (
    lim = 10000000
    tgt = 100001
    buf = 100
)

func GetPrimes2(lim int) chan int {
    sieve := make([]bool, lim)
    primes := make(chan int, buf)
    p := 2
    
    go func() {
        for {
            for i := 2; i * p < lim; i++ {
                sieve[i*p] = true
            }
            primes <- p
            for i := p + 1; i < lim; i++ {
                if sieve[i] == false {
                    p = i
                    break
                }
            }
        }
    }()
    return primes
}

func main() {
    c := GetPrimes2(lim)
    for i := 1; i < tgt; i++ { <-c }
    fmt.Println(">> ", <-c)
}

$$/code


pが素数のときp〜2*pの区間に少なくとも一つの素数が存在する、という前提[^2] をつかって↑を並列化させた。[^3] 

$$code(lang=go)
package main

import (
    "fmt"
    "runtime"
)

var (
    lim = 10000000
    tgt = 100001
    buf = 100
    concurrency = 8
)

func GetPrimes3() chan int {
    sieve := make([]bool, lim)
    primes := make(chan int, buf)
    primes2 := make(chan int, buf)
    wait_next := make(chan bool, buf)

    primes <- 2
    primes2 <- 2

    go func() {
        p := 2
        for {
            <- wait_next
            for i := p + 1; i < lim; i++ {
                if sieve[i] == false {
                    primes <- p
                    primes2 <- p
                    p = i
                    break
                }
            }
            
        }
    }()

    for n := 0; n < concurrency; n++ {
        go func(id int) {
            for {
                p := <- primes2
                sieve[2*p] = true
                wait_next <- true
                for i := 3; i * p < lim; i++ {
                    sieve[i*p] = true
                }
            }
        }(n)
    }
    
    return primes
}

func main() {
    runtime.GOMAXPROCS(concurrency)
    c := GetPrimes3()
    for i := 1; i < tgt; i++ { <-c }
    fmt.Println(">> ", <-c)
}
$$/code

篩をうめるときは最初の数(ある素数の2倍の数)をうめた時点で次の素数が決定できるのでそこのループを並列化できるかと思ったけど、残念ながら速度は体感でわかるほど遅くなってしまった。[^4] 


今度スケジューラとかgoroutineまわりのソースを読んでみようと思う。


#### 参考

* [https://gist.github.com/methane/5377227#file-goscheduler-md](https://gist.github.com/methane/5377227#file-goscheduler-md ) 



[^1]: ある程度処理に時間がかかるように定数は適当にかえてます
[^2]: [チェビシェフの定理](http://ja.wikipedia.org/wiki/%E3%83%99%E3%83%AB%E3%83%88%E3%83%A9%E3%83%B3%E3%81%AE%E4%BB%AE%E8%AA%AC )
[^3]: 呼び出し側に素数を渡すためのチャネルと篩をうめるgoroutineに素数を渡すためのチャネルの2本をつかってるのがださい
[^4]: 8コアのlinuxマシンで実行しています
