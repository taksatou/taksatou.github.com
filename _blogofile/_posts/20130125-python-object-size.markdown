---
categories: python
date: 2013/1/23 20:00:00
title: Pythonでオブジェクトのサイズを調べる
draft: True
---

python2.6でオブジェクトのサイズを知りたいことがあった。
python2.6以降であれば、[sys.getsizeof()](http://docs.python.org/2/library/sys.html#sys.getsizeof) という関数で取得できる。
でも、2.5には該当のものがみつからなかったので、半ばあきらめていた


http://stackoverflow.com/questions/1331471/in-memory-size-of-python-stucture


http://code.google.com/p/pympler/

pympler はオブジェクトのサイズをスタックの消費量でみつもる
すごい

