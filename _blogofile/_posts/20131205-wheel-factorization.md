---
categories: algorithm
date: 2013/12/05 11:55:58
title: 
draft: True
---

比較的大きな数値を素因数分解したいときがある。

32bitの数値なら単に平方根までの数字で全部割ってみるだけで十分なときが多いけど、64bitだとちょっと無理。

エラトステネスの篩をつかえば多少は速くなるけど、素因数分解したい数値の平方根のサイズの配列をもたなくちゃいけないので、結局64bitで無理なのは変わらない。

ちょうど手元にあったちょっと古めの[coreutilsのfactorコマンドのソース](http://git.savannah.gnu.org/cgit/coreutils.git/tree/src/factor.c?id=c7fca77515cc0c55f2c47c9f18c313aaef80922c)をみてみたところ、wheel factrizationという方法が使われていた。(2012年頃書き直されたらしくいまはつかわれていない)

* [wheel factorization](http://primes.utm.edu/glossary/page.php?sort=WheelFactorization ) 
* http://en.wikipedia.org/wiki/Wheel_factorization





To see if a number is prime via trial division (or to find its prime
factors), we divide by all of the primes less than (or equal to) its
square root.  Rather than divide by just the primes, it is sometimes
more practical to divide by 2, 3, and 5; then divide by all the
numbers congruent to 1, 7, 11, 13, 17, 19, 23, and 29 modulo 30
--again stopping when you reach the square root. These are the positive
integers less than, and relatively prime to, the primes 2, 3 and 5.


ある数字がprimeかどうか(もしくは素因数かどうか)trial divisionで調べるためには、その平方根までのすべての素数で割ることになる。
単に素数でわるのでなく、2,3,5で割ってみたほうがより実践的な場合がある。
それから1, 7, 11, 13, 17, 19, 23, and 29で割る。
再び平方根に達したら終了する。
これらは、2,3,5の


This type of factorization is called wheel factorization and the
spokes are the list of integers prime to all of the primes we are
using.  To see if 3331 is prime using the wheel mentioned above, we
would divide by 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43,
47, 49, and 53.  Notice that 49 is not prime, but is relatively prime
to the spokes of the wheel.


この種の因数分解はwheel factorizationと呼ばれ、スポークは


Wheel factorization is special type of sieve.

Wheels can be made of any size. The simplest wheel would be created by just using the single prime 2, and there would be one spoke: 1 (so we would divide by 2, then each of the odd integers).  A little more complicated wheel would use the primes 2 and 3. This would give us two spokes: 1 and 5. So we would divide by 2, 3 then the following integers:

5, 7, 11, 13, 17, 19, 23, 25, 29, 31, 35, 37, 41, 43, ...
This is the same as writing the integers in a table of width 6--all of the primes (other than 2 or 3) end up in the columns corresponding to the two spokes 1 and 5.  (The primes are colored blue.)
1    2  3   4    5  6
7    8  9   10   11 12
13   14 15  16   17 18
19   20 21  22   23 24
25   26 27  28   29 30
31   32 33  34   35 36
37   38 39  40   41 42
If we start with the primes 2, 3, 5, and 7; then we must check the numbers modulo 210 (the product of these four primes) which are congruent to the spokes:

1, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 121, 127, 131, 137, 139, 143, 149, 151, 157, 163, 167, 169, 173, 179, 181, 187, 191, 193, 197, 199, and 209.
Notice that other than 1, the smallest spokes in these wheels are all prime (the composites are colored red).  This is because any number less than the square of the largest prime used in the wheel, not removed by the wheel, must be prime.  This has misled many to suppose that such wheels (and patterns) are good "generators" of primes.  They are not.  The density of primes decreases as the integers increase in size (see the prime number theorem), so when we apply these same wheels to a list of large integers, almost all of those that are not removed by the wheel are composite.
Notice that the simple wheel based on 2 and 3 removed 4/6 = 2/3 rds of the composites.  The larger wheel using 2, 3, 5, and 7 will remove 162/210 (over 77%) of the composites. 

Large wheels are not particularly efficient.  To remove 90% of the composites, we must use the primes up to 251.  95% requires the primes to 75,037.  96% requires the primes to 1,246,379.  97% requires the primes to 134,253,593!  Just imagine how many primes you will need to remove 99% of the composites!















Wikipediaで調べてみると、[Pollard's rho algorithm](http://ja.wikipedia.org/wiki/%E3%83%9D%E3%83%A9%E3%83%BC%E3%83%89%E3%83%BB%E3%83%AD%E3%83%BC%E7%B4%A0%E5%9B%A0%E6%95%B0%E5%88%86%E8%A7%A3%E6%B3%95 ) というのがみつかる

