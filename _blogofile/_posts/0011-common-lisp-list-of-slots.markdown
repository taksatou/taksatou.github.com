---
categories: common lisp, sbcl, memo
date: 2012/07/6 18:30:00
title: sbclでクラスのスロット一覧を取得する方法
image: /images/lisp-logo.jpg
---

![lisp](/images/lisp-logo.jpg)

メモメモ


$$code(lang=lisp)
CL-USER> (sb-mop:class-slots (find-class 'sb-posix:stat))
(#<SB-MOP:STANDARD-EFFECTIVE-SLOT-DEFINITION SB-POSIX::MODE>
 #<SB-MOP:STANDARD-EFFECTIVE-SLOT-DEFINITION SB-POSIX::INO>
 #<SB-MOP:STANDARD-EFFECTIVE-SLOT-DEFINITION SB-POSIX::DEV>
 #<SB-MOP:STANDARD-EFFECTIVE-SLOT-DEFINITION SB-POSIX::NLINK>
 #<SB-MOP:STANDARD-EFFECTIVE-SLOT-DEFINITION SB-POSIX::UID>
 #<SB-MOP:STANDARD-EFFECTIVE-SLOT-DEFINITION SB-POSIX::GID>
 #<SB-MOP:STANDARD-EFFECTIVE-SLOT-DEFINITION SB-POSIX::SIZE>
 #<SB-MOP:STANDARD-EFFECTIVE-SLOT-DEFINITION SB-POSIX::ATIME>
 #<SB-MOP:STANDARD-EFFECTIVE-SLOT-DEFINITION SB-POSIX::MTIME>
 #<SB-MOP:STANDARD-EFFECTIVE-SLOT-DEFINITION SB-POSIX::CTIME>)
$$/code
