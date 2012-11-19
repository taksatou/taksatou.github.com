---
categories: tips, web
date: 2012/11/20 02:30:00
title: ウェブエンジニアのためのオンラインツールまとめ
image: /images/tool-logo.png
---

![tool](/images/tool-logo.png)

[The Web engineer's online toolbox](http://ivanzuzak.info/2012/11/18/the-web-engineers-online-toolbox.html)というまとめ記事が便利そうだったので、実際に試しつつ抄訳してみました。(一部のコメントと体裁は変えています。)

## 目次

[TOC]

## 一覧

### [RequestBin](http://requestb.in/)

httpリクエストを保存するエンドポイントを作ってくれる。

Create a RequestBin のボタンをクリックするとURLが表示されるので、そこをHTTPクライアントからたたくとRequestBin側にリクエスト内容が記録される。
ソースも公開されてるのでローカルで立ちあげることもできる。

githubの[webhookのhelp](https://help.github.com/articles/testing-webhooks)も参考にどうぞ。


### [Hurl](http://hurl.it)

httpリクエストを実行してくれる。パーマリンクも作ってくれるので、POSTリクエストもコピペで他の人と共有できる。

* 類似サービス: [REST test test](http://resttesttest.com/) ,  [Apigee console](https://apigee.com/console/others) 

### [httpbin](http://httpbin.org/)

HTTPリクエスト側でレスポンスのHTTP status codeやレスポンスやリダイレクト、cookieなどを制御できる。HTTPクライアントのテストに便利。

* 類似サービス: [UrlEcho](http://ivanzuzak.info/urlecho/)

### [REDbot](http://redbot.org/)

HTTPのリソースをチェックしてくれる。問題を検出したら改善案のサジェストもしてくれる。

* 類似サービス: [HTTP lint](http://zamez.org/httplint)

### [WebGun](http://webgun.io/)

webhookを簡単に作るためのAPIを提供している。現在はまだベータっぽい。

### [Apify](http://apify.heroku.com)

ウェブページをスクレイピングしてJSON API化してくれる。
CSSセレクタかxpathに名前をつけて設定するだけでよしなにやってくれる。

[試しに元記事をAPI化してみた](http://apify.heroku.com/resources/50a99278a7301c000200005a)

### [Unicorn](http://validator.w3.org/unicorn/)

前述の[REDbot](http://redbot.org/)はHTTPをチェックしてくれるけど、こちらはHTMLドキュメントがW3Cに準拠してるかをバリデートしてくれる。

* 類似サービス: [HTML lint](http://lint.brihten.com/html/)

### [Feed validator](http://validator.w3.org/feed/)

こちらはRSSとATOMフィードをバリデートしてくれる。

### [Link checker](http://validator.w3.org/checklink)

リンクを再帰的にたどって、重複やリンク切れをチェックしてくれる。

### [Host tracker](http://www.host-tracker.com/)

ウェブサイトのモニタリングサービス。定期的にpingして、問題があった場合はメール通知してくれる。

* 類似サービス: [Down for everyone or just me](http://www.downforeveryoneorjustme.com/), [Pimgdom ping service](http://tools.pingdom.com/ping/)

### [Pingdom Full page test](http://tools.pingdom.com/fpt/)

ウェブページのロード時間を計測、解析してくれる。リクエストを実行するサーバは米国しかないので国内だとちょっと使いづらい。
類似サービスの[Web page test](http://www.webpagetest.org/)ならTokyoが選べる。

### [HAR viewer](http://www.softwareishard.com/har/viewer/)

HTTP tracking toolsで生成されたHTTP Archive (HAR)形式のログをビジュアライズしてくれる。

### [CORS proxy](http://www.corsproxy.com/)

クロスドメインでjsを実行できるようにヘッダを追加してレスポンスしてくれるプロキシ。

### [Browserling](https://browserling.com/)

ブラウザ上で動くインタラクティブなクロスブラウザ。メジャーなブラウザは大体サポートされている。
動作は重いけど表示確認くらいになら無料のままでも使えそう。

### [WebSocket Echo Test](http://www.websocket.org/echo.html)

WebSocketをテストできるエコーサーバ。

### [YQL](http://developer.yahoo.com/yql/)

ウェブサービスからとってきたデータをSQLっぽい言語で整形できる。

### [Yahoo Pipes](http://pipes.yahoo.com/pipes/)

ウェブサービスをGUIでマッシュアップできる。

### [Apiary](http://apiary.io/)

良い感じのREST APIドキュメントをインタラクティブなインスペクタをつかってジェネレートできる。まだベータ。

* 類似サービス: [Swagger](http://swagger.wordnik.com/)
 
## おわりに

* いくつかのツールはサーバに負荷をかけてしまう可能性があるので注意してつかってください。
* 他にもなにかあれば教えてもらえるとうれしいです。
