---
categories: emacs, php
date: 2013/04/05 19:49:49
title: emacsでphpのインタラクティブシェルを動かすinf-php.elを書いた
image: /images/carbon-emacs-icon-200.png
---

![emacs](/images/carbon-emacs-icon-200.png) 


phper人口は多いはずなのになぜかどこにも見つからなかったのでemacsでphpのインタラクティブシェルを動かすための[inf-php.el](https://github.com/taksatou/inf-php) を書いた。


#### install ####

auto-installがはいっていれば、`(auto-install-from-url "https://raw.github.com/taksatou/inf-php/master/inf-php.el")`で、はいってなければ [inf-php.el](https://raw.github.com/taksatou/inf-php/master/inf-php.el) をダウンロードして適当にload-pathの通った場所に配置して、`.emacs`に以下を追記

$$code
(require 'inf-php)
$$/code

#### usage ####

現状のキーバインドは以下の通り

$$code
(define-key php-mode-map "\C-c\C-s" 'inf-php)              ;; inf-phpを起動する
(define-key php-mode-map "\C-c\C-z" 'php-switch-to-inf)    ;; inf-rubyバッファに切り替える
(define-key php-mode-map "\M-\C-x" 'php-send-definition)   ;; 現在カーソルがあるところの関数をinf-phpに送る
(define-key php-mode-map "\C-c\C-x" 'php-send-definition)  ;; 同上
(define-key php-mode-map "\C-c\M-x" 'php-send-definition-and-go)  ;; 同上だが送った後バッファを切り替える
(define-key php-mode-map "\C-c\C-r" 'php-send-region)             ;; 現在のregionを送る
(define-key php-mode-map "\C-c\M-r" 'php-send-region-and-go)      ;; 同上だが送った後バッファを切り替える
(define-key php-mode-map "\C-x\C-e" 'php-send-last-sexp)          ;; 直前のsexpをinf-phpに送る
$$/code


#### misc ####

フィードバック、要望等ありましたらgithubからおねがいします。


