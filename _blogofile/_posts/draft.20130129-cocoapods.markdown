---
categories: ios, ruby, objective-c, xcode, cocoa
date: 2013/1/29 20:00:00
title: CocoaPods
draft: True
---

https://github.com/CocoaPods/CocoaPods
http://tnakamura.hatenablog.com/entry/20120923/cocoapods

$$code
# cocoaopodsインストール
gem install cocoapods

# cocoapodsでインストールしたライブラリのドキュメントも生成したい場合はappledocをいれる
brew install appledoc
$$/code


## CocoaPodsのつかいかた

### 1. ライブラリを探す

$$code
$ pod search base64

-> Base64 (1.0.0)
   RFC 4648 Base64 implementation in Objective-C ARC.
   - Homepage: https://github.com/ekscrypto/Base64
   - Source:   https://github.com/ekscrypto/Base64.git
   - Versions: 1.0.0 [master repo]


-> Base64nl (1.0.2)
   Bae64 is a set of categories that provide methods to encode and decode data as a base-64-encoded string.
   - Homepage: https://github.com/nicklockwood/Base64
   - Source:   https://github.com/nicklockwood/Base64.git
   - Versions: 1.0.2 [master repo]


-> NSData+Base64 (1.0.0)
   Base64 for NSData.
   - Homepage: https://github.com/l4u/NSData-Base64
   - Source:   https://github.com/l4u/NSData-Base64.git
   - Versions: 1.0.0 [master repo]
$$/code

### 2. Podfileの作成

xcodeのプロジェクトファイル(*.xcodeproj)があるディレクトリにPodfileをつくる。
書き方はGemfileとだいたい同じ

$$code(lang=ruby)
platform :ios
pod 'Base64', '~> 1.0'

$$/code

### 3. 依存ライブラリのインストール

これを実行するとxcodeのworkspaceが生成される

$$code
pod install
$$code

### 4. workspaceを開いて開発

依存ライブラリがビルド済みの状態でワークスペース内にあるのでよしなに開発する

## CocoaPodsに自作ライブラリを対応させる

Quicklispと同様、承認制

```pod spec create YourLibrary```

YourLibrary.podspec


## 備考

* xcodeでコマンドラインツールをあらかじめインストールしておく
* gemのバージョンは1.4.0以上
* rvmをつかってる場合は、LLVM GCCのシンボリックリンクをつくっておく  ``` $ ln -s /usr/bin/llvm-gcc-4.2 /usr/bin/gcc-4.2 ```



