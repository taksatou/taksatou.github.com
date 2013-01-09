---
categories: emacs, elisp
date: 2013/1/9 22:00:00
title: yaml-modeを拡張してyamlを高速に編集する
image: /images/carbon-emacs-icon-200.png
---

![emacs](/images/carbon-emacs-icon-200.png)

とあるとプロジェクトで巨大なyamlを編集しなければならない時があるのですが、素の[yaml-mode](https://github.com/yoshiki/yaml-mode)だけだと非力に感じたので拡張するためのemacs lispを書きました。

といっても、現状ではブロック単位で移動する関数を適当にyaml-mode-mapにバインドしているだけの単純なものです。

使い方は、[https://github.com/taksatou/yaml-mode-ex](https://github.com/taksatou/yaml-mode-ex)からおとしてきてloadするだけです。
(yaml-modeはあらかじめインストールしておく必要があります)

$$code(lang=elisp)
(load-file "path/to/yaml-mode-ext.el")
$$/code

以下のキーバインドが使えます。

* M-C-f  同じ階層の次のブロックへ移動
* M-C-b  同じ階層の前のブロックへ移動
* M-C-u  親ブロックの先頭へ移動
* M-C-e  親ブロックの末尾へ移動
* M-C-d  直下の子ブロックへ移動


当初はyaml-modeをhideshow.elに対応させようと思ってたのですが、ブロック単位で移動ができるようになったところで満足してしまいました。

なお、ブロックの境界はインデントレベルしかみてないのでyamlに限定する必要はなかった気はしますが、pythonとかhaskellとかでもつかいたくなってきたら書き直そうと思います。
