---
categories: tmux, ruby, english
date: 2013/1/11 22:00:00
title: tmuxでalcの英単語を引く
image: /images/english-200.png
---

![english](/images/english-200.png)

<b>2013-01-15追記 規約違反とのコメント頂いたのでスクレイピングするスクリプトを削除しました。</b>

tmuxのcommand-promptを使うと任意のコマンドをインタラクティブに実行できます。
これをつかってtmux上でalcの英単語を表示できるようにしたら思いの外便利だったので紹介します。

まず、alcの検索結果をスクレイビングしていい感じに表示するコマンドをつくります。
rubyのnokogiriとrainbowに依存してますが、ぼくがつくった適当なスクリプトでよければこれを使って下さい。

$$code(lang=ruby)
# 2013-01-15 削除しました
$$/code


これをパスの通った場所にalcという名前で保存して、.tmux.confに以下の設定を追記します。

$$code(lang=bash)
unbind C-a
bind C-a command-prompt "split-window -h 'alc %% | lv -c'"
$$/code

C-aにバインドしてますがお好みのキーに変えてください。
rainbowで色付けしてるのでエスケープシーケンスを解釈できるpagerをつかって下さい。

これで.tmux.confをリロードして、prefix-key C-a とかするとtmux上にプロンプトが表示されるので、そこで調べたい単語を入力します。
そうすると新しいpaneに結果が表示されます。pagerを閉じると自動的にpaneも閉じます。

