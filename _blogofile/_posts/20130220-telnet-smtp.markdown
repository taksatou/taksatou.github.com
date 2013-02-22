---
categories: smtp, postfix, tips
date: 2013/2/20 23:55:00
title: 
image: /images/cl-rainbow-demo.png
draft: True
---

![lisp](/images/cl-rainbow-demo.png)

新しくvpsを立ちあげたときとかにたまにpostfixの設定をするときがあるのですが、何回やっても設定がよくわからなくて適当にコピペしたらうまく動かなくて時間を無駄にする、というパターンを繰り返してしまうので最低限のsmtpプロトコルを理解しておこうと思い立たちました。

プロトコルを理解するには実際に話してみるのが手っ取り早いということで、telnetで自分のgmailアドレスにメールしてみたときのメモを以下に残しておきます。

## 以下手順メモ

### 1. 該当メールアドレスのMXレコードを調べる

普通のメールアドレスの@以下はドメイン名になっている場合がほとんどですが、DNSのAレコードに登録されているのはホスト名なのでメールサービスを提供しているホスト名を調べる必要があります。そのときに使うのがMXレコードで、nslookupでも以下のようにして調べることができます。

$$code
% nslookup -type=mx gmail.com
Server:         192.168.1.1
Address:        192.168.1.1#53

Non-authoritative answer:
gmail.com       mail exchanger = 5 gmail-smtp-in.l.google.com.
gmail.com       mail exchanger = 10 alt1.gmail-smtp-in.l.google.com.
gmail.com       mail exchanger = 20 alt2.gmail-smtp-in.l.google.com.
gmail.com       mail exchanger = 30 alt3.gmail-smtp-in.l.google.com.
gmail.com       mail exchanger = 40 alt4.gmail-smtp-in.l.google.com.

Authoritative answers can be found from:

$$/code

複数のホストが優先度をつけて登録されているので、この場合は *gmail-smtp-in.l.google.com* を使えばいいのかな。

### 2. telnetで25番ポートに接続してsmtpを話す

テキストベースのプロトコルなのでtelnetからそのままsmtpサーバとやりとりできます。
smtpプロトコルの詳細は省略しますが、最低限必要なコマンドは以下の5つだけ。

* HELO - 通信開始
* MAIL FROM - 送信元メールアドレス。ドメインのIPと送信元のIPが一致している必要がある。dynamic DNSのドメイン名でも大丈夫。ユーザ名部分は実際に存在しなくてもよい(その場合は返信を受けとれない)
* RCPT TO - 送信先メールアドレス。
* DATA - メール本体の開始。'.'(ピリオド)だけの行で本文終了。本文のFromとToはなんでもよい。普通のメーラのfromやtoで表示されるのはここの情報
* QUIT - 通信終了

$$code
% telnet gmail-smtp-in.l.google.com 25
Trying 173.194.79.26...
Connected to gmail-smtp-in.l.google.com.
Escape character is '^]'.
220 mx.google.com ESMTP k8si26817952pax.291 - gsmtp
HELO
250 mx.google.com at your service
MAIL FROM:<username@yourhostname>
250 2.1.0 OK k8si26817952pax.291 - gsmtp
RCPT TO:<username@gmail.com>
250 2.1.5 OK k8si26817952pax.291 - gsmtp
DATA
354  Go ahead k8si26817952pax.291 - gsmtp
Subject: xxx
From: yyy
To: zzz


.
250 2.0.0 OK 1361347877 k8si26817952pax.291 - gsmtp
QUIT
221 2.0.0 closing connection k8si26817952pax.291 - gsmtp
Connection closed by foreign host.
$$/code

### 3. メールの確認

gmail上でメールがきているか確認します。DATA部分を適当に書くとスパム判定されてしまうけど一応届くはず。

## postfixの設定

上記は直接gmailのsmtpサーバで送信しましたが、mailコマンドでローカルのpostfix経由で送るにはpostfixを適切に設定する必要があります。

なんでmydomainとmyhostnameとmyoriginにわかれてるのかいまいちよくわからず適当に設定してましたが、MXレコードの意味とMAIL FROMのドメインが送信元IPと一致しなければならないことがわかって理解できました。

MAIL FROM で使われるのはmyoriginの値になるようなので、送信できればいいだけならmyoriginさえあわせておけばとりあえず大丈夫っぽいです。
(myoriginをmydomainにしたいのであればMXレコードにmyhostnameを登録すればよい、ということになるのかな？)

ちなみに、debianのaptからpostfixを「ローカルのみ」の設定でインストールしてしまうと、デフォルトのmain.cfにリレーしない設定になっているので、main.cfを以下のようにコメントアウト。

$$code
# default_transport = error
# relay_transport = error
$$/code


## その他

sakura vpsのお試し期間中はメール送信できない仕様なので、sakura vpsで試す際は注意。これを知らずにはまってしまいました。

http://vps.sakura.ad.jp/terms.html

