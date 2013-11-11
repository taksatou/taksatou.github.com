---
categories: go
date: 2013/11/11 19:11:37
title: Goのmakeとnew
draft: True
---

newはメモリを確保するためのもの
makeはsliceとmapとchannelを初期化するためのもの



Go has two allocation primitives, the built-in functions new and make. They do different things and apply to different types, which can be confusing, but the rules are simple. Let's talk about new first. It's a built-in function that allocates memory, but unlike its namesakes in some other languages it does not initialize the memory, it only zeros it. That is, new(T) allocates zeroed storage for a new item of type T and returns its address, a value of type *T. In Go terminology, it returns a pointer to a newly allocated zero value of type T.

Since the memory returned by new is zeroed, it's helpful to arrange when designing your data structures that the zero value of each type can be used without further initialization. This means a user of the data structure can create one with new and get right to work. For example, the documentation for bytes.Buffer states that "the zero value for Buffer is an empty buffer ready to use." Similarly, sync.Mutex does not have an explicit constructor or Init method. Instead, the zero value for a sync.Mutex is defined to be an unlocked mutex.

The zero-value-is-useful property works transitively. Consider this type declaration.

type SyncedBuffer struct {
    lock    sync.Mutex
        buffer  bytes.Buffer
        }
        Values of type SyncedBuffer are also ready to use immediately upon allocation or just declaration. In the next snippet, both p and v will work correctly without further arrangement.
        
        p := new(SyncedBuffer)  // type *SyncedBuffer
        var v SyncedBuffer      // type  SyncedBuffer
        
