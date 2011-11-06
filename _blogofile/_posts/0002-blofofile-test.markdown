---
categories: blogofile, test
date: 2011/11/06 20:32:51
title: blogofileでサムネイル画像を表示する方法
image: /images/rena.jpg
---

![rena](/images/rena.jpg)

こんな風にイメージ画像がある記事の場合は、一覧ページでもこの画像をサムネイルで表示させたい。

例えば、
[http://mojavy.com](http://mojavy.com)
のトップページ右カラムにある最近の記事一覧みたいに画像を表示できるようにする。

これをするには、postオブジェクトにそういう属性をもたせればよいので、controllers/blog/post.pyに以下のように一行追加する。

$$code(lang=diff)
+++ b/_blogofile/_controllers/blog/post.py
@@ -93,6 +93,7 @@ class Post(object):
         self.slug = None
         self.draft = False
         self.filters = None
+        self.image = None
         self.__parse()
         self.__post_process()
$$/code

そうしておくと、各記事のヘッダにあるyamlから勝手に読み込んでくれるので、

$$code(lang=yaml)
categories: 
date: 2011/11/06 20:32:51
title: 
image: /images/rena.jpg
$$/code

のようにすれば${post.image}のようにして参照できる。

- [https://github.com/taksatou/taksatou.github.com](https://github.com/taksatou/taksatou.github.com) 



