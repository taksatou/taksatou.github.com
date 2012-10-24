---
categories: common lisp, programming
date: 2012/10/24 18:00:00
title: 'Common Lisp練習 - CodeChef : TSORT'
image: /images/codechef-logo.png
---

![codechef](/images/codechef-logo.png)

Common Lispの練習にCodeChefの↓の練習問題をやってみた。

[http://www.codechef.com/problems/TSORT](http://www.codechef.com/problems/TSORT)


問題自体は全然難しくないけど、Common Lispで解こうとしたらTime Limit Exceededでおちてしまった。

最初は以下のように書いて、

$$code(lang=lisp)
(let ((_n (parse-integer (read-line)))
      (lis ()))
  (dotimes (i _n)
    (push (parse-integer (read-line)) lis))
  (setf lis (sort lis #'(lambda (x y) (< x y))))
  (dolist (x lis) (format t "~a~%" x)))
$$/code

以下の用にして時間を測ったところ

$$code(lang=bash)
$ time ruby -e 'n=1000000;puts n; n.times{puts (rand * 10000000).to_i}' | sbcl --script turbosort.cl > /dev/null
ruby -e 'n=1000000;puts n; n.times{puts (rand * 10000000).to_i}'  1.19s user 0.01s system 91% cpu 1.311 total
sbcl --script turbosort.cl > /dev/null  3.42s user 0.43s system 97% cpu 3.938 total
$$/code

ローカルだと3.42s程度だった。codechef上での制限は5secなのでセーフかと思ったけどTime Limit Exceededだった。

そこで、vectorを使うように改良

$$code(lang=lisp)
(let* ((_n (parse-integer (read-line)))
       (lis (make-array _n :fill-pointer 0)))
  (dotimes (i _n)
    (vector-push (parse-integer (read-line)) lis))
  (setf lis (sort lis #'(lambda (x y) (< x y))))
  (loop for i across lis do (format t "~a~%" i)))
$$/code

$$code(lang=bash)
$ time ruby -e 'n=1000000;puts n; n.times{puts (rand * 10000000).to_i}' | sbcl --script turbosort.cl > /dev/null
ruby -e 'n=1000000;puts n; n.times{puts (rand * 10000000).to_i}'  1.21s user 0.01s system 94% cpu 1.289 total
sbcl --script turbosort.cl > /dev/null  2.64s user 0.44s system 98% cpu 3.137 total
$$/code

若干改善されたが、まだTime Limit Exceededだった。

read-sequenceで読み込んだほうが早いかと思って以下のように書いてみた。

$$code(lang=lisp)
(defun parse-input (str)
  (loop
     for i = 0 then (+ 1 j)
     as j = (position #\Newline str :start i)
     as k = (parse-integer (subseq str i j) :junk-allowed t)
     if (not (null k))
     collect k
     while j))

(let* ((_n (parse-integer (read-line)))
       (lis (make-array (* _n 20) :element-type 'character))
       (nums ())
       )
  (read-sequence lis *standard-input*)
  (setf nums (sort (parse-input lis) #'(lambda (x y) (< x y))))
  (loop for i in nums do (format t "~a~%" i)))
$$/code


$$code(lang=bash)
$ time ruby -e 'n=1000000;puts n; n.times{puts (rand * 10000000).to_i}' | sbcl --script turbosort.cl > /dev/null
ruby -e 'n=1000000;puts n; n.times{puts (rand * 10000000).to_i}'  1.13s user 0.01s system 97% cpu 1.159 total
sbcl --script turbosort.cl > /dev/null  3.67s user 0.48s system 96% cpu 4.297 total
$$/code

残念ながら逆に遅くなってしまった。parse-inputの部分で60%くらい時間がかかっていた。
あと、```#'(lambda (x y) (< x y))```の部分を ```#'<```にするとなぜか遅くなる。

[まだ誰もlispではパスしてない模様。](http://www.codechef.com/status/TSORT?language=31&status=All&handle=&sort_by=All&sorting_order=asc&Submit=GO)こういうのをもっと高速に書く方法あるのだろうか。


ちなみにCだと余裕。ローカルだと0.2秒くらいだけどリモートでは3秒くらいかかってた。そもそもCodeChefの実行環境がしょぼすぎる疑惑が。。

$$code(lang=c)
#include <stdio.h>
#include <stdlib.h>

int f(const void *i, const void *j) {
    return *((int*)i) > *((int*)j);
}

int main(void) {
    char buf[256];
    int num = atoi(fgets(buf, 256, stdin));

    int lis[num];
    for (int i = 0; i < num; ++i) {
        lis[i] = atoi(fgets(buf, 256, stdin));
    }
    qsort(lis, num, sizeof(int), f);
    for (int i = 0; i < num; ++i) {
        printf("%d\n", lis[i]);
    }

$$/code


$$code(lang=bash)
$ time ruby -e 'n=1000000;puts n; n.times{puts (rand * 10000000).to_i}' | ./a.out > /dev/null
ruby -e 'n=1000000;puts n; n.times{puts (rand * 10000000).to_i}'  0.99s user 0.01s system 99% cpu 1.006 total
./a.out > /dev/null  0.18s user 0.01s system 17% cpu 1.116 total
$$/code
