---
categories: emacs, game
date: 2014/07/16 01:07:04
title: flappymacs がMELPAに登録されました
---

[flappymacs](http://mojavy.com/blog/2014/07/10/flappy-bird-for-emacs-flappymacs/ ) がMELPAに登録されました。

$$code(lang=elisp)
(add-to-list
 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
$$/code

を設定して、`M-x package-list-packages` からflappymacsを探してインストールするとすぐに遊べます。

