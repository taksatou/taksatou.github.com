---
categories: programming, algorithms
date: 2013/10/17 21:13:58
title: オーバーフローしにくいCombination組み合わせの数の計算方法
filter: latex, syntax_highlight, markdown
---

Cで組み合わせの数を計算するときに定義通り計算するとすぐにオーバーフローしてしまう、という問題がある。
例えば以下のような実装だと、 $$latex {}_{30} C _{15} $ 程度でも結果がおかしくなってしまう。

$$code(lang=cpp)
#include <iostream>

using namespace std;

uint64_t fac(uint64_t n) {
    if (n > 1)
        return n * fac(n-1);
    else
        return 1;
}

uint64_t combinations(uint64_t n, uint64_t k) {
    return fac(n) / (fac(k) * fac(n-k));
}

int main(int argc, char *argv[]) {
    cout << combinations(5, 3) << endl; // => 10
    cout << combinations(10, 5) << endl; // => 252
    cout << combinations(20, 10) << endl; // => 184756
    cout << combinations(30, 15) << endl; // => 0 !?
    return 0;
}
$$/code


とりあえず素因数分解してやれば解決するのでいままでそうしてたのだけど、もっとかっこいい方法がないものかと思って探してみたらKnuth先生の本で以下のようなアルゴリズムが紹介されているらしい。[^1] 
これはかっこいい。

$$code(lang=cpp)
uint64_t combinations2(uint64_t n, uint64_t k) {
    uint64_t r = 1;
    for (uint64_t d = 1; d <= k; ++d) {
        r *= n--;
        r /= d;
    }
    return r;
}

int main(int argc, char *argv[]) {
    cout << combinations2(30, 15) << endl; // => 155117520
    cout << combinations2(60, 30) << endl; // => 118264581564861424

    cout << combinations2(64, 32) << endl; // これはオーバーフローする
    return 0;
}

$$/code

結果の値が範囲内ならオーバーフローしないのか、というとそういうわけではないけどナイーブな実装に比べるとずっと計算できる範囲が広いので、値のレンジがあらかじめわかっているのであればこれで十分ですね。



<iframe src="http://rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=armyofpigs-22&o=9&p=8&l=as4&m=amazon&f=ifr&ref=ss_til&asins=4756145434" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>


[^1]: [http://stackoverflow.com/questions/1838368/calculating-the-amount-of-combinations](http://stackoverflow.com/questions/1838368/calculating-the-amount-of-combinations )   残念ながらvol2は手元にはない
