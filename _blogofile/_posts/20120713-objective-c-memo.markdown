---
categories: objective-c
date: 2012/07/13 18:30:00
title: objective-cのカテゴリついてのメモ
image: /images/nextstep-logo.png
---

![objective-c](/images/nextstep-logo.png)

* objective-cではカテゴリという機能を使ってクラスの拡張ができる。
* javascriptのprototypeのようなもの。
* 一旦上書きしたメソッドにアクセスする方法はない。メソッドを上書きする必要がある場合はサブクラスとして実装するべき。
* プライベートメソッドは無名カテゴリを使って実装できる。
* 別の名前のカテゴリでもメソッド名は一意にしなければならない。
* 別のカテゴリとの間にメソッド名でコンフリクトが発生した場合、どちらが呼ばれるかは未定義。
* カテゴリ名自体にソースコード上での可読性以上の実質的な意味は無いらしい。


## 例

$$code(lang=objective-c)
@interface NSObject (MyExt)
-(void) doit: (NSString *) arg;
@end

@implementation NSObject (MyExt)
-(void) doit: (NSString *) arg
{
   // do something
}
@end
$$/code

## 参考

* [http://stackoverflow.com/questions/5689088/do-objective-c-category-names-do-anything](http://stackoverflow.com/questions/5689088/do-objective-c-category-names-do-anything)

<br>
<iframe src="http://rcm-jp.amazon.co.jp/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=armyofpigs-22&o=9&p=8&l=as4&m=amazon&f=ifr&ref=ss_til&asins=0321811909" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>
