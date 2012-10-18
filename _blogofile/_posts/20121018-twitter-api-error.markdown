---
categories: twitter, web
date: 2012/10/18 22:00:00
title: 'twitter apiで404: {"errors":[{"message":"Sorry, that page does not exist","code":34}]}'
image: /images/twitter-logo.png
---

![twitter](/images/twitter-logo.png)


最近twitter apiをつかっているサービスで以下のようなエラーがでた。

$$code(lang=javascript)
{"errors":[{"message":"Sorry, that page does not exist","code":34}]}
$$/code


[twitterのデベロッパフォーラム](https://dev.twitter.com/discussions/11595)によると、先週くらいにバージョンがついてないエンドポイントは /oauth を除いて廃止されたらしい。また、ドメインもapi.twitter.comに統一されたらしい。

つまり、api.twitter.com/account/verify_credentials.json とか twitter.com/1/account/verify_credentials.json とか twitter.com/account/verify_credentials.json ではだめで、api.twitter.com/1/account/verify_credentials.json を使えということ。

ログイン直後にverify_credentialsをつかってるアプリは多いと思われるが、その場合ログインに失敗したように見えるので認証まわりをライブラリ任せにしてると原因がわかりにくいかも。

とりあえず[twitterの開発ブログ](https://dev.twitter.com/blog)まめにチェックしたほうがよさそう。



# 参考

* [https://dev.twitter.com/blog](https://dev.twitter.com/blog)
* [https://dev.twitter.com/discussions/11595](https://dev.twitter.com/discussions/11595)
