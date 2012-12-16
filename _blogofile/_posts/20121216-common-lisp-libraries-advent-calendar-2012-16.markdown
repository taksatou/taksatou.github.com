---
categories: gearman, common lisp
date: 2012/12/16 17:30:00
title: gearmanクライアントライブラリ cl-gearman
image: /images/gearman-logo-80.png
---

![tool](/images/gearman-logo.png)

<b>この投稿は[Common Lisp Libraries Advent Calendar 2012](http://qiita.com/advent-calendar/2012/clladvent)の16日目の記事です。</b>


GearmanをCommon Lispから使いたかったのですが、既存のものが見付からなかったのでcl-gearmanというものをつくってみました。というわけで紹介、もとい宣伝をさせてもらおうと思います。


## Gearmanとは

今更感はありますが、Gearman自体について簡単に説明しておきます。

[http://gearman.org/](http://gearman.org/)

Gearmanとは時間のかかる処理を複数のコンピュータに振り分けるように設計されたオープンソースのアプリケーションフレームワークです。Gearmanを利用するアプリケーションでは、client, job server, workerという3つの要素が存在します。
それぞれの役割は以下の通りです。

* job server: clientから受けとったジョブを適切なworkerに渡す
* client: ジョブを生成してjob serverに送信する
* worker: job serverを経由して、clientによってリクエストされたジョブを実行してそのレスポンスを返す

cl-gearmanは、clientとjob server間、及びworkerとjob server間のプロトコルを抽象化したライブラリです。

余談ですが、Gearmanはデータ永続化をしないものだとずっと思っていたのですがmysqlやsqliteに永続化できます。
ジョブキューを使うなら以前はTheSchwartzという選択肢もありましたが、今はGearmanでほとんどの場合に対応できるのではないでしょうか。

## インストール

まだquicklispに登録されていないので、githubからソースコードをダウンロードして下さい。(後日申請予定)

[https://github.com/taksatou/cl-gearman](https://github.com/taksatou/cl-gearman)

$$code(lang=bash)
cd ~/quicklisp/local-projects
git clone https://github.com/taksatou/cl-gearman.git
$$/code


## 使い方

以下サンプルコードです

### client

submit-jobはjob serverにジョブを送信し、workerがそれを完了するまで待機します。workerが処理を完了するとその返り値が文字列で返されます。

$$code(lang=lisp)

CL-USER> (cl-gearman:with-client (client "localhost:4730")
           (format t "~a~%" (cl-gearman:submit-job client "hello"))
           (format t "~a~%" (cl-gearman:submit-job client "echo" :arg "foo)))
hello
foo
NIL
$$/code

以下のようにしてバックグランドでジョブを実行することもできます。バックグランドでジョブを実行するとjobオブジェクトが即座に返されます。
そのjobオブジェクトをつかって、ジョブのステータスを取得することができます。以下の例では見辛いですが、priorityを付けることでジョブの実行順を多少は制御できます。

$$code(lang=lisp)
CL-USER> (cl-gearman:with-client (client "localhost:4730")
           (let* ((job1 (cl-gearman:submit-background-job client "sleep" :arg "1"))
                  (job2 (cl-gearman:submit-background-job client "sleep" :arg "1" :priority :low))
                  (job3 (cl-gearman:submit-background-job client "sleep" :arg "1" :priority :high))
                  (jobs `(:medium ,job1 :low ,job2 :high ,job3)))

             (dotimes (i 5)
               (loop for (k v) on jobs by #'cddr
                  do (format t "~a: ~a~%" k (cl-gearman:get-job-status client v)))
               (sleep 1))))
MEDIUM: (JOB-HANDLE H:snapper:109 IS-KNOWN 1 IS-RUNNING 1 PROGRESS NAN)
LOW: (JOB-HANDLE H:snapper:110 IS-KNOWN 1 IS-RUNNING 0 PROGRESS NAN)
HIGH: (JOB-HANDLE H:snapper:111 IS-KNOWN 1 IS-RUNNING 0 PROGRESS NAN)
MEDIUM: (JOB-HANDLE H:snapper:109 IS-KNOWN 0 IS-RUNNING 0 PROGRESS NAN)
LOW: (JOB-HANDLE H:snapper:110 IS-KNOWN 1 IS-RUNNING 0 PROGRESS NAN)
HIGH: (JOB-HANDLE H:snapper:111 IS-KNOWN 1 IS-RUNNING 0 PROGRESS NAN)
MEDIUM: (JOB-HANDLE H:snapper:109 IS-KNOWN 0 IS-RUNNING 0 PROGRESS NAN)
LOW: (JOB-HANDLE H:snapper:110 IS-KNOWN 1 IS-RUNNING 0 PROGRESS NAN)
HIGH: (JOB-HANDLE H:snapper:111 IS-KNOWN 1 IS-RUNNING 1 PROGRESS NAN)
MEDIUM: (JOB-HANDLE H:snapper:109 IS-KNOWN 0 IS-RUNNING 0 PROGRESS NAN)
LOW: (JOB-HANDLE H:snapper:110 IS-KNOWN 1 IS-RUNNING 1 PROGRESS NAN)
HIGH: (JOB-HANDLE H:snapper:111 IS-KNOWN 0 IS-RUNNING 0 PROGRESS NAN)
MEDIUM: (JOB-HANDLE H:snapper:109 IS-KNOWN 0 IS-RUNNING 0 PROGRESS NAN)
LOW: (JOB-HANDLE H:snapper:110 IS-KNOWN 0 IS-RUNNING 0 PROGRESS NAN)
HIGH: (JOB-HANDLE H:snapper:111 IS-KNOWN 0 IS-RUNNING 0 PROGRESS NAN)
NIL

$$/code

### worker

workerはadd-abilityで実行できるジョブとそのハンドラをあらかじめ登録する必要があります。
ハンドラは2つの引数をとる関数で、第一引数はclientからのデータ、第二引数はjobオブジェクトです。
り値はprincでフォーマットした文字列としてclientに渡されます。workはジョブが割り当てられるまで待機し、1つのジョブの実行が完了すると戻ります。

$$code(lang=lisp)

(cl-gearman:with-worker (worker "localhost:4730")
  (cl-gearman:add-ability worker "hello"
                          #'(lambda (arg job) "hello"))

  (cl-gearman:add-ability worker "echo"
                          #'(lambda (arg job) arg))

  (cl-gearman:add-ability worker "sleep"
                          #'(lambda (arg job)
                              (sleep (parse-integer arg))
                              (format nil "job:~A finished~%" job)))
                              
  (loop do (cl-gearman:work worker)))

$$/code


### エラーハンドリング

ジョブキューを使う上で悩ましいことの一つはエラー処理だと思いますが、Common Lispのコンディションシステムを使えば柔軟に対応できます。
workerのハンドラでは、skip-job, abort-job, retry-job の3パターンのリトライをサポートしています。

例えば、
$$code(lang=lisp)

(cl-gearman:with-worker (worker "localhost:4730") 
  (cl-gearman:add-ability worker "error"
                          #'(lambda (arg job) (error "something wrong")))

  (loop do (handler-bind ((error #'(lambda (c) (invoke-restart 'cl-gearman:skip-job))))
             (cl-gearman:work worker))))
$$/code

のようにしておけば、エラーが発生したjobを無視することができます。
abort-jobはclientに失敗を通知します。retry-jobは名前の通りハンドラを再度実行します。


## 対応する処理系

メインに開発を行った環境は ubuntu 12.04, sbcl 1.0.55.0.debian です。
一応以下の処理系で動作確認しました

* sbcl 1.0.55.0.debian 
* clisp 2.49
* clozure cl 1.8-r15286M

ffi系のライブラリには依存してないので比較的動かしやすいとは思いますが、動かなければ教えて下さい。

## future work

まだいくつかやり残していることがあります。

#### 複数job server

複数のコネクションをはれるようにしてアプリケーション側でスレッドたてなくてよいように

#### タイムアウト

ポータブルに実装するのがめんどくさそうだったのであとまわしにしてます

#### テスト

ごめんなさいごめんなさい

## まとめ

以上、拙作のcl-gearmanを紹介しました。Common Lispを始めてまだ半年足らずなのでおかしいところがあるかと思いますが、フィードバックを頂けるとうれしいです。

