---
categories: unix, osx, mach-o, elf
date: 2013/05/22 11:57:05
title: semaphoreとmutexとspinlock
image: /images/matrix3.png
draft: True
---


* http://stackoverflow.com/questions/5869825/when-should-one-use-a-spinlock-instead-of-mutex
* http://stackoverflow.com/questions/195853/spinlock-versus-semaphore
* http://stackoverflow.com/questions/2065747/pthreads-mutex-vs-semaphore


## POSIX semaphores

* `man sem_overview`
* 


mutexを所有しようとしたときに、既に別スレッド所有されていて、それができなかった場合、そのスレッドはスリープしてCPUを他のスレッドに渡す。

スリープは起こされるまで続く。
それはそのmutexを所有していたスレッドがそれを開放したときになる。


In theory, when a thread tries to lock a mutex and it does not
succeed, because the mutex is already locked, it will go to sleep,
immediately allowing another thread to run. It will continue to sleep
until being woken up, which will be the case once the mutex is being
unlocked by whatever thread was holding the lock before. 

スレッドがspinlockしようとしたけどできなかった時、そのスレッドは成功するまでリトライをくりかえす。
そのため、ほかのスレッドにCPUを渡さない。
(しかし、そのスレッドのCPU時間をつかいきったら、OSは強制的にほかのスレッドにスイッチさせる)


When a tread
tries to lock a spinlock and it does not succeed, it will continuously
re-try locking it, until it finally succeeds; thus it will not allow
another thread to take its place (however, the operating system will
forcefully switch to another thread, once the CPU runtime quantum of
the current thread has been exceeded, of course).



The Problem

mutexの問題は、スレッドをスリープさせて再び起こすというのは高価な処理であるという点
これはかなりのCPUを消費するので時間もかかる。
もしmutexが短い時間だけロックされるのであれば、スレッドをスリープさせて再び起こすという処理が、
スレッドが実際にsleepしている時間より長かったり、
spinlockでずっとpollingするより長かったりする。


The problem with mutexes is that putting threads to sleep and waking
them up again are both rather expensive operations, they'll need quite
a lot of CPU instructions and thus also take some time. If now the
mutex was only locked for a very short amount of time, the time spent
in putting a thread to sleep and waking it up again might exceed the
time the thread has actually slept by far and it might even exceed the
time the thread would have wasted by constantly polling on a
spinlock. 


一方で、spinlockでpollingするのはCPU時間の無駄なので、長い時間lockするのであれば
sleepしたほうがよい

On the other hand, polling on a spinlock will constantly
waste CPU time and if the lock is held for a longer amount of time,
this will waste a lot more CPU time and it would have been much better
if the thread was sleeping instead.




The Solution

spinlockをシングルコアでつかうのは通常ナンセンス。
pollingしている限り、唯一のCPUコアをブロックするだけになる
ほかのスレッドが実行できないので、ロックをもってるスレッドも実行できない。

Using spinlocks on a single-core/single-CPU system makes usually no
sense, since as long as the spinlock polling is blocking the only
available CPU core, no other thread can run and since no other thread
can run, the lock won't be unlocked either. 

言いかえると、spinlockはCPU時間を単に無駄にする。
スレッドがスリープしていれば他のスレッドが実行できるので、そこでロックが開放されて、
次に最初のスレッドが起こされたときに処理を続けられるようになる

IOW, a spinlock wastes
only CPU time on those systems for no real benefit. If the thread was
put to sleep instead, another thread could have ran at once, possibly
unlocking the lock and then allowing the first thread to continue
processing, once it woke up again.


マルチコアCPUでは、たくさんの非常に短い時間のロックがあると、スレッドをsleepとwaking
させるのでパフォーマンスが劣化する場合がある。
spinlockをつかえばCPUの割り当て時間を有効に活用でき、結果的に
よいスループットがだせるる可能性がある。


On a multi-core/multi-CPU systems, with plenty of locks that are held
for a very short amount of time only, the time wasted for constantly
putting threads to sleep and waking them up again might decrease
runtime performance noticeably. When using spinlocks instead, threads
get the chance to take advantage of their full runtime quantum (always
only blocking for a very short time period, but then immediately
continue their work), leading to much higher processing throughput.




The Practice

通常、プログラマはどちらが適しているかわからないし
OSもそのコードがシングルコアとマルチコアのどちらに最適化されているのかわからない。
ほとんどのシステムはmutexとspinlockを厳格には区別しない
実際は、ハイブリッド


Since very often programmers cannot know in advance if mutexes or
spinlocks will be better (e.g. because the number of CPU cores of the
target architecture is unknown), nor can operating systems know if a
certain piece of code has been optimized for single-core or multi-core
environments, most systems don't strictly distinguish between mutexes
and spinlocks. In fact, most modern operating systems have hybrid
mutexes and hybrid spinlocks. What does that actually mean?




A hybrid mutex behaves like a spinlock at first on a multi-core
system. If a thread cannot lock the mutex, it won't be put to sleep
immediately, since the mutex might get unlocked pretty soon, so
instead the mutex will first behave exactly like a spinlock. Only if
the lock has still not been obtained after a certain amount of time
(or retries or any other measuring factor), the thread is really put
to sleep. If the same system runs on a system with only a single core,
the mutex will not spinlock, though, as, see above, that would not be
beneficial.

A hybrid spinlock behaves like a normal spinlock at first, but to
avoid wasting too much CPU time, it may have a back-off strategy. It
will usually not put the thread to sleep (since you don't want that to
happen when using a spinlock), but it may decide to stop the thread
(either immediately or after a certain amount of time) and allow
another thread to run, thus increasing chances that the spinlock is
unlocked (a pure thread switch is usually less expensive than one that
involves putting a thread to sleep and waking it up again later on,
though not by far).

Summary

If in doubt, use mutexes, they are usually the better choice and most
modern systems will allow them to spinlock for a very short amount of
time, if this seems beneficial. Using spinlocks can sometimes improve
performance, but only under certain conditions and the fact that you
are in doubt rather tells me, that you are not working on any project
currently where a spinlock might be beneficial. You might consider
using your own "lock object", that can either use a spinlock or a
mutex internally (e.g. this behavior could be configurable when
creating such an object), initially use mutexes everywhere and if you
think that using a spinlock somewhere might really help, give it a try
and compare the results (e.g. using a profiler), but be sure to test
both cases, a single-core and a multi-core system before you jump to
conclusions (and possibly different operating systems, if your code
will be cross-platform).
