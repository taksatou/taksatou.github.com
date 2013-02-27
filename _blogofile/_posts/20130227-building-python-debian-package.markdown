---
categories: python, debian, linux
date: 2013/02/27 23:46:03
title: pythonのswigエクステンションからdebian packageをつくる手順メモ
image: /images/debian-200.png
---

![debian](/images/debian-200.png)

注: 以下は古めの環境(Lenny or Squeeze)と古めのpython (2.5 or 2.6)をターゲットにしたときの手順なので、最新の環境では別な方法があるかもしれません。

## 目次

[TOC]

### 1. 必要なパッケージをインストール

* python-setuptools
* python-all-dev
* python-support
* python-stdeb
* swig
* debhelper
* devscripts
* dh_make

たぶんこれだけあれば大丈夫。(python-supportはdeprecatedらしいけどここでは無視)

### 2. setup.pyをかく

```apt-get source python-xxx```で適当なパッケージのソースをダウンロードして参考にするとよい

以下例

$$code(lang=python)
#!/usr/bin/python

from setuptools import setup, Extension

__version__ = "0.0.1"

setup(name         = "yourext",
      version      = __version__,
      author       = "Your Name",
      author_email = "yourname@example.com,
      url          = "http://example.com/python-yourext",
      download_url = "http://example.com/python-yourext-%s.tgz" % __version__,
      description  = "yourext client library for python",
      long_description = open('README.md').read(),
      license      = "LGPL",
      platforms    = ["Platform Independent"],
      classifiers  = [
        "Development Status :: 5 - Production/Stable",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: GNU Library or Lesser General Public License (LGPL)",
        "Operating System :: OS Independent",
        "Programming Language :: Python",
        "Topic :: Software Development :: Libraries :: Python Modules"
      ],
      ext_modules  = [
        Extension(name='yourext',
                  sources=['path_to_swig/yourext.i'],
                  include_dirs=['path_to_lib/include'],
                  library_dirs=['path_to_lib/lib'],
                  libraries=['yourlibrary'],
                  define_macros=[(FOO_BAR, 123), (DEBUG, None)],
                  extra_compile_args=['-std=gnu99', '-Wextra'],
                  )
      ],
      py_modules = ['pure_python_module_name', 'foo.bar'],
      include_dirs = [''],
)
$$/code

* ext_modulesの中にExtensionをかく
<ul>
 * Extension.sources にはswigの定義ファイルを直接指定できる
 * Extension.include_dirs, Extension.library_dirs, Extension.librariesはそれぞれgccでいう```-I, -L, -l ```の値
 * Extension.define_macrosはタプルで渡す。上の例だと ```-DFOO_BAR=123 -DDEBUG``` の意味
 * Extension.extra_compile_args はその他のコンパイルオプション
</ul>
* platforms, classifiersの内容はpython-cjsonあたりからコピーした
* pure pythonの部分はpy_modulesにモジュール名を列挙する。パスではない
* swigが生成した```.py```ファイルをpy_modulesに含める汎用的な方法は見つからなかった。(必要な場合はスクリプトでinclude_dirsにコピーすることで対応できる)

### 3. ビルド確認

以下コマンドでpython extのビルドを確認する。成功すると、buildディレクトリ以下に共有ライブラリが生成される

```
python setup.py build 
```

### 4. debianizeする

以下コマンドでdebianパッケージに必要なファイルを生成する。このときegg-info等も生成される

```
python setup.py --command-package=stdeb.command debianize --force-buildsystem=True 
```

### 5. debをつくる

```
debuild -uc -us 
```

```-uc -us```は署名を省略するためのオプション。

成功すると、親ディレクトリにdebファイルができてるはず


### その他ツール等

* dupload: リポジトリにアップロードするためのもの
* dlocate: ```dlocate -S filename``` のようにすればそのファイルを含むパッケージを調べることができる
* cdbs: debianパッケージを作成するための別なやりかた(?)。 ちゃんとしらべてない

