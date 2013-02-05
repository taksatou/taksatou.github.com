---
categories: common lisp
date: 2013/1/31 20:00:00
title: sbcl
draft: True
---

http://www.lispforum.com/viewtopic.php?f=33&t=4088

It's not a bug (in SBCL). The value in a DEFCONSTANT form is restricted to being something that's EQL to itself each time it's evaluated (that's horrible phrasing, I know), so using a vector is illegal (that is, you can use a vector, but you have to make sure you return the same vector each time -- so you can't use VECTOR or #(...) for the value).

