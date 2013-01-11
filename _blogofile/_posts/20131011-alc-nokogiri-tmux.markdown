---
categories: tmux, ruby, english
date: 2013/1/11 22:00:00
title: tmuxでalcの英単語を引く
image: /images/english-200.png
---

![english](/images/english-200.png)

tmuxのcommand-promptを使うと任意のコマンドをインタラクティブに実行できます。
これをつかってtmux上でalcの英単語を表示できるようにしたら思いの外便利だったので紹介します。


まず、alcの検索結果をスクレイビングしていい感じに表示するコマンドをつくります。
rubyのnokogiriとrainbowに依存してますが、ぼくがつくった適当なスクリプトでよければこれを使って下さい。

$$code(lang=ruby)
#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'nokogiri'
require 'open-uri'
require 'rainbow'
require 'cgi'

Sickill::Rainbow.enabled = true

q = CGI.escape ARGV.join(' ')
doc = Nokogiri::HTML(open('http://eow.alc.co.jp/search?q=' + q).read)

doc.css('div#resultsArea div#resultsList ul').children.each do |x|
  next if x.text.strip.empty?
  next if x.css('.midashi').text.strip.empty?
  puts x.css('.midashi').text.color(:green)
  if x.css('div ul').empty?
    puts x.css('div').text.gsub(/(【.+?】)/, "\n#{$1}")
  else
    x.css('div ul').children.each {|y| puts '- ' + y.text }
  end

  puts '----------------'
end
$$/code

[https://github.com/taksatou/linux_utils/blob/master/bin/common/alc](https://github.com/taksatou/linux_utils/blob/master/bin/common/alc)  に置いてます。
一応、英和と和英の両方に対応してます。

これをパスの通った場所にalcという名前で保存して、.tmux.confに以下の設定を追記します。

$$code(lang=bash)
unbind C-a
bind C-a command-prompt "split-window -h 'alc %% | lv -c'"
$$/code

C-aにバインドしてますがお好みのキーに変えてください。
rainbowで色付けしてるのでエスケープシーケンスを解釈できるpagerをつかって下さい。

これで.tmux.confをリロードして、prefix-key C-a とかするとtmux上にプロンプトが表示されるので、そこで調べたい単語を入力します。
そうすると新しいpaneに結果が表示されます。pagerを閉じると自動的にpaneも閉じます。

