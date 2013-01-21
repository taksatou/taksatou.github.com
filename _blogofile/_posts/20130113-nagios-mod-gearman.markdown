---
categories: nagios, gearman, linux
date: 2013/1/13 22:00:00
title: nagiosのmod-gearmanでgearman監視
image: /images/english-200.png
draft: True
---

![english](/images/english-200.png)



http://labs.consol.de/nagios/mod-gearman/

CentOSだとboostやらlibgearmanやら自分で入れる必要がある
debianだとaptではいるが、CentOSだとソースからビルドする必要がある。
mod-gearmanをビルドするには、gearmanのクライアントライブラリも必要なのであわせてビルドする。
色々必要なパッケージも


sudo yum install libtool-ltdl-devel boost-devel
wget https://launchpad.net/gearmand/1.2/1.1.4/+download/gearmand-1.1.4.tar.gz
tar xzf gearmand-1.1.4.tar.gz
cd gearmand-1.1.4
./configure && make
sudo make install
cd ../


CentOS
