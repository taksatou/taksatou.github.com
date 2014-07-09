---
categories: c++, programming
date: 2014/07/09 21:56:32
title: C++のdreaded diamondについて
---

以下のようなダイアモンド継承をしたときに発生する問題のことを`dreaded diamond`と呼ぶらしい。

$$code
    Base
    /  \
   D1  D2
    \  /
     D3
$$/code


例えば以下のようなクラスではアップキャストをするときやBaseクラスのメンバにアクセスするときに曖昧性が生じる。

$$code(lang=cpp)
class Base {
public:
    int data;
    virtual ~Base() {}
};

class D1 : public Base {
public:
    virtual ~D1() {}
};

class D2 : public Base {
public:
    virtual ~D2() {}
};

class D3 : public D1, public D2 {
public:
    virtual ~D3() {}
};
$$/code


以下のようなコードをコンパイルしようとしてもエラーになる。

$$code(lang=cpp)
void f1() {
    D3 d3;
    Base &base = d3;
    d3.data = 123;
}
$$/code

$$code
      ambiguous conversion from derived class 'D3' to base class 'Base':
    class D3 -> class D1 -> class Base
    class D3 -> class D2 -> class Base
    Base &base = d3;
                 ^~

      non-static member 'data' found in multiple base-class subobjects of type 'Base':
    class D3 -> class D1 -> class Base
    class D3 -> class D2 -> class Base
    d3.data = 123;
       ^
$$/code


これを回避するためには明示的に中継するクラスを指定してやる必要がある。

$$code(lang=cpp)
void f2() {
    D3 d3;
    Base &base = dynamic_cast<D1&>(d3);
    d3.D1::data = 123;
    d3.D2::data = 456;
    
    cout << d3.D1::data << ',' << d3.D2::data << endl;  // => 123,456
}
$$/code

でも普通は継承元にそれぞれの別々の親を持つのではなく、共通の1つだけを持っていてほしい。
それを解決するには仮想継承を使う。

$$code(lang=cpp)
class D1 : public virtual Base { /* 省略 */ };
class D2 : public virtual Base { /* 省略 */ };
class D3 : public D1, public D2 { /* 省略 */ };
$$/code

このようにすればBaseクラスのインスタンスは1つだけになって曖昧性が解消される。

$$code(lang=cpp)
void f3() {
    D3 d3;
    Base &base = d3;
    d3.data = 123;

    cout << d3.D1::data << ',' << d3.D2::data << endl;  // => 123,123
}
$$/code



