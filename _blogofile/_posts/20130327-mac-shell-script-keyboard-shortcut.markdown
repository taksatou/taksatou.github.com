---
categories: mac, tips, shell
date: 2013/03/28 02:50:01
title: Mac OSXでシェルスクリプトをキーボードショートカットに登録する方法
image: /images/automator.png
---

![automator](/images/automator.png)

概要を以下にメモ

1. Automatorを起動
2. サービスを選択
3. 右ペインの上部、「次の選択項目を受け取ります」を入力なしにする
4. 左ペインからシェルスクリプトを実行をダブルクリック
5. デフォルトで`cat`になっている内容を任意のシェルスクリプトにする
6. 右上の実行ボタンからテスト
7. 右上の記録ボタンから適当な名前をつけて保存して閉じる
8. システム環境設定＞キーボードを開く
9. キーボードショートカットのタブを選択
10. サービスを選択してさっき保存したautomatorの名前をみつける
11. 好きなショートカットを設定する


参考: [http://superuser.com/questions/45740/fast-user-switching-apple-menu/46308#46308](http://superuser.com/questions/45740/fast-user-switching-apple-menu/46308#46308)


#### 備考

* 新規作成したworkflowは保存して閉じるまでシステム設定のキーボードショートカットの項目に反映されない
* workflowは$HOME/Library/Services に保存される

