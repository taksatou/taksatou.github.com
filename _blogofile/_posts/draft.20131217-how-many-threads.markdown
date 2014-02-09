---
categories: linux, tuning
date: 2013/12/17 22:30:36
title: なプログラムの並列度をどこまであげればいいか
draft: True
---

ioバウンドなプログラムのチューニングにおいて、スレッド数やプロセス数をどれくらいまで増やせばいいのか、という問題がある。

パラメータを少しずついじりながらスループットと負荷の折り合いがつくあたりを探ることになるのだけど、本番サーバのスペックにばらつきがあったり負荷をかけるためのプログラムを書くのが手間だったりして、現実にはなかなか大変な作業になることが多い。

そこで、どのくらい並列度をあげたら頭打ちになるか調べられるような、ioバウンドなプログラムをシミュレートする簡単なプログラムをつくった。


$$code(lang=C)
#include <stdlib.h>
#include <stdio.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <pthread.h>

struct info {
    int fd, usec;
};
    
static void *loop(void *arg) {
    struct info *x = (struct info*)arg;
    for (int i = 0; i < 100000000; i++) {
        write(x->fd, " ", 1);
        usleep(x->usec);
    }
    return NULL;
}

int main(int argc, char *argv[]) {
    if (argc < 4) {
        fprintf(stderr, "usage: %s file usec threads\n", argv[0]);
        return 1;
    }
    
    int fd = open(argv[1], O_CREAT|O_RDWR|O_APPEND, 0644);
    if (fd < 0) {
        perror("open error");
        return 1;
    }
    int usec = atoi(argv[2]);
    int num = atoi(argv[3]);
    pthread_t *threads = calloc(num, sizeof(pthread_t));
    struct info x = { .fd = fd, .usec = usec};
    for (int j = 0; j < num; ++j) {
        pthread_create(&threads[j], NULL, loop, &x);
    }
    struct stat st, prev;
    fstat(fd, &st);
    prev = st;
    for (;;) {
        sleep(1);
        fstat(fd, &st);
        fprintf(stderr, "written: %ld\n", st.st_size - prev.st_size);
        prev = st;
    }
    fprintf(stderr, "done\n");
    return 0;
}
$$/code


