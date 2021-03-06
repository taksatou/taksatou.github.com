---
categories: raspberry pi
date: 2013/04/28 01:30:01
title: Raspberry Pi はじめました
image: /images/raspberry-pi-150.png
---

![raspberry](/images/raspberry-pi-150.png)


前々から気になってたRaspberry Piを手に入れました。

最終的にはセンサーとかいろいろつけてインタラクティブなおもちゃをつくりたいですが、当面の目標は秋月電子で調達してきたLCDディスプレイに文字を表示させるためのドライバを書くことにしようと思います。


Raspberry Piのセットアップ手順はぐぐればすぐでてくるので割愛しますが、そのままだとsdcardの空き領域がつかえないので起動時にマウントできるようにするまでの手順だけメモしときます。


$$code
pi@raspberrypi ~ $ sudo fdisk /dev/mmcblk0

Command (m for help): p

Disk /dev/mmcblk0: 31.7 GB, 31674335232 bytes
4 heads, 16 sectors/track, 966624 cylinders, total 61863936 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00014d34

        Device Boot      Start         End      Blocks   Id  System
/dev/mmcblk0p1            8192      122879       57344    c  W95 FAT32 (LBA)
/dev/mmcblk0p2          122880     3788799     1832960   83  Linux

Command (m for help): n
Partition type:
   p   primary (2 primary, 0 extended, 2 free)
   e   extended
Select (default p):
Using default response p
Partition number (1-4, default 3):
Using default value 3
First sector (2048-61863935, default 2048): 3788800
Last sector, +sectors or +size{K,M,G} (3788800-61863935, default 61863935):
Using default value 61863935

Command (m for help): p

Disk /dev/mmcblk0: 31.7 GB, 31674335232 bytes
4 heads, 16 sectors/track, 966624 cylinders, total 61863936 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00014d34

        Device Boot      Start         End      Blocks   Id  System
/dev/mmcblk0p1            8192      122879       57344    c  W95 FAT32 (LBA)
/dev/mmcblk0p2          122880     3788799     1832960   83  Linux
/dev/mmcblk0p3         3788800    61863935    29037568   83  Linux

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 16: Device or resource busy.
The kernel still uses the old table. The new table will be used at
the next reboot or after you run partprobe(8) or kpartx(8)
Syncing disks.

pi@raspberrypi ~ $ sudo mkfs.ext4 /dev/mmcblk0p3
mke2fs 1.42.5 (29-Jul-2012)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
1815072 inodes, 7259392 blocks
362969 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=0
222 block groups
32768 blocks per group, 32768 fragments per group
8176 inodes per group
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000

Allocating group tables: done
Writing inode tables: done
Creating journal (32768 blocks):
done
Writing superblocks and filesystem accounting information: done


$$/code

上記のように、`fdisk`でパーティションをきってrebootしたあと、`mkfs.ext4`でフォーマットします。
最後に`/etc/fstab`に以下を追記してもう一度再起動して完了です。 マウントするディレクトリ(以下だと`/home`)は適当にかえてください。/homeにマウントする場合はpiユーザのホームディレクトリをコピーしておくといいと思います。

$$code
/dev/mmcblk0p3 /home            ext4    defaults,noatime  0       2
$$/code


$$code
pi@raspberrypi ~ $ df -h
Filesystem      Size  Used Avail Use% Mounted on
rootfs          1.8G  1.4G  246M  86% /
/dev/root       1.8G  1.4G  246M  86% /
devtmpfs        212M     0  212M   0% /dev
tmpfs            44M  276K   44M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs            88M     0   88M   0% /run/shm
/dev/mmcblk0p1   56M   19M   38M  34% /boot
/dev/mmcblk0p3   28G  172M   26G   1% /home

$$/code


<iframe src="http://rcm-jp.amazon.co.jp/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=armyofpigs-22&o=9&p=8&l=as4&m=amazon&f=ifr&ref=ss_til&asins=B003VNKNF0" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>
