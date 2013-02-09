---
categories: common lisp
date: 2013/2/9 17:15:00
title: common lispのdefconstantについての注意点
image: /images/lisp-warinig-150.png
---

![lisp](/images/lisp-warinig-150.png)


sbclでdefconstantすると以下のようなエラーがおきたりおきなかったりして不思議に思っていた。

$$code(lang=lisp)
The constant CL-GEARMAN::+REQUEST-MAGIC+ is being redefined
(from #(0 82 69 81) to #(0 82 69 81))
   [Condition of type DEFCONSTANT-UNEQL]
See also:
  Common Lisp Hyperspec, DEFCONSTANT [:macro]
  SBCL Manual, Idiosyncrasies [:node]

Restarts:
 0: [CONTINUE] Go ahead and change the value.
 1: [ABORT] Keep the old value.
 2: [TRY-RECOMPILING] Recompile protocol and try loading it again
 3: [RETRY] Retry loading FASL for #<CL-SOURCE-FILE "cl-gearman" "src" "protocol">.
 4: [ACCEPT] Continue, treating loading FASL for #<CL-SOURCE-FILE "cl-gearman" "src" "protocol"> as having been successful.
 5: [ABORT] Give up on "cl-gearman"
 --more--

Backtrace:
  0: (SB-C::%DEFCONSTANT ..)
  1: (SB-FASL::LOAD-FASL-GROUP ..)
  2: ((FLET SB-THREAD::WITH-RECURSIVE-LOCK-THUNK :IN SB-FASL::LOAD-AS-FASL))
  3: ((FLET #:WITHOUT-INTERRUPTS-BODY-88874 :IN SB-THREAD::CALL-WITH-RECURSIVE-LOCK))
  4: (SB-THREAD::CALL-WITH-RECURSIVE-LOCK ..)
  5: (SB-FASL::LOAD-AS-FASL ..)
  6: ((FLET SB-FASL::LOAD-STREAM :IN LOAD) ..)
  7: (LOAD ..)
  8: (SB-IMPL::%MAP-FOR-EFFECT-ARITY-1 ..)
$$/code


先日公開したcl-gearmanでこれが発生していてしまい原因がわからずそのまま放置していたのだけど、以下のforumを発見した。

[http://www.lispforum.com/viewtopic.php?f=33&t=4088](http://www.lispforum.com/viewtopic.php?f=33&t=4088)

> It's not a bug (in SBCL). The value in a DEFCONSTANT form is restricted
> to being something that's EQL to itself each time it's evaluated (that's
> horrible phrasing, I know), so using a vector is illegal (that is, you
> can use a vector, but you have to make sure you return the same vector
> each time -- so you can't use VECTOR or #(...) for the value).


DEFCONSTANTフォームの値はそれが何度評価されてもEQLになるようなものでなければならないらしい。
なので、vectorをDEFCONSTANTでバインドすることは可能だけど、DEFCONSTANTフォームの値の場所にVECTOR や #(...)で記述したフォームを書くことはできない。


CLtL2にもちゃんと書いてあった。

> defconstantはdefparameterに似ているが、名前の値が固定されていることを前提としており、コンパイラは、コンパイルされるプログラムでの値について仮定を置くことが許されている。 (...中略...) コンパイラは置き換えたオブジェクトのコピーが定数の実際の値とeqlになるように注意しなければならない。たとえば、コンパイラは数のコピーは自由に作ってもよいが、値がリストであるときは十分に注意しなければならない。


なるほど。
