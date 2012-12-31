---
categories: objective-c
date: 2012/07/17 18:30:00
title: objective-cのプロトコルとデリゲーションについてのメモ
image: /images/nextstep-logo.png
---

![objective-c](/images/nextstep-logo.png)

* プロトコルとはクラス間で共有するメソッドのリスト。
* javaでいうinterfaceのようなもの。
* @optionalディレクティブ以降のメソッドは実装が任意。
* @requiredディレクティブで必須。
* プロトコルに必要なメソッドは直接そのクラスで実装してもいいし、継承元の親クラスで実装してもよい。
* requiredがすべて実装されていなかった場合、コンパイラーはワーニングを出す。(エラーではない)
* すべてのrequiredメソッドを実装したクラスはそのプロトコルにconform(もしくはadopt)したという。
* そのオブジェクトがconformしているかどうかチェックするには、conformsToProtocolメソッドを使う。
* そのオブジェクトがoptionalなメソッドを実装しているかどうかをチェックするには、respondsToSelectorを使う。
* コンパイル時に型チェックが行われる。型宣言に<protocol名>を含めるとよい。
* カテゴリもプロトコルにadoptできる。
* プロトコルの名前はユニークでなければならない。
* delegationとはプロトコルで定義されたメソッドを実装したクラスを定義すること。
* informal protocolというものもあるが、これは単に実装がないカテゴリのこと。abstract protocolともいう。ドキュメンテーションやモジュラリティのために用いる。コンパイル時チェックはなし。プロトコルの@optionalディレクトリはObjective-C 2.0で追加されたので、こちらをつかえばよい。
* eclipseでいうデリゲートは、Composite Objectとよばれる


## 例

### myProtocol.h
$$code(lang=objective-c)
#import <Foundation/Foundation.h>

@protocol myProtocol <NSObject>

- (void)f1;
- (void)f2: (id)obj0 withObject1:(id)obj1;

@end
$$/code


### myProtocolImpl.h
$$code(lang=objective-c)
#import <UIKit/UIKit.h>
#import "myProtocol.h"

@interface myProtocolImpl : NSObject <myProtocol>

- (void)f1;
- (void)f2: (id)obj0 withObject1:(id)obj1;

@end
$$/code


### myProtocolImpl.m
$$code(lang=objective-c)
#import "myProtocolImpl.h"

@implementation myProtocolImpl

- (void)f1
{
    NSLog(@"called f0");
}

- (void)f2: (id)obj0 withObject1:(id)obj1
{
    NSLog(@"called f2");
}

@end
$$/code




## 参考

<br>
<iframe src="http://rcm-jp.amazon.co.jp/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=armyofpigs-22&o=9&p=8&l=as4&m=amazon&f=ifr&ref=ss_til&asins=0321811909" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>

