---
categories: ruby, jekyll, impress.js
date: 2013/03/26 20:37:24
title: hekyllのimpress.jsスライドを自動的にグリッド配置するjekyllプラグイン
---

[hekyll](https://github.com/bmcmurray/hekyll)は[impress.js](https://github.com/bartaz/impress.js/)用[jekyll](https://github.com/mojombo/jekyll)テンプレのようなものだけど、スライドの位置を個別に指定する必要があってめんどうだったので適当なグリッドに配置するプラグインを書いた。


### jekyllのプラグインについて

[https://github.com/mojombo/jekyll/wiki/Plugins](https://github.com/mojombo/jekyll/wiki/Plugins)に必要なことは大体書いてある。

jekyllのディレクトリに`_plugins`ディレクトリを作り、その中に`*.rb`をおいておけば自動的にロードされる。
プラグインの種類はおおまかに以下の4通り。サンプルは本家wikiにあるのでメモもかねて概要だけ。

* Generators 
<ul>
* カテゴリ別とか期間別といった任意のルールでページを生成する
</ul>
* Converters
<ul>
* hamlとかjsonとかのフォーマット変換をする
</ul>
* Tags
<ul>
* liquidテンプレートエンジンのタグを追加する
* たとえば、`{{ your_tag }}` というタグをつかいたければ、`Liquid::Tag`を継承したクラスをつくって、`Liquid::Template.register_tag('your_tag', Jekyll::YourTag)` などとする
</ul>
* Filters
<ul>
* liquidのフィルタを追加する
* フィルタとはいいつつどんな関数でも登録できる
* 適当にモジュールをつくって、`Liquid::Template.register_filter(Jekyll::YourModule)`とすると、`{{ 'arg' | your_filter }}` のようにして呼びだせる
</ul>


### ソース

wikiで説明されているpluginの書き方を踏まえた上で、それを完全に無視する方法で実装した。
Postクラスを拡張してhekyllにあうようにliquidに渡すデータを上書きしてるだけ。

もっといい方法はあると思う。

$$code(lang=ruby)
def once(tag)
  unless (@__once_executed__ ||= []).include? tag
    yield
    @__once_executed__ << tag
  end
end

module Jekyll
  class Post
    
    def grid_position
      pos = @site.posts.index(self)
      siz = Math::sqrt(@site.posts.size).ceil
      {
        "x" => 1000 * (pos % siz),
        "y" => 1000 * (pos / siz),
      }
    end

    once(:redefine_to_liquid) do
      alias __old_to_liquid to_liquid
      def to_liquid

        dat = self.data["data"]

        if dat.nil?
          self.data["data"] = self.grid_position
        end
        __old_to_liquid
      end
    end
    
  end
end
$$/code

[https://gist.github.com/taksatou/5244991](https://gist.github.com/taksatou/5244991)


### まとめ

impress.jsをつかっておいて単なるグリッドというのもどうかとは思いますが、位置決めをする部分をかえればなんとでもなるのでひまなときにがんばればいいと思います
