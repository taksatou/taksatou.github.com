---
categories: aws, python
date: 2012/08/21 12:00:00
title: ec2へのログインを簡単にするコマンド
image: /images/aws-logo-s.png
---

![aws](/images/aws-logo-s.png)

ec2にログインする際いちいちpublic DNSをAWS Console上で確認するのは面倒なので、
AWS SDKを利用してNameからログインできるようにシェルコマンドを書いておくと便利。

* 例
$$code(lang=bash)
ssh-aws .ssh/ec2.pem <instance_name> -r <region>
$$/code

<script src="https://gist.github.com/3412524.js?file=.zshrc"></script>

