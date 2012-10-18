---
categories: objective-c, ios, common lisp, zeromq
date: 2012/10/17 18:00:00
title: iOSでZeroMQを試す
image: /images/zeromq-logo.png
---

![zeromq](/images/zeromq-logo.png)

[前回Common LispでZeroMQを試してみた](http://mojavy.com/blog/2012/10/17/common-lisp-zeromq/)が、今度はiOSからも試してみた。[ZeroMQのライセンス](http://www.zeromq.org/area:licensing)はLGPLだが、static linking exceptionがあるのでiPhoneアプリに組み込んでもソースは公開しなくて大丈夫なはず。(勘違いしてたらごめんなさい)

# ZeroMQをiPhone用にビルド

ZeroMQはautotoolsで作成されておりconfigure && make でビルドできるようになっているが、iPhone用にクロスコンパイルをするためには適切なオプションを与えてやる必要がある。

一応、[本家サイト上にもドキュメント](http://www.zeromq.org/build:iphone)はあるが最新のXcodeではうごかない。また、シミュレータ用でもうごかせるようにしておきたい。というわけで、以下のようなビルドスクリプトを書いた。

<script src="https://gist.github.com/3899653.js"> </script>

これをZeroMQのtarを展開してできたディレクトリにbuild.shとかで保存して実行すると、armv7とi386に対応したlibzmq.aができる。

$$code(lang=bash)
$ tar xzf zeromq-2.2.0.tar.gz
$ cd zeromq-2.2.0
$ ./build.sh
$ file libzmq.a
libzmq.a: Mach-O universal binary with 2 architectures
libzmq.a (for architecture armv7):      current ar archive random library
libzmq.a (for architecture i386):       current ar archive random library
$$/code

このlibzmq.aと、includeディレクトリの中身をXcodeにインポートしてやればよい。
このときに、XcodeでOther Linker Flags に -lstdc++ を追加してやるのを忘れないように。


# ZeroMQを用いた簡易チャットアプリ

サンプルとしてチャットアプリを実装してみる。
チャットでの発言はREQ/REPを用いてアプリ→サーバに渡し、PUB/SUBを用いてサーバ→アプリにブロードキャストする。


## サーバ側

サーバ側はCommon Lispで実装した。単に、rep-sockから発言を受け取ってpub-sockにそのまま流すだけ。

$$code(lang=lisp)
(load "~/.sbclrc")
(ql:quickload :zeromq)

(defun pull-and-publish ()
  (zmq:with-context (ctx 1)
    (zmq:with-socket (rep-sock ctx zmq:rep)
      (zmq:bind rep-sock "tcp://127.0.0.1:5555")

      (zmq:with-context (ctx2 1)
        (zmq:with-socket (pub-sock ctx2 zmq:pub)
          (zmq:bind pub-sock "tcp://127.0.0.1:5556")

          (loop
             (let ((msg (make-instance 'zmq:msg)))
               (zmq:recv rep-sock msg)
               (zmq:send rep-sock (make-instance 'zmq:msg :data "ok"))
               (zmq:send pub-sock msg))))))))

(pull-and-publish)
$$/code

REQ/REPではなくPULL/PUSHでもできるはずだが、なぜかcl-zmqではpullがつかえなかったのでREQ/REPをつかった。

## アプリ側

[objective-c版ZeroMQ](https://github.com/jeremy-w/objc-zmq)もあるけど、今回はそのままCのAPIを利用した。
以下はソースの抜粋。

$$code(lang=objc)
#import "ChatViewController.h"
#import "include/zmq.h"

@interface ChatViewController () {

    void *ctx1, *ctx2;
    void *subsock, *reqsock;

    NSMutableArray *messageList;
}
@end

@implementation ChatViewController

@synthesize nickname;
@synthesize timer;

- (void)viewDidLoad
{
    [super viewDidLoad];

    ctx1 = zmq_init(1);
    subsock = zmq_socket(ctx1, ZMQ_SUB);
    zmq_setsockopt(subsock, ZMQ_SUBSCRIBE, "", 0);
    int rc = zmq_connect(subsock, "tcp://127.0.0.1:5556");
    assert(rc == 0);

    ctx2 = zmq_init(1);
    reqsock = zmq_socket(ctx1, ZMQ_REQ);
    rc = zmq_connect(reqsock, "tcp://127.0.0.1:5555");
    assert(rc == 0);

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(observeSocket) userInfo:nil repeats:YES];
    messageList = [[NSMutableArray alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.timer invalidate];
    zmq_close(subsock);
    zmq_close(reqsock);
    zmq_term(ctx1);
    zmq_term(ctx2);
}

- (void)observeSocket
{
    zmq_msg_t msg;
    int rc = zmq_msg_init(&msg);
    assert(rc == 0);

    do {
        rc = zmq_recv(subsock, &msg, ZMQ_NOBLOCK);
        if (rc == EAGAIN) {
            NSLog(@"no data available");
        } else if (rc == ENOTSUP) {
            NSLog(@"ENOTSUP");
        } else if (rc == EFSM) {
            NSLog(@"EFSM");
        } else if (rc == ETERM) {
            NSLog(@"ETERM");
        } else if (rc == ENOTSOCK) {
            NSLog(@"ENOTSOCK");
        } else if (rc == EINTR) {
            NSLog(@"EINTR");
        } else if (rc == EFAULT) {
            NSLog(@"EFAULT");
        } else if (rc == 0) {
            size_t siz = zmq_msg_size(&msg);
            void *dat = zmq_msg_data(&msg);
            NSString *str = [[NSString alloc] initWithData:[NSData dataWithBytes:dat length:siz] encoding:NSUTF8StringEncoding];
            [messageList insertObject:str atIndex:0];
        } else {
            NSLog(@"unknown");
        }
    } while (rc == 0);
    zmq_msg_close(&msg);
    [self.tableView reloadData];
}

- (IBAction) saySomething:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"text input"
                                message:@""
                               delegate:self
                      cancelButtonTitle:@"cancel"
                      otherButtonTitles:@"ok", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    zmq_msg_t msg;
    int rc;
    NSData *data;
    NSString *str;

    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            str = [NSString stringWithFormat:@"%@: %@", nickname, [alertView textFieldAtIndex:0].text];
            data = [str dataUsingEncoding:NSUTF8StringEncoding];
            rc = zmq_msg_init_size(&msg, [data length]);
            assert(rc == 0);
            memcpy(zmq_msg_data(&msg), [data bytes], [data length]);

            zmq_send(reqsock, &msg, 0);
            zmq_recv(reqsock, &msg, 0);
            zmq_msg_close(&msg);
            break;
        default:
            break;
    }
}

@end

$$/code

以下補足

* 簡単のためタイマーで1秒ごとにソケットにメッセージがあるかどうかobserveSocketでチェックしているが、別スレッドにしたほうがスマート
* [zmq_recvのマニュアル](http://api.zeromq.org/2-2:zmq-recv)によると、zmq_recvをZMQ_NOBLOCKで呼んだときにメッセージがなかった場合はEAGAINが返るとなっているが、-1がかえってきていた。
* 上記ソースはUITableViewControllerで発言を表示する想定になっているが、UIまわりのコードは省略


## オマケ(Common Lisp版コマンドライン用チャットクライアント)

$$code(lang=lisp)

(load "~/.sbclrc")
(ql:quickload :zeromq)
(ql:quickload :bordeaux-threads)

(defun sub ()
  (zmq:with-context (ctx 1)
    (zmq:with-socket (socket ctx zmq:sub)
      (zmq:setsockopt socket zmq:subscribe "")
      (zmq:connect socket "tcp://127.0.0.1:5556")
      (loop
         (let ((query (make-instance 'zmq:msg)))
           (zmq:recv socket query)
           (format t "received message: ~a~%" (zmq:msg-data-as-string query)))))))

(defun client ()
  (zmq:with-context (ctx 1)
    (zmq:with-socket (socket ctx zmq:req)
      (zmq:connect socket "tcp://127.0.0.1:5555")
      (loop
         (zmq:send socket (make-instance 'zmq:msg
                                         :data (read-line)))
         (let ((result (make-instance 'zmq:msg)))
           (zmq:recv socket result))))))


(bordeaux-threads:make-thread #'sub)
(client)

$$/code

# まとめ

* iPhoneでZeroMQを動かしてみた
* ZeroMQのREQ/REPとPUB/SUBを使用してチャットをつくってみた
* appleの審査を通過するかどうかは知らない(一応実績はあるらしい)

# 参考

* [http://api.zeromq.org/2-2:_start](http://api.zeromq.org/2-2:_start)
* [http://www.zeromq.org/area:licensing](http://www.zeromq.org/area:licensing)
* [http://www.zeromq.org/intro:commercial-support](http://www.zeromq.org/intro:commercial-support)
