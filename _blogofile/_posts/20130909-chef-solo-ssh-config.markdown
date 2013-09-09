---
categories: ruby, chef
date: 2013/09/09 20:43:04
title: chef soloでAuthenticationFailedといわれたときの対応
---

公開鍵認証なホストに対してパスフレーズ入力無しでsshログインができるにもかかわらず、

$$code(lang=bash)
$ knife solo cook myhost
Running Chef on myhost...
Checking Chef version...
Enter the password for username@myhost:
ERROR: Net::SSH::AuthenticationFailed: username
$$/code

のようにいわれてchef soloの実行に失敗してしまうときがある。

パスフレーズ入力無しでsshできたということは、普通は以下のうちの少くとも1つは満たされている。

1. ssh-agentに対象の秘密鍵が登録されている
2. デフォルトパス($HOME/.ssh/id_rsa とか)に対象の秘密鍵が保存されている
3. ssh_configで秘密鍵を指定している

それなのにsshで失敗してしまうのは、Net:SSHがデフォルトでは公開鍵認証を試行しない場合があるため。 [^1] 
これを回避するには、ssh_configで`PubkeyAuthentication yes`を明示すればよい。


なお、`Net::SSH`がどのような動きをしているかは以下のスニペットを試すとよい。
$$code(lang=ruby)
require 'net/ssh'
Net::SSH.start("myhost", "username", :verbose => :debug) {|x| p x }
$$/code


### 備考

使ったのは以下のバージョン

- chef: 11.6.0
- knife-solo: 0.3.0

[^1]: この挙動は```knife solo```コマンドに`-i`オプションを渡しても変わらなかった。
