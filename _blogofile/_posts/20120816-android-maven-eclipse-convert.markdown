---
categories: android, jenkins
date: 2012/08/16 12:00:00
title: Android Maven Pluginプロジェクトをeclipseにインポートした際にR.javaが生成されなくなる問題の対応
image: /images/android-logo-s.png
---

![android](/images/android-logo-s.png)


androidアプリをコマンドラインでビルドするには[maven-android-plugin](http://code.google.com/p/maven-android-plugin/)が便利ですが、
eclipseで開発したい場合もあると思います。
そういうときは、__mvn eclipse:eclipse__ というコマンドでmavenからeclipse用のプロジェクトを生成できるのですが、そのままではR.javaが生成できなくてエラーがでてしまう場合があります。

mavenコマンドを起動してビルドする分には問題ないのですが、リソースの補完がきかないし精神衛生上もよくないです。
いろいろ試したところ、以下の内容を __.project__ のbuildCommand要素の中に追加すればよいようです。

    <buildCommand>
      <name>com.android.ide.eclipse.adt.ResourceManagerBuilder</name>
    </buildCommand>
    <buildCommand>
      <name>com.android.ide.eclipse.adt.PreCompilerBuilder</name>
    </buildCommand>

.projectを編集する際は一旦eclipseを終了しておいたほうがよいです。


## 参考

* [maven-android-plugin](http://code.google.com/p/maven-android-plugin/)

## 関連記事

* [jenkinsでiosアプリをビルドしてwifi経由で実機インストールする](http://mojavy.com/blog/2012/08/07/jenkins-ios-build/)
