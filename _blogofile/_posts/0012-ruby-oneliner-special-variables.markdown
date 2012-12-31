---
categories: ruby
date: 2012/07/8 18:30:00
title: rubyのワンライナーで便利な変数まとめ
image: /images/ruby-logo.png
---

![ruby](/images/ruby-logo.png)


# $.

現在の行番号を表します。awkでいうNRと同じです。

$$code(lang=ruby)
ruby -ne 'puts "#{$.},#{$_}"'
$$/code

# $-i

この値を文字列で上書きするとin-place置換を行うようになります。オリジナルのファイルはここで指定した文字が拡張子についたファイルとして保存されます。オリジナルファイルが不要なら空文字を設定すればOKです。


$$code(lang=ruby)
ruby -ne 'BEGIN{$-i=".old"}; puts($_) if /foo/' path/to/file
$$/code

# $/

入力の区切り文字を表わす文字です。デフォルトは改行です。

$$code(lang=ruby)
ruby -ne 'BEGIN{$/=","}; p $_'
$$/code

# $, 、$;

$, はjoinのデフォルト区切り文字で、$; はsplitのデフォルト区切り文字です。
ワンライナーではjoinとsplitをよく使うと思うので、BEGINで上書きしておけばワンライナーを多少短く書けます。

$$code(lang=ruby)
ruby -ne 'BEGIN{$,="\t";$;=","}; puts $_.split.join'
$$/code

# まとめ

まだ他にも知らないテクニックがたくさんありそうですが、新しく見つけたら追記していきます。

# 参考

* [http://blog.lilyx.net/2007/11/29/writing-one-liner-in-ruby/](http://blog.lilyx.net/2007/11/29/writing-one-liner-in-ruby/)
* [http://www.ruby-lang.org/ja/old-man/html/_C1C8A4DFB9FEA4DFCAD1BFF4.html](http://www.ruby-lang.org/ja/old-man/html/_C1C8A4DFB9FEA4DFCAD1BFF4.html)
