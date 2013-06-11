---
categories: security
date: 2013/06/12 08:36:07
title: ブロック暗号化モードについて
---

AESを使おうと思ったけどどのブロック暗号化モードをつかえばいいかわからなかったので調べたことをまとめておきます。

## ブロック暗号化モードとは

[Wikipedia/暗号利用モード](http://ja.wikipedia.org/wiki/%E6%9A%97%E5%8F%B7%E5%88%A9%E7%94%A8%E3%83%A2%E3%83%BC%E3%83%89)

> 暗号利用モード（あんごうりようモード、Block cipher modes of operation）とは、ブロック暗号を利用して、ブロック長よりも長いメッセージを暗号化するメカニズムのことである。
<br>
> ECBモード（単純なブロック暗号の利用法）では、ある鍵で同一の平文を暗号化すると、同一の暗号文になる。したがって、長いメッセージ（画像データなど）のある部分が他の部分と同じであるかどうかが、暗号文の比較によって判断できてしまうので、他のモードが必要となった。
<br>
> 暗号利用モードには、秘匿用の利用モードと、認証用の利用モードとがある。
<br>
<br>


## 秘匿用利用モード

[Wikipediaの図](http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation ) も参考にするとわかりやすい。
以下は概要だけ。

### ECB

各ブロックを単純に一つずつ処理するだけ。暗号が一致したブロックは復号した平文も一致する。
1つ以上のブロックを単一のパスワードで暗号化するのであれば使うべきではない。


### CBC

直前の暗号テキストブロックを次の平文テキストブロックにXORしてからブロック暗号処理することを繰り返す。
最初のブロックはIV([Initialization Vector](https://en.wikipedia.org/wiki/Initialization_vector ))をつかって暗号化する。


暗号化は前から順番にする必要があるが、複合は1つ前のブロック前が分かればできるので並列化が可能。


### CFB

CBCと似ているが、直前の暗号テキストブロックを再度ブロック暗号処理したものに次の平文テキストブロックをXORしたものを暗号テキストとする。
最初のブロックはIVだけブロック暗号処理してXORする。
CBCとはXORのタイミングが違うだけ。

特徴もCBCと同じで、暗号化処理は並列化できないが複合は可能。


### OFB

IVを繰り返しブロック暗号処理したものにそれぞれ平文ブロックをXORしていったものを暗号テキストとする。
すべての操作で直前のものが必要となるので暗号化・復号の両方とも並列化はできないが、IVのブロック暗号処理は事前に計算することができる。

### CTR (ICM, SIC)

OFBに似ているが、IVではなくカウンターの値をインクリメントしつつブロック暗号処理したものに平文ブロックをXORする。
カウンターは十分に長い間繰り返しが発生しない一意な値を出力する任意の関数であれば何でもよいが、単に1ずつ増やすカウンターを使うことが多い。

暗号・復号いずれも並列化が可能だが、入力に決定的な値を使うことについては議論の余地がある。


### ディスク用のもの

ディスクを暗号化するには特別な考慮が必要になるため専用のものがいくつか存在する。

* LRW
* XEX
* XTS
* CMC


#### 参考

* [http://en.wikipedia.org/wiki/Disk_encryption_theory](http://en.wikipedia.org/wiki/Disk_encryption_theory)
* [http://csrc.nist.gov/publications/nistpubs/800-38E/nist-sp-800-38E.pdf](http://csrc.nist.gov/publications/nistpubs/800-38E/nist-sp-800-38E.pdf)
* [http://axelkenzo.ru/downloads/1619-2007-NIST-Submission.pdf](http://axelkenzo.ru/downloads/1619-2007-NIST-Submission.pdf)


## 認証用の利用モード

秘匿化とあわせて認証とデータの完全性を保証するためのモード。
通常はMAC(Massage Authentication Code, authentication tag)を組みあわせることで実現する。

* [CCM](http://en.wikipedia.org/wiki/CCM_mode)
* [CWC](http://en.wikipedia.org/wiki/CWC_mode)
* [OCB](http://en.wikipedia.org/wiki/OCB_mode)
* [EAX](http://en.wikipedia.org/wiki/EAX_mode)
* [GCM](http://en.wikipedia.org/wiki/Galois/Counter_Mode)


## その他

* 上記では触れなかったが、並列化できるかどうかの他にもエラー検出が可能かどうかや組み合わせて使用するブロック暗号化方式の特徴なども考慮して選択する必要がある
* 特許になっているものも多いので使用する際は要確認
* mysqlのaes_encrypt()ではECBをつかっているのでセキュリティ強度的にはあまりよろしくない

## 参考

* [http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation](http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation)
* [http://en.wikipedia.org/wiki/Authenticated_encryption](http://en.wikipedia.org/wiki/Authenticated_encryption)
* [http://en.wikipedia.org/wiki/Message_authentication_code](http://en.wikipedia.org/wiki/Message_authentication_code)
* [http://en.wikipedia.org/wiki/OCB_mode](http://en.wikipedia.org/wiki/OCB_mode)
* [http://www.heliontech.com/aes_modes_basic.htm](http://www.heliontech.com/aes_modes_basic.htm)
* [http://www.triplefalcon.com/Lexicon/Encryption-Block-Mode-1.htm](http://www.triplefalcon.com/Lexicon/Encryption-Block-Mode-1.htm)
* [http://www.schneier.com/blog/archives/2009/07/another_new_aes.html](http://www.schneier.com/blog/archives/2009/07/another_new_aes.html)
* [http://stackoverflow.com/questions/1220751/how-to-choose-an-aes-encryption-mode-cbc-ecb-ctr-ocb-cfb](http://stackoverflow.com/questions/1220751/how-to-choose-an-aes-encryption-mode-cbc-ecb-ctr-ocb-cfb)
* [http://stackoverflow.com/questions/2797692/whats-the-best-way-to-store-sensitive-data-in-mysql](http://stackoverflow.com/questions/2797692/whats-the-best-way-to-store-sensitive-data-in-mysql)
* [http://www.cs.ucdavis.edu/~rogaway/ocb/license.htm](http://www.cs.ucdavis.edu/~rogaway/ocb/license.htm)

