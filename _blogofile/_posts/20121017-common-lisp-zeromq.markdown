---
categories: common lisp, sbcl, zeromq
date: 2012/10/17 00:00:00
title: Common LispでZeroMQを試す
image: /images/zeromq-logo.png
---

![zeromq](/images/zeromq-logo.png)

Common LispでZeroMQを試してみた。

使用環境は以下のとおり

* OS: Ubuntu 12.04 LTS
* Common Lisp 処理系：[sbcl (1.0.55.0.debian)](http://www.sbcl.org/)
* [ZeroMQ 2.2.0](http://download.zeromq.org/zeromq-2.2.0.tar.gz)



# 1. quicklispのインストール

以下を参考にquicklispをインストールする。

* [Quicklisp](http://www.quicklisp.org/beta/)
* [第2回 Quicklispによるライブラリ環境](http://modern-cl.blogspot.jp/2011/03/quicklisp.html)

$$code(lang=lisp)
(load "quicklisp.lisp")
(quicklisp-quickstart:install :path "/home/takayuki/.quicklisp/")
(ql:add-to-init-file)
$$/code

# 2. cl-zmqのインストール

$$code(lang=lisp)
(ql:quickload :zeromq)
$$/code

ここで以下のようなエラーがでる場合はzeromqのインストールができていないか、ld.so.confに問題がある。zeromqをインストールして sudo ldconfig すればちゃんとロードされるはず。

$$code(lang=bash)
debugger invoked on a LOAD-FOREIGN-LIBRARY-ERROR in thread
#<THREAD "initial thread" RUNNING {10029990A3}>:
  Unable to load any of the alternatives:
   ("libzmq.so.0.0.0" "libzmq.so")

Type HELP for debugger help, or (SB-EXT:QUIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [RETRY          ] Try loading the foreign library again.
  1: [USE-VALUE      ] Use another library instead.
  2: [TRY-RECOMPILING] Recompile package and try loading it again
  3: [RETRY          ] Retry
                       loading FASL for #<CL-SOURCE-FILE "zeromq" "package">.
  4: [ACCEPT         ] Continue, treating
                       loading FASL for #<CL-SOURCE-FILE "zeromq" "package"> as
                       having been successful.
  5: [ABORT          ] Give up on "zeromq"
  6:                   Exit debugger, returning to top level.

(CFFI::FL-ERROR
 "Unable to load any of the alternatives:~%   ~S"
 ("libzmq.so.0.0.0" "libzmq.so"))
0] 2
$$/code


以下のようにしてライブラリのパスを設定してやっても回避はできるがおすすめしない。

$$code(lang=lisp)
(pushnew "/path/to/lib/" *foreign-library-directories*)
$$/code

[http://common-lisp.net/project/cffi/manual/html_node/_002aforeign_002dlibrary_002ddirectories_002a.html](http://common-lisp.net/project/cffi/manual/html_node/_002aforeign_002dlibrary_002ddirectories_002a.html)


# 3. サーバ側起動

[cl-zmq](http://www.cliki.net/cl-zmq) のサンプルコード参考に以下のソースをserver.lispに保存して、 sbcl --script server.lisp で実行。ちなみに、127.0.0.1:5555 の部分をlocalhost:5555のように書くとNo such deviceといわれる。 (参考 [Why doesn't zeromq work on localhost?](http://stackoverflow.com/questions/6024003/why-doesnt-zeromq-work-on-localhost) )

$$code(lang=lisp)
(load "~/.sbclrc")
(ql:quickload :zeromq)

(defun server ()
  "Bind to socket and wait to receive a message.  After receipt,
  return the message \"OK\"."
  (zmq:with-context (ctx 1)
    (zmq:with-socket (socket ctx zmq:rep)
      (zmq:bind socket "tcp://127.0.0.1:5555")
      (loop
         (let ((query (make-instance 'zmq:msg)))
           (zmq:recv socket query)
           (format t "Recieved query: '~A'~%"
                   (zmq:msg-data-as-string query) ))
         (zmq:send socket (make-instance 'zmq:msg :data "OK")) ))))

(server)
$$/code

# 4. クライアント側起動

こちらも同様に、client.lispに保存して、sbcl --script client.lispで実行。うまくいけばサーバ側からエコーが返ってくる。

$$code(lang=lisp)
(load "~/.sbclrc")
(ql:quickload :zeromq)

(defun client ()
  "Connects to a socket and passes a message and waits to receive the
  \"OK\" from the server."
  (zmq:with-context (ctx 1)
    (zmq:with-socket (socket ctx zmq:req)
      (zmq:connect socket "tcp://127.0.0.1:5555")
      (zmq:send socket (make-instance 'zmq:msg
                                      :data "SELECT * FROM mytable" ))
      (let ((result (make-instance 'zmq:msg)))
        (zmq:recv socket result)
        (format t "Recieved string: '~A'~%"
                (zmq:msg-data-as-string result) )))))

(client)
$$/code


# まとめ

Common Lisp(sbcl)でZeroMQを利用して、簡単なエコーサーバ/クライアントを実装した。

# 備考

* cl-zmq自体はasdfでインストールできるようにはなっているみたいだけど、asdfではiolibがうまくはいらなかった

# 参考

* [cl-zmq](http://www.cliki.net/cl-zmq)
* [Why doesn't zeromq work on localhost?](http://stackoverflow.com/questions/6024003/why-doesnt-zeromq-work-on-localhost)
