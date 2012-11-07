---
categories: android, tips
date: 2012/11/07 12:00:00
title: 細かすぎて伝わらないAndroid開発のはまりどころまとめ その1
image: /images/android-logo.png
---

![android](/images/android-logo.png)

その2があるかどうかは知りませんが、これまでandroidアプリを開発しててはまったことがたまってきたのでまとめておきます。順不同です。


## 目次

[TOC]

## onAnimationEndでviewの階層を操作するとNullPointerExceptionでおちる

Viewをフェードアウトして親Viewからremoveする、というような動作をしたい場合に、普通にonAnimationEndの中でremoveViewとかするとNullPointerExceptionでおちます。onAnimationEndの中でViewの階層構造を操作するような処理をしてはだめらしいです。回避するには、Handlerをつかってタイミングをずらしてやるとよいです。

* 参考: [http://stackoverflow.com/questions/5569267/nullpointerexception-that-doesnt-point-to-any-line-in-my-code](http://stackoverflow.com/questions/5569267/nullpointerexception-that-doesnt-point-to-any-line-in-my-code)

## Animationが動かない

AnimationさせるViewには親Viewが存在している必要があります。WindowManagerはViewではないので、WindowManagerにaddViewしたViewをアニメーションさせたい場合は空のRelativeLayoutとかにaddViewしてから、RelativeLayoutのほうをWindowManagerにaddViewしてやる必要があります。

## WindowManagerにaddViewしたときの挙動

WindowManagerにもaddViewできますが、通常のViewとは挙動が違います。

* 背景透過はWindowManager.LayoutParam.format に TRANSLUCENT をセットすればよいです。
* dimでフェードインできますが、その際のdurationを変更する方法は分かりませんでした。
* BACKボタンはきかなくなります。自分でKeyEventを処理してやる必要があります。android.widget.PopupWindowのdispathKeyEventのソースが参考になります。

## Activityが横向きでスタートした場合と縦向きでスタートしたときで表示倍率が違う

* 参考：[http://d.hatena.ne.jp/acidgraphix/20110126/1296018143](http://d.hatena.ne.jp/acidgraphix/20110126/1296018143)

## onCreateが何回もよばれる

回転やキーボード表示のタイミングでもonCreateがよばれます。AndroidManifest.xmlでconfigChangesを設定することで回避できます。

* 参考: [http://stackoverflow.com/questions/2606470/unexpected-resume-of-package-name-while-already-resumed-in-package-name-err](http://stackoverflow.com/questions/2606470/unexpected-resume-of-package-name-while-already-resumed-in-package-name-err)

## popupWindowのサイズが変わらない

popupWindowのsetWidth, setHeightは次回以降の表示サイズしか変えられません。既に表示しているポップアップウィンドウのサイズはそのままです。invalidateしても無駄です。

## HttpURLConnectionが 0byteのresponseを返す

コネクションプールとkeepaliveがらみで問題が発生する場合があるみたいです。SDKのバージョンとウェブサーバ側の設定も影響します。
```System.setProperty("http.keepAlive", "false")``` で回避はできるようです。これに遭遇したときは、org.apache.http.impl.client.DefaultHttpClientの方を使うことにしたので詳細は追ってません。

* 参考: [http://stackoverflow.com/questions/1440957/httpurlconnection-getresponsecode-returns-1-on-second-invocation](http://stackoverflow.com/questions/1440957/httpurlconnection-getresponsecode-returns-1-on-second-invocation)

## org.apache.http.impl.client.DefaultHttpClientがすごく遅い

httpsでリクエストを投げると、ウェブサーバ側の負荷が高いわけでもネットワークが細いわけでもないのに、返ってくるまでなぜか数秒かかる場合があります。こちらもkeepaliveがらみの問題っぽいです。これもウェブサーバ側の設定が影響します。
試した限りでは以下のような状況でした。

* setHeader("Connection", "close") しても効果なし
* setKeepAliveStrategyでdurationを 0とか1にしても効果なし
* Connection closeしないウェブサーバならすぐレスポンスが返ってくる
* httpならすぐレスポンスが返ってくる

[ここ( http://hc.apache.org/httpclient-3.x/sslguide.html )](http://hc.apache.org/httpclient-3.x/sslguide.html) のKnown limitations and problemsをみるとそれっぽい既知の問題があるようですが、根が深そうだったので詳細は追ってません。

## eclipseのAndroid pluginが動かなくなった

なぜかeclipseでAndroid pluginが動かなくなるときがありました。詳細をメモるのを忘れてしまいましたが、以下の手順で直ったような気がします。

1. Android Support Libraryをアンインストール
2. eclipse再起動
3. 新しいAndroidプロジェクトを作るとダイアログでライブラリのインストールを促されるのでそれに従う
4. android プラグインをアップデート

## WebViewで表示されるコンテンツが小さすぎる

通常ビューのスケールとWebViewのスケールは別です。setScaleで調整する必要があります。
これはたぶんiOSでも同様かと。

## java.lang.RuntimeException: Stub!

android.jar内のコードはdalvikvmの外で実行することはできません。問答無用でタイトルの例外が飛びます。
エラーメッセージはもうちょいなんとかならなかったのか。

参考

* [http://stackoverflow.com/questions/7247502/using-android-jar-in-java-project-runtimeexception-stub](http://stackoverflow.com/questions/7247502/using-android-jar-in-java-project-runtimeexception-stub)
* [http://www.slideshare.net/miyatay/abc2011w](http://www.slideshare.net/miyatay/abc2011w)

## jarとして配布するandroidライブラリ内にリソースを埋め込むことはできない

リソースIDを列挙しているRパッケージはjarにそのまま入れることはできますが、そのリソースIDは不正なものとなります。
ライブラリにリソースを含めたい場合は、ソースも含めたプロジェクトをまるごと配布するしかないようです。

ごく小さなアイコン画像だけとかであればバイナリデータをソース中に埋め込んでしまう、というのも手です。
iOSならBundleという仕組みがあります。


## android-maven-plugin から mvn eclipse:eclipse でeclipse用にエクスポートすることはできない

androidでもmavenは使えますが、androidのmavenプロジェクトは通常の方法(mvn eclipse:eclipse)ではeclipseにインポートできません。
以下のファイルを手動でつくってみたらとりあえずいけました。

* .classpath
$$code(lang=xml)
<?xml version="1.0" encoding="UTF-8"?>
<classpath>
        <classpathentry kind="src" path="src/main/java"/>
        <classpathentry kind="src" path="gen"/>
        <classpathentry kind="con" path="com.android.ide.eclipse.adt.ANDROID_FRAMEWORK"/>
        <classpathentry kind="con" path="com.android.ide.eclipse.adt.LIBRARIES"/>
        <classpathentry kind="output" path="bin/classes"/>
</classpath>
$$/code

* .project
$$code(lang=xml)
<?xml version="1.0" encoding="UTF-8"?>
<projectDescription>
        <name>project-name</name>
        <comment></comment>
        <projects>
        </projects>
        <buildSpec>
                <buildCommand>
                        <name>com.android.ide.eclipse.adt.ResourceManagerBuilder</name>
                        <arguments>
                        </arguments>
                </buildCommand>
                <buildCommand>
                        <name>com.android.ide.eclipse.adt.PreCompilerBuilder</name>
                        <arguments>
                        </arguments>
                </buildCommand>
                <buildCommand>
                        <name>org.eclipse.jdt.core.javabuilder</name>
                        <arguments>
                        </arguments>
                </buildCommand>
                <buildCommand>
                        <name>com.android.ide.eclipse.adt.ApkBuilder</name>
                        <arguments>
                        </arguments>
                </buildCommand>
        </buildSpec>
        <natures>
                <nature>com.android.ide.eclipse.adt.AndroidNature</nature>
                <nature>org.eclipse.jdt.core.javanature</nature>
        </natures>
</projectDescription>
$$/code

* project.properties
$$code(lang=properties)
# Project target.
target=android-10

# if it is a library
# android.library=true
$$/code

まあ、なんというか、Androidはいろいろ残念ですね。

iOSはこういう仕様なのかバグなのかよくわからないようなものが少ないし、OSバージョンの入れ換わりが早くて対応バージョンも少なくて済む分、個人的な体感ではandroidアプリの工数はiOSの3割増しという感じ。
