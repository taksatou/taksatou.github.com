---
categories: programming, project management, tools
date: 2015/03/02 20:55:43
title: Phabricatorを使ったワークフローについて
image: /images/phabricator-logo.png
---

![phabricator](/images/phabricator-logo.png) 


最近 [Phabricator](http://phabricator.org/ ) を使ったワークフローを試しています。FacebookやDropboxをはじめとして海外では割と良く使われているようですが、あまり国内には情報がないようなのでまとめておきます。


## Phabricatorでできること

Phabricatorはコードレビューがメイン機能のようですが、それに留まらずソフトウェアの開発で必要なものがワンストップでまとまったプロジェクト管理ツールになっています。

メニューのネーミングが独特でとっつきづらいですが、主に以下のような機能があります。

* `Differential`: pre push型のコードレビュー
* `Audit`: post push型のコードレビュー
* `Maniphest`: タスクとバグの管理
* `Diffusion`: リポジトリの管理
* `Harald`: commitやタスクの更新イベントにフックして起動する処理の管理
* `Phriction`: Wiki

また、[arcanist](https://github.com/phacility/arcanist ) というコマンドラインから操作するためのツールも別途提供されており、開発のワークフローも含めた統合が意図されているようです。

## セットアップ

docker環境があるなら `docker run yesnault/docker-phabricator` ですぐ試せます。

[https://registry.hub.docker.com/u/yesnault/docker-phabricator/](https://registry.hub.docker.com/u/yesnault/docker-phabricator/ ) 

ただし、上記dockerfileから構築したコンテナはデフォルトだとメールは外部に送信できない設定になっています。admin以外のユーザ登録ではメールアドレス認証が必要なので、`docker exec -it <container_id> bash` でコンテナに入ってメール設定を適宜修正して下さい。

dockerを使わずに普通にインストールする場合は [https://secure.phabricator.com/book/phabricator/article/installation_guide/](https://secure.phabricator.com/book/phabricator/article/installation_guide/ ) を参照してください。

起動直後は色々設定を聞かれますが、特につまるようなところはないので省略します。

## Phabricatorでのコードレビュー

### pre-push型のコードレビュー (Differential)

pre-push型のコードレビューは、フロー的にはGithubでのPull Requestに似ていますが、レビュー対象のコードをpushするのではなく、パッチを送る点が異なります。Phabricatorでは以下のようなフローで作業することになります。

1. コードを修正した人(author)は、レビュワー(reviewer)を指定して変更内容をDifferentialに送る
2. reviewerは通知を受けてレビューをする
3. reviwerがacceptしたら、authorはupstreamにpushする

diffをPhabricatorにコピペして登録することもできますが、基本的にはarcanist経由で作業することになります。

PhabricatorのUser Guideには[Differentialの良さ](https://secure.phabricator.com/book/phabricator/article/reviews_vs_audit/ ) が長々と書かれてますが、実際のところ、長所として挙げられている項目はどれもPull Requestベースでも達成できます。
ただ、Defferentialとarcanistを使えば簡単にレビュー依頼が投げられるので、開発者が自発的に適切な粒度でレビュー依頼する助けにはなりそうです。

### post-push型のコードレビュー (Audit)

Differentialではレビューが完了するまでpushを待つ必要がありますが、Auditはレビューを待たずにpushしてその後にレビューを実施するための機能です。

例えば、急いでリリースする必要がある場合でも、Auditを用いてあとからレビューすることができます。このときに問題が見つかれば`Problem Commits`というフラグをたてておいてタスクに積む、というような使い方になるようです。

`Harald`という機能を使えば特定の条件に合致するcommit(例えば変更が大きい、Differentialでレビューされていない、等)があった場合は自動的にAuditを生成させることもできます。

Auditをpull requestのように使うこともできますが、推奨はされていないようです。


## 所感

もし開発管理のためにredmineやjiraをつかっているのであればPhabricatorは良い代替になりそうです。開発者向けに特化してる分、プロジェクトのタスクやバグ管理がソースコードとうまく統合されていて、ダッシュボードも柔軟にカスタマイズできます。githubのissueに不満を感じている人もPhabricatorのワークフローは試してみる価値があると思います。

レビューツール単体としてみると、(Differentialをつかうなら)開発者にarcanistの導入をしてもらう必要がある分、Pull Requestの手軽さに比べるとやや煩雑に感じました。既にPull Requestベースの開発が定着していて、単によりよいレビューツールを探しているのであれば[Gerrit](https://code.google.com/p/gerrit/ ) 等のほうが導入しやすいかもしれません。

## その他

* [https://showoff.phab.io/](https://showoff.phab.io/ ) でデモPhabricatorが使えるので一通り試せます。
* デフォルトではかなりの頻度でリポジトリに対してポーリングしに行きます。負荷をかけ過ぎないように注意が必要です。
* Phabricator自体もそれなりの性能のマシンが必要です。環境によってはworker数を減らしたりmysqlのメモリサイズを調整しておく必要があります。

## 参考

* [https://secure.phabricator.com/book/phabricator/article/differential/](https://secure.phabricator.com/book/phabricator/article/differential/ ) 
* [https://secure.phabricator.com/book/phabricator/article/audit/](https://secure.phabricator.com/book/phabricator/article/audit/ ) 
* [https://secure.phabricator.com/book/phabricator/article/reviews_vs_audit/](https://secure.phabricator.com/book/phabricator/article/reviews_vs_audit/ ) 
