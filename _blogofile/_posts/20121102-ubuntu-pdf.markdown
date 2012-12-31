---
categories: ubuntu, pdf, tips
date: 2012/11/02 12:00:00
title: UbuntuでPDFの日本語フォントが表示できないときの対処メモ
image: /images/ubuntu-logo.png
---

![ubuntu](/images/ubuntu-logo.png)

Ubuntu 12.04 で日本語フォントのはいったpdfを開くと、日本語の部分が空白になって以下のようなエラーログが表示されてしまっていた。

$$code(lang=bash)
Error (13373): No font in show/space
Error (13412): No font in show/space
Error (13497): No font in show/space
Error (13515): No font in show
Error (13555): No font in show/space
Error (13572): No font in show
Error (13607): No font in show/space
Error: Missing language pack for 'Adobe-Japan1' mapping
Error: Missing language pack for 'Adobe-Japan1' mapping
Error: Missing language pack for 'Adobe-Japan1' mapping
Error: Missing language pack for 'Adobe-Japan1' mapping
Error: Missing language pack for 'Adobe-Japan1' mapping
Error: Missing language pack for 'Adobe-Japan1' mapping
Error: Missing language pack for 'Adobe-Japan1' mapping
Error: Unknown font tag 'C0_0'
Error (231): No font in show
Error: Unknown font tag 'C0_1'
$$/code

pdfビューワはDocument Viewerでもokularでも同様だった。

そこで、[このあたり](https://forums.ubuntulinux.jp/viewtopic.php?id=8281)を参考に、

$$code(lang=bash)
sudo apt-get install poppler-data
$$/code

としたらちゃんと表示されるようになった。
