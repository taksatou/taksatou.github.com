---
categories: bitcoin
date: 2013/11/19 19:19:57
title: 
draft: True
---


https://en.bitcoin.it/wiki/Blocks

## Blockとは

Data is permanently recorded in the Bitcoin network through files
called blocks. 

データはitcoinネットワーク上にblocksと呼ばれるファイルとして永続的に保存される


A block is a record of some or all of the most recent
Bitcoin transactions that have not yet been recorded in any prior
blocks. 


あるblockはまだ他のブロックに記録されていない Bitcoinのトランザクション の記録


They could be thought of like the individual pages of a city
recorder's recordbook (where changes to title to real estate are
recorded) or a stock transaction ledger. 

それは (不動産の所有権の変更を記録する) 記録台帳の個々のページや株式元帳のようなものだと考えることができる


In all but a few exceptional
cases, new blocks are added to the end of the record (known in Bitcoin
as the block chain), and once written, are never changed or
removed. 

わずかな例外を除いて、新しいblockはrecordの末尾に追加され、一旦書き込まれると、二度と変更や削除はできない

Each block memorializes what took place immediately before it
was created.

それぞれのblockはそれぞれが生成される直前に何が起こったかを記録するものである


##

それぞれのblockは、主に直近のトランザクションの一部または全てをヘッダと、その直前におきたものへの参照からなる。

Each block contains, among other things, in its block header a record
of some or all recent transactions, and a reference to the block that
came immediately before it. 


また、blockは難しい数学のパズルの答えを含んており、その値はすべてのblockでユニークなものとなる

It also contains an answer to a
difficult-to-solve mathematical puzzle - the answer to which is unique
to each block. 


新しいblockは正解でないとネットワーク上に提出できない

New blocks can't be submitted to the network without
the correct answer - 

Miningプロセスは基本的には現在のブロックを解くような答えを次に見つけることを競うこと

the process of "Mining" is essentially the
process of competing to be the next
to find the answer that "solves"
the current block. 


その数学の問題は難しいが、一旦有効な解が見つかると、それが正しいかどうかをネットワーク上で確認するのは非常に簡単

The mathematical problem in each block is difficult
to solve, but once a valid solution is found, it is very easy for the
rest of the network to confirm that the solution is correct. 

複数の解が存在するが、blockを解くためには一つの解だけでよい

There are
multiple valid solutions for any given block - only one of the
solutions needs to be found for the block to be solved.


それぞれのblockを解くと新しいBitcoinが発行されるので、それぞれのblockにはどのBitcoinが対応するかも記録される

Because there is a reward of brand new Bitcoins for solving each
block, every block also contains a record of which Bitcoin address is
entitled to receive the reward. 

このレコードはgeneration transactionもしくはcoinbase transactionとして知られており、すべてのblockの最初のtransactionとなる

This record is known as a generation
transaction, or a coinbase transaction, and is always the first
transaction appearing in every block. 

blockあたりで得られるBitcoinの数は50から初まり210,000 blocks毎に半分になる(大体4年ごと)

The number of Bitcoins generated
per block starts at 50 and is halved every 210,000 blocks (about four
years).


Bitcoin transactionはネットワーク上にbroadcastされ、すべてのpeerは
blockを解き、transaction recordを集め、解こうとしているblockにそれを追加する

Bitcoin transactions are broadcast to the network by the sender, and
all peers trying to solve blocks, collect the transaction records and
add them to the block they're working to solve.


問題の難しさは平均で1時間あたり6blockが解ける程度になるようにネットワークによって自動的に調整される

The difficulty of the mathematical problem is automatically adjusted
by the network, such that it targets a goal of solving an average of 6
blocks per hour.

2016block毎(大体2週間毎)に、すべてのBitcoin clientは実際に生成された数を比較して調整する
Every 2016 blocks (about two weeks), all Bitcoin
clients compare the actual number created with this goal and modify
the target by the percentage that it varied. 

これによって難易度が増えたりへったりする
This increases (or decreases) the difficulty of generating blocks.


それぞれのblockは直前前のblockへの参照をもっているので、すべての
blockはチェーン状をなしているといえる

Because each block contains a reference to the prior block, the
collection of all blocks in existence can be said to form a
chain. 

しかし、チェーンは分岐する可能性がある
例えば、二人のminerがある1つのblockについてお互い未知の状態で同時に二つの異なる解に至った場合がある

However, it's possible for the chain to have temporary splits -
for example, if two miners arrive at two different valid solutions for
the same block at the same time, unbeknownst to one another. 

p2pネットワークはこのような分岐を解決するように設計されているので、
片方のみが生き残るようになっている

The peer-to-peer network is designed to resolve these splits within a
short period of time, so that only one branch of the chain survives.


clientはlongestなchainを有効とみなす

The client accepts the 'longest' chain of blocks as valid. 


block chainのlengthは、block数ではなく難しさで測る
The 'length' of the entire block chain refers to the chain with the most
combined difficulty, not the one with the most blocks. 

これによって簡単でたくさんのblockがlongestとしてネットワークにacceptされるのを防ぐ

This prevents someone from forking the chain and creating a large number of
low-difficulty blocks, and having it accepted by the network as
'longest'.






http://blockexplorer.com/q/getblockcount

http://bitcoin.stackexchange.com/questions/12603/the-bitcoin-mining-algorithm-from-a-programmers-viewpoint

1. blockをbitcoinネットワークからあつめる
2. 



# bitcoinの採掘が一般人には無理ゲーな理由
































