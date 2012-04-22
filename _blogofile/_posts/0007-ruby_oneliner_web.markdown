---
categories: tmux
date: 2012/02/01 21:05:10
title: rubyでウェブサービスを作るときに便利なワンライナーまとめ
draft: True
---


Webサーバ起動
----------------------
ruby -rwebrick -e 's = WEBrick::HTTPServer.new({:DocumentRoot => "./", :Port => 8080}); trap("INT"){ s.shutdown }; s.start'



JSONの整形
----------------------

curl https://stream.twitter.com/1/statuses/sample.json -uYOUR_TWITTER_USERNAME:YOUR_PASSWORD | ruby -ryajl -rpp -e 'p=Yajl::Parser.new;p.on_parse_complete=->(x){pp x};p.parse(STDIN)'


