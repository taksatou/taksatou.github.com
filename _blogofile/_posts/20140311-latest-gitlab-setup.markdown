---
categories: chef, gitlab, tips, git
date: 2014/03/11 02:08:20
title: gitlab 6.6.4 CE のゆるふわセットアップ
---

gitlabもCentOSとUbuntuにはパッケージが提供されるようになったので、大分インストールが簡単になりました。

とはいえ、このパッケージはgitlab専用のマシンにインストールすることを前提にしているのか、小規模プロジェクトのために軽く使いたいよう場合ではつらいデフォルト設定となっています。安いvpsとかだと確実にメモリ不足でまともに動きません。

以下はとりあえずプライベートgitリポジトリが欲しいだけのような人のためのgitlabの設定の紹介です。


## 準備

[https://www.gitlab.com/downloads/](https://www.gitlab.com/downloads/ ) 

ここからgitlabのパッケージをダウンロードします。
[omnibus-ruby](https://github.com/opscode/omnibus-ruby) でつくられた全部入りパッケージなのでインストールでのコンフリクトは発生しないはずですが、既に稼動中のサービス(apache等)のことはあまり考慮されてないので使用するポートについては個別対応が必要です。

特に以下は注意が必要です。

* nginx
* redis
* postgresql

ここでは、apacheが稼動しているubuntuにインストールします。


## インストール

普通にインストールします。

$$code
$ sudo dpkg -i gitlab_6.6.4-omnibus-1.ubuntu.12.04_amd64.deb 
$ sudo gitlab-ctl reconfigure
$$/code


ちなみにgitユーザが既に存在しているとこけるので消しておきます

`$ sudo userdel -r git`

## gitlabの設定

gitlabの設定は /etc/gitlab/gitlab.rb に設定をかいて、chefで設定します。

$$code
$ cat /etc/gitlab/gitlab.rb
external_url "http://gitlab.example.com:8081"
unicorn["worker_processes"] = 1
postgresql["shared_buffers"] = "128MB"
postgresql["effective_cache_size"] = "32MB"
$$/code

とりあえずpostgresqlがメモリを大量に食うので適当に減らします。

unicornもメモリ食いがちなので1プロセスにします。

`external_url`にポートも含めたURLをかきます。apacheが80番で起動してるとnginxが起動できないので適当にはずします。ちなみに8080はデフォルトだとgitlabのunicornがつかっています。

このあたりは環境に応じて適当に設定してください。

`gitlab-ctl reconfigure` すると設定が反映されます。

その他の設定できる項目は `/opt/gitlab/embedded/cookbooks/gitlab` 以下の`cookbook`をみるといいです。


## webサーバの設定

80番で起動しているapacheがいる場合はnginxにproxyします。

$$code
<VirtualHost *:80>
  ServerName gitlab.example.com

  DocumentRoot /opt/gitlab/embedded/service/gitlab-rails/public

  CustomLog  /var/log/apache2/gitlab_access.log combined
  ErrorLog   /var/log/apache2/gitlab_error.log

  ErrorDocument 502 /502.html

  <Directory "/opt/gitlab/embedded/service/gitlab-rails/public">
    Options FollowSymLinks
  </Directory>

  <Proxy *>
    AddDefaultCharset off
    Order deny,allow
    Allow from all
  </Proxy>

  ProxyVia On
  ProxyPreserveHost On

  ProxyRequests Off
  ProxyPass /assets/ !
  ProxyPass /uploads/      !

  ProxyPass / http://localhost:8081/ retry=1
  ProxyPassReverse / http://localhost:8081/

</VirtualHost>
$$/code


以上ができたらapache再起動して、 http://gitlab.example.com にアクセスしてみてうまく表示できれば完了です。


