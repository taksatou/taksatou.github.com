---
categories: common lisp
date: 2012/11/09 23:00:00
title: Common Lispのdeclareについて
image: /images/lisp-alien-logo.png
---

![lisp](/images/lisp-alien-logo.png)

Common Lispのdeclareについて調べた。
変数の型や式に関することをコンパイラに伝えてやるために使うものらしい。

例えば、

$$code(lang=lisp)
(defun add (x y) (+ x y))
$$/code

は

$$code(lang=lisp)
(defun add (x y)
  (declare (fixnum x y))
  (the fixnum (+ x y)))
$$/code

とすれば、引数と戻り値の型を指定できる。

さらに、

$$code(lang=lisp)
(defun add (x y)
  (declare (optimize (speed 3) (safety 0)))
  (declare (fixnum x y))
  (the fixnum (+ x y)))
$$/code

とすればさらに最適化される。ここまですると、Cで実装した場合と遜色ないくらいになるらしい。

ためしにdisassembleしてみた。処理系はsbcl 1.0.55.0。

最初のバージョンは以下のようになった。すでにある程度最適化されてる？
LEA(load effective address)命令は、srcオペランドのアドレスを計算し、そのアドレスをdestオペランドにロードするというものらしい。[(参考)](http://ja.wikibooks.org/wiki/X86%E3%82%A2%E3%82%BB%E3%83%B3%E3%83%96%E3%83%A9/%E3%83%87%E3%83%BC%E3%82%BF%E8%BB%A2%E9%80%81%E5%91%BD%E4%BB%A4)


$$code(lang=lisp)
CL-USER> (defun add (x y) (+ x y))

CL-USER> (disassemble #'add)
; disassembly for ADD
; 03C43D5D:       488B55F8         MOV RDX, [RBP-8]           ; no-arg-parsing entry point
;       61:       488B7DF0         MOV RDI, [RBP-16]
;       65:       4C8D1C25E0010020 LEA R11, [#x200001E0]      ; GENERIC-+
;       6D:       41FFD3           CALL R11
;       70:       480F42E3         CMOVB RSP, RBX
;       74:       488BE5           MOV RSP, RBP
;       77:       F8               CLC
;       78:       5D               POP RBP
;       79:       C3               RET
;       7A:       CC0A             BREAK 10                   ; error trap
;       7C:       02               BYTE #X02
;       7D:       18               BYTE #X18                  ; INVALID-ARG-COUNT-ERROR
;       7E:       54               BYTE #X54                  ; RCX
$$/code

2番目の、型だけを宣言したものは以下のようになった。うーむ、確かに型チェックっぽいコードは増えてるが速くなってるわけではなさそうな感じ。あとで調べる。


$$code(lang=lisp)
CL-USER> (defun add (x y)
           (declare (fixnum x y))
           (the fixnum (+ x y)))

CL-USER> (disassemble #'add)
; disassembly for ADD
; 039D3B73:       488BD1           MOV RDX, RCX               ; no-arg-parsing entry point
;       76:       48D1FA           SAR RDX, 1
;       79:       488BC7           MOV RAX, RDI
;       7C:       48D1F8           SAR RAX, 1
;       7F:       4801C2           ADD RDX, RAX
;       82:       48B80000000000000040 MOV RAX, 4611686018427387904
;       8C:       4801D0           ADD RAX, RDX
;       8F:       48C1E83F         SHR RAX, 63
;       93:       7509             JNE L0
;       95:       48D1E2           SHL RDX, 1
;       98:       488BE5           MOV RSP, RBP
;       9B:       F8               CLC
;       9C:       5D               POP RBP
;       9D:       C3               RET
;       9E: L0:   486BC202         IMUL RAX, RDX, 2
;       A2:       710E             JNO L1
;       A4:       488BC2           MOV RAX, RDX
;       A7:       4C8D1C25B0050020 LEA R11, [#x200005B0]      ; ALLOC-SIGNED-BIGNUM-IN-RAX
;       AF:       41FFD3           CALL R11
;       B2: L1:   488B1557FFFFFF   MOV RDX, [RIP-169]         ; 'FIXNUM
;       B9:       CC0A             BREAK 10                   ; error trap
;       BB:       03               BYTE #X03
;       BC:       1F               BYTE #X1F                  ; OBJECT-NOT-TYPE-ERROR
;       BD:       15               BYTE #X15                  ; RAX
;       BE:       95               BYTE #X95                  ; RDX
;       BF:       CC0A             BREAK 10                   ; error trap
;       C1:       02               BYTE #X02
;       C2:       18               BYTE #X18                  ; INVALID-ARG-COUNT-ERROR
;       C3:       54               BYTE #X54                  ; RCX
;       C4:       CC0A             BREAK 10                   ; error trap
;       C6:       02               BYTE #X02
;       C7:       08               BYTE #X08                  ; OBJECT-NOT-FIXNUM-ERROR
;       C8:       95               BYTE #X95                  ; RDX
;       C9:       CC0A             BREAK 10                   ; error trap
;       CB:       04               BYTE #X04
;       CC:       08               BYTE #X08                  ; OBJECT-NOT-FIXNUM-ERROR
;       CD:       FED501           BYTE #XFE, #XD5, #X01      ; RDI

$$/code

最後の最適化の宣言をつけたものは以下のようになった。たしかに速そうにはなった。

$$code(lang=lisp)
CL-USER> (defun add (x y)
           (declare (optimize (speed 3) (safety 0)))
           (declare (fixnum x y))
           (the fixnum (+ x y)))

CL-USER> (disassemble #'add)
; disassembly for ADD
; 034DD10F:       4801FA           ADD RDX, RDI               ; no-arg-parsing entry point
;       12:       488BE5           MOV RSP, RBP
;       15:       F8               CLC
;       16:       5D               POP RBP
;       17:       C3               RET
$$/code


ついでにCで書いた以下の関数もdisassebleしてみた。

$$code(lang=c)
int add(int x, int y) {
    return x + y;
}
$$/code

```cc -c a.c && objdump -d a.o``` とすると、

$$code(lang=adb)
a.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <add>:
   0:   55                      push   %rbp
   1:   48 89 e5                mov    %rsp,%rbp
   4:   89 7d fc                mov    %edi,-0x4(%rbp)
   7:   89 75 f8                mov    %esi,-0x8(%rbp)
   a:   8b 45 f8                mov    -0x8(%rbp),%eax
   d:   8b 55 fc                mov    -0x4(%rbp),%edx
  10:   01 d0                   add    %edx,%eax
  12:   5d                      pop    %rbp
  13:   c3                      retq
$$/code

```cc -O3 -c a.c && objdump -d a.o``` なら、

$$code(lang=adb)
a.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <add>:
   0:   8d 04 37                lea    (%rdi,%rsi,1),%eax
   3:   c3                      retq
$$/code

まあとりあえず単純に命令数だけでいうと、
素のSBCL > 素のGCC > 最適化したSBCL > 最適化したGCC
という感じにはなったので、CよりLispのほうが速い(場合もある)というふれこみは嘘ではなさそうですね。
