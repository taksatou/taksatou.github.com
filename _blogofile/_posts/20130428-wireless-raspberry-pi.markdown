---
categories: raspberry pi
date: 2013/04/28 01:54:53
title: ワイヤレスなRaspberry Pi環境をつくる
image: /images/raspberry-pi-150.png
---

![raspberry](/images/raspberry-pi-150.png)

Raspberry Pi遊ぶからにはその小ささを生かしたことがしたいですよね。
というわけで手始めにワイヤレス化しました。手順は非常に簡単で、ほぼAmazonで買ったパーツを差すだけで達成できました。

Raspberry Piを標準的な構成でうごかすとLANケーブル、電源、 キーボード、ディスプレイの4本コードがのびることになりますが、sshで接続できればディスプレイもキーボードも不要なのであと必要なのはネットワーク環境と電源だけです。

電源は 5V 700mA なので、普通のスマートフォン用バッテリーがそのまま使えます。
5V 700mAを越えていれば何でもいいと思いますが、今回は以下をつかいました。

<iframe src="http://rcm-jp.amazon.co.jp/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=armyofpigs-22&o=9&p=8&l=as4&m=amazon&f=ifr&ref=ss_til&asins=B0067TQQI8" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>

<br>

ネットワークはUSBの無線LAN受信機を使います。
これも何でもいいと思いますが、あまり最新のモデルだとドライバが対応してないかもしれないのでちょっと古めのもののほうが無難です。以下の商品は問題なく動きました。

<iframe src="http://rcm-jp.amazon.co.jp/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=armyofpigs-22&o=9&p=8&l=as4&m=amazon&f=ifr&ref=ss_til&asins=B003NSAMW2" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>


wifiの設定はX Windowの設定画面からしました。`startx`でデスクトップを起動すると`WiFi Config`というアイコンがあるのでそこから設定できます。
ターミナルで`ifconfig`を実行してwlan0にinet addrが割り当てられていることを確認できればOKです。

$$code
pi@raspberrypi ~ $ /sbin/ifconfig
eth0      Link encap:Ethernet  HWaddr b8:27:eb:90:32:15
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:8 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:1104 (1.0 KiB)  TX bytes:1104 (1.0 KiB)

wlan0     Link encap:Ethernet  HWaddr 10:6f:3f:ec:5f:b8
          inet addr:192.168.1.13  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:4285 errors:0 dropped:0 overruns:0 frame:0
          TX packets:673 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:937903 (915.9 KiB)  TX bytes:81630 (79.7 KiB)

$$/code


ここで確認したIPアドレスにsshしてつながれば完了です。


