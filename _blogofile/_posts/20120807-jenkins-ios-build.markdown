---
categories: jenkins, ios
date: 2012/08/7 15:30:00
title: jenkinsでiosアプリをビルドしてwifi経由で実機インストールする
image: /images/jenkins-logo.png
---

![jenkins](/images/jenkins-logo.png)

はまりどころが多くて大変だったので今後同じことをやろうとする人のために一連の作業をメモしておきます。


## 目的

* jenkinsでiOSアプリをビルドする
* ビルドしたアプリは、UDIDの登録なしに実機確認したい

## 手順

### iOS Developer Enterprise Program への参加

実機インストールするだけなら通常のデベロッパーアカウントでも大丈夫ですが、UDIDの登録なしにwifiから配布するためにはエンタープライズプログラムに参加する必要があります。

エンタープライズプログラムに参加すればapp storeを経由せずに自由にインストールできるようになりますが、アクセスできるのが特定の組織内に限定されるように適切に制限をかけてかなければ規約違反になります。

[https://developer.apple.com/jp/programs/ios/enterprise/](https://developer.apple.com/jp/programs/ios/enterprise/)

### xcodeの設定

[http://golog.plus.vc/iphone/3355/](http://golog.plus.vc/iphone/3355/) などを参考に、xcodeからprovisioning profileを設定します。

また、最近のxcodeではデフォルトではarmv7用バイナリしかビルドしないので、armv6用もビルドするように設定しておきます。
Build SettingsのArchitectures に 'armv6' を手動で追記すれば大丈夫です。

### 実機確認

jenkinsでビルドする際は後述のビルドスクリプトを使うのですが、provisioning profileの設定等が正しくされていることを確認するために、一旦ここでxcodeのUI上で作成したipaファイルをiPhone構成ユーティリティを使って実機インストールしてみます。

[http://support.apple.com/kb/DL1465?viewlocale=ja_JP](http://support.apple.com/kb/DL1465?viewlocale=ja_JP)

ここで正常にインストールできなければ、provisioning profile等の状態を確認してください。

### jenkinsのセットアップ

jenkinsを用意します。ビルド専用機が用意できない場合でも、開発に用いているmacをJNLP経由でそのままスレーブとして使うことができます。

jenkins自体の細かいセットアップ方法は割愛しますが、JNLP経由でスレーブを起動する場合は以下のようなスクリプトをバックグランドで起動するようにしておくと便利です。

$$code(lang=bash)
#!/bin/sh

eval `ssh-agent`
ssh-add ~/.ssh/id_rsa
java -jar slave.jar -jnlpUrl http://jenkins.example.com/computer/mac1/slave-agent.jnlp

$$/code


ここでの注意点は以下のとおりです。

* gitやsvnにssh経由でアクセスする場合は、パスワード無しでチェックアウトできるように適切に設定しておく必要がある。(上記の場合はssh-agentをあらかじめ起動するようにして、パスワード入力は起動時のみになるようにしています。)
* keychainに配布に使用するデベロッパーアカウントの証明書を登録しておく。


### ビルドスクリプトの作成

以下のようなmakefileをxcodeプロジェクトのトップディレクトリに配置します。
(お好みのビルドツールを利用してください)

ソースコードのコンパイルはxcodebuild, ipaファイルの生成はxcrunというコマンドを使います。

$$code(lang=make)

APP_NAME = MyApp
SRCTOP = $(shell pwd)
RELEASE_BUILD_DIR = $(SRCTOP)/build/Release-iphoneos
BUILD_HISTORY_DIR = $(SRCTOP)/build
DEVELOPER_NAME = "iPhone Distribution: XXXX."
PROVISIONING_PROFILE = path/to/in_house.mobileprovision

all:: dist
.PHONY: clean compile dist

dist: compile
	/usr/bin/xcrun -sdk iphoneos PackageApplication -v ${RELEASE_BUILD_DIR}/${APP_NAME}.app -o ${BUILD_HISTORY_DIR}/${APP_NAME}.ipa --sign ${DEVELOPER_NAME} --embed ${PROVISIONING_PROFILE}
	./gen_dist_page.sh

compile:
	xcodebuild

clean:
	rm -rf build

$$/code


配布用のplistとhtmlを生成するスクリプト(gen_dist_page.sh)は以下のようになります。(BUILD_NUMBERなどの変数はjenkinsの環境変数から取得できます)

$$code(lang=bash)
PACKAGE_NAME=MyApp

PLIST=build/${PACKAGE_NAME}.plist
INSTALL_PAGE=build/${PACKAGE_NAME}.html

cat <<__PLIST__ > $PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>items</key>
    <array>
      <dict>
        <key>assets</key>
        <array>
          <dict>
            <key>kind</key>
            <string>software-package</string>
            <key>url</key>
            <string>${DIST_URL}/build/${PACKAGE_NAME}.ipa</string>
          </dict>
          <dict>
            <key>kind</key>
            <string>display-image</string>
            <key>needs-shine</key>
            <true/>
            <key>url</key>
            <string>http://jenkins.example.com/job/myapp/ws/icon.png</string>
          </dict>
        </array>
        <key>metadata</key>
        <dict>
          <key>bundle-identifier</key>
          <string>com.example.myapp.MyApp</string>
          <key>kind</key>
          <string>software</string>
          <key>subtitle</key>
          <string>b${BUILD_NUMBER}</string>
          <key>title</key>
          <string>${PACKAGE_NAME}</string>
        </dict>
      </dict>
    </array>
  </dict>
</plist>
__PLIST__

cat <<__HTML__ > $INSTALL_PAGE
<html>
  <head>
    <title>${PACKAGE_NAME}: build #$BUILD_NUMBER</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    </head>
    <body>
    <div style="text-align: center; vertical-align: middle; margin-top: 100px">
      <div style="padding: 10px;">$JOB_NAME</div>
      <a href="itms-services://?action=download-manifest&url=${DIST_URL}/${PLIST}"
         style="border: none; text-decoration: none; color: #888;">
        <img src="http://jenkins.example.com/job/myapp/ws/demo.png"/>
        <br /><br />
        Install ${PACKAGE_NAME} b$BUILD_NUMBER
      </a>
    </div>
  </body>
</html>
__HTML__
$$/code


htmlはリンク先さえあっていれば大丈夫なのですが、plistの方はいくつか注意が必要です。

* display-imageは必須。iOSのバージョンによってはなくてもよいようなのですが、iOS 5.1.1だと「Appをダウンロードできません」というエラーになります。
* bundle-identifierはxcodeのBundle Identifierと一致させる。


ここではxcodeデフォルトのsdkバージョンを使用していますが、必要に応じてxcodebuild等のコマンドラインオプションを追加してください。

参考:  [https://developer.apple.com/jp/devcenter/ios/library/documentation/FA_Wireless_Enterprise_App_Distribution.pdf](https://developer.apple.com/jp/devcenter/ios/library/documentation/FA_Wireless_Enterprise_App_Distribution.pdf)


### jenkinsのjob作成

通常通りjenkinsのjobを作ります。適切にソースコードをチェックアウトして、ビルドフェーズで上記スクリプトを実行するようにします。

$$code(lang=bash)
make clean && make DIST_URL=${BUILD_URL}artifact
$$/code

ビルドに成功するとipa, html, plistファイルが生成されるので、これらを成果物として保存します。
成果物のhtmlページにiPhoneでアクセスしてみて、アプリがインストールできれば成功です。

## その他

今回は触れませんでしたが、以下についても考慮しておいたほうがよいと思います。

* iOSのSDKバージョン
* 依存ライブラリ
* プロビジョニングプロファイルの管理

また、[TestFlight](https://testflightapp.com/) というサービスもあるのでそちらの利用も検討してみてもいいと思います。

## まとめ

iOSアプリをコマンドラインからビルドするスクリプトを作成して、jenkins上でビルドから配布までを行なうための手順を紹介しました。

## 参考

* [https://developer.apple.com/jp/programs/ios/enterprise/](https://developer.apple.com/jp/programs/ios/enterprise/)
* [http://www.apple.com/jp/support/iphone/enterprise/](http://www.apple.com/jp/support/iphone/enterprise/)
* [https://developer.apple.com/jp/devcenter/ios/library/documentation/FA_Wireless_Enterprise_App_Distribution.pdf](https://developer.apple.com/jp/devcenter/ios/library/documentation/FA_Wireless_Enterprise_App_Distribution.pdf)

