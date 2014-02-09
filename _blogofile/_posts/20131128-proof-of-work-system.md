---
categories: bitcoin
date: 2013/11/19 19:19:57
title: 
draft: True
---


http://en.wikipedia.org/wiki/Proof-of-work_system

## Proof-of-work system

A proof-of-work (POW) system (or protocol, or function) is an economic
measure to deter denial of service attacks and other service abuses
such as spam on a network by requiring some work from the service
requester, usually meaning processing time by a computer. 

POWとはDOSアタックやSPAMのように、通常はコンピュータの処理時間を要するようなサービス妨害を防ぐための経済措置である。


A key feature of these schemes is their asymmetry: the work must be
moderately hard (but feasible) on the requester side but easy to check
for the service provider. 

この措置の重要な特徴はその非対称にある。つまり、要求者にとってはそれな
りに難しい(しかし実行可能な)仕事でありながら、サービス提供者がチェック
するのは簡単でなければならない。

This idea is also known as a CPU cost function, client puzzle,
computational puzzle or CPU pricing function.

このアイディアはCPU cost functionやclient puzzle, などとしても知られている。


One popular system - used in Bitcoin mining - is Hashcash, which uses
partial hash inversions to prove that work was done, as a good-will
token to send an e-mail. 

Hashcashという著名なシステムは、
仕事が実行されたことを証明するのに partial hash inversions を使用している。
それは信用の証明としてe-mailで送信される


For instance the following header represents about 252 hash
computations to send a message to calvin@comics.net on January 19,
2038:

例えば以下のヘッダはおよそ2^52回のハッシュ計算を表したものであり、
calvin@comics.net宛てに January 19, 2038 に送信したものである

X-Hashcash: 1:52:380119:calvin@comics.net:::9B760005E92F0DAE


It is verified with a single computation by checking that the SHA-1
hash of the stamp (omit the "X-Hashcash:" portion) begins with 52
binary zeros, that is 13 hexadecimal zeros:
0000000000000756af69e2ffbdb930261873cd71

これは"X-Hashcash: "の部分を除いた部分のSHA-1ハッシュを1回計算するだけで確認できる。
その値は16進数で表わすと0000000000000756af69e2ffbdb930261873cd71となり、この値は2進数では52個の連続した0から始まる値となる


Whether POW systems can actually solve a particular denial-of-service
issue such as the spam problem is subject to debate;[1][2] 

POWが特定のDOSやSPAMを実際に解決できるかどうかは議論の余地がある。

the system must make sending spam emails obtrusively unproductive for
the spammer, but should also not prevent legitimate users from sending
their messages. 

このシステムはスパマーに著しく無駄な作業を強いるが、合法なユーザがメッ
セージを送信するのは邪魔しない。

Proof-of-work systems are being used as a primitive by other more
complex cryptographic systems such as Bitcoin which uses a system
similar to Hashcash.

POWシステムは複雑な暗号化されたシステムの基盤として利用されている。

Bitcoinの採掘ではHashcashに似たシステムが採用されている。


## Hashcash

Hashcash is a proof-of-work system designed to limit email spam and
denial-of-service attacks. Hashcash was proposed in March 1997 by Adam
Back.[1]

HashcashとはスパムメールやDOSアタックを制限するために設計されたPOWシステムの一つ。
1997にAdam Beckによって提案された。



Hashcash is a method of adding a textual stamp to the header of an
email to prove the sender has expended a modest amount of CPU time
calculating the stamp prior to sending the email. 

Hashcashはメールのヘッダにテキストのスタンプを付加することによって、
メール送信にあたって適当なCPU時間を費したことを証明するための方法である。


In other words, as the sender has taken a certain amount of time to
generate the stamp and send the email, it is unlikely that they are a
spammer. 

言い換えると、送信者がメールにスタンプをつけるのに一定の時間を消費してから
メールを送信しているので、それがスパムの可能性は低い。

The receiver can, at negligible computational cost, verify that the
stamp is valid. 

受信者は無視できるほど小さいコストでその正当性を検証できる。

However, the only known way to find a header with the necessary
properties is brute force, trying random values until the answer is
found; though testing an individual string is easy, if satisfactory
answers are rare enough it will require a substantial number of tries
to find the answer.

目的の条件を満たすヘッダを見つけるための唯一の知られている方法はbrute forceで
答えが見つかるまでランダムに試行するのだが、
個々の文字列を検証するのは簡単
もし目的の条件を見たす答が十分レアなら答をみつけるまで一定数の試行が必要になる


The theory is that spammers, whose business model relies on their
ability to send large numbers of emails with very little cost per
message, cannot afford this investment into each individual piece of
spam they send.

スパマーのビジネスモデルは大量のメールを低コストで送信できるということに依存しているので、
それぞれのspamごとにそのような投資をする余裕はない


Receivers can verify whether a sender made such an
investment and use the results to help filter email.

受信者は送信者がそのような投資を行ったかどうかを検証することでメールをフィルターできる




The header line looks something like this:[2]
X-Hashcash: 1:40:1303030600:adam@cypherspace.org::McMybZIhxKXu57jd:FOvXX
The header contains: the recipient's email address, the date, and information proving the required computation has been performed. The presence of the recipient's email address requires that a new header be computed for each recipient, and the date allows the recipient to record headers received recently and make sure the header is unique to this email.
Sender's side[edit]
The sender prepares a header and adds an initial random number. It then computes the 160 bit SHA-1 hash of the header. If the first 20 bits of the hash are zeros then this is an acceptable header. If not then the sender increments the random number and tries again. Since about 1 in 220 headers will have 20 zeros as the beginning of the hash the sender will on average have to try 220 random numbers to find a valid header. Given reasonable estimates of the time needed to compute the hash,[when?] this would take about 1 second to find. At this time no more efficient method is known to find a valid header.
A normal user on a desktop PC would not be significantly impacted by the processing time required to generate the Hashcash string. However, spammers would suffer a significant impact due to the high number of spam messages required.
Recipient's side[edit]
Technically the system is implemented as follows:
The recipient's computer calculates the 160 bit SHA-1 hash of the entire string "1:20:060408:adam@cypherspace.org::1QTjaYd7niiQA/sc:ePa". This takes about two microseconds on a 1 GHz machine—far shorter than the time it took for the rest of the e-mail to be received. If the first 20 bits are all zero, then it is valid. Later versions may require more bits to be zero.
The recipient's computer checks the date in that header "060408" (8 Apr 2006). If it's within 2 days of today, it's valid (to compensate for clock skew and routing time).
The recipient's computer checks to see if the e-mail address in the hashcash header is (any of) the valid e-mail address(es) of the recipient (or any mailing lists to which the recipient is subscribed).
If all the other checks are valid, the recipient's computer puts that string in a database. If that string was not already in the database, it is valid.
All these tests take far less time and disk space than receiving the rest of the e-mail.

