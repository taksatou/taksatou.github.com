---
categories: common lisp, ltsv
date: 2013/2/18 20:30:00
title: LTSV for Common Lisp 作りました
image: /images/lisp-alien-logo.png
---

![lisp](/images/lisp-alien-logo.png)

すっかりブームは過ぎ去ってしまいましたが、意外とまだなかったのでCommon LispのLTSVパーサつくりました。

[https://github.com/taksatou/cl-ltsv](https://github.com/taksatou/cl-ltsv)


### インストール

現在(2013-02-18) quicklisp登録申請中です。登録されれば以下でインストールできます。

$$code
(ql:quickload 'cl-ltsv)
$$/code

### 使い方

以下、使用例です

$$code
CL-USER> (cl-ltsv:parse-line "host:127.0.0.1    ident:- user:frank")
(("host" . "127.0.0.1") ("ident" . "-") ("user" . "frank"))

CL-USER> (with-input-from-string (ss "host:127.0.0.1    ident:- user:frank
host:127.0.0.1  ident:- user:jane
host:127.0.0.1  ident:- user:john")
           (cl-ltsv:with-ltsv-from-stream (entry ss)
             (print entry)))

(("host" . "127.0.0.1") ("ident" . "-") ("user" . "frank")) 
(("host" . "127.0.0.1") ("ident" . "-") ("user" . "jane")) 
(("host" . "127.0.0.1") ("ident" . "-") ("user" . "john")) 
NIL

CL-USER> (cl-ltsv:alist-ltsv '(("host" . "127.0.0.1") ("ident" . "-") ("user" . "frank")))
"host:127.0.0.1 ident:- user:frank"
$$/code


### まとめ

ライブラリにするほどでもなかった気はしますが、Common Lispには文字列のsplitが標準でついてなくてちょっと面倒に感じることもあったのでないよりはましかな、ということで作りました。

フィードバック等ありましたらコメント頂けるとうれしいです。
