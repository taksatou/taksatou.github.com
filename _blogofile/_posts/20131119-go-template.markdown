---
categories: golang
date: 2013/11/19 19:19:57
title: Goのtemplateパッケージ簡易チートシート
---

goに標準でついてるtemplateパッケージは便利なのだけど、[マニュアル](http://golang.org/pkg/text/template/ )が長すぎるのでよく使う機能だけまとめておく。

そろそろだれかテンプレートエンジンを標準化してほしい。

[TOC]

## 基本

$$code(lang=go)
package main

import (
	"os"
	"text/template"
)

func main() {
	tmpl := "Hello, {{.template}}!"
	t := template.New("t")
	template.Must(t.Parse(tmpl))
	t.Execute(os.Stdout, map[string]string{"template": "World"})
}
$$/code

ちなみに、```template.Must(t.Parse(tmpl))```は以下のショートカット

$$code(lang=go)
_, err := t.Parse(tmpl)
if err != nil {
	panic(err)
}
$$/code



## 変数展開

通常はmapのキーかstructのメンバを`.Key`のようにドット付きで指定するとでその値が展開される。
ただし、該当するキーが見つからなかった場合、mapでは`<no value>`という文字列が出力されるが、structではエラーになる。

$$code(lang=go)
type T struct {
	Name string
}

tmpl := "Hello, {{.Name}}!\n"
t := template.New("t")
template.Must(t.Parse(tmpl))

t.Execute(os.Stdout, map[string]string{"Name": "map"})
t.Execute(os.Stdout, T{Name: "struct"})
t.Execute(os.Stdout, &T{Name: "struct reference"})
$$/code


`.`のようにドットだけを渡すと変数それ自体が展開される。

$$code(lang=go)
tmpl := "Hello, {{.}}!\n"
t := template.New("t")
template.Must(t.Parse(tmpl))
t.Execute(os.Stdout, "World")
$$/code



## 関数呼び出し

関数はシェルのパイプのように連結させて呼びだせる。テンプレート内で呼ぶ関数は`template.FuncMap`で渡す。

$$code(lang=go)
tmpl := `Now {{now}}, {{"hello" | toupper}}`
t := template.New("t")
t.Funcs(template.FuncMap{
	"now":     func() string { return time.Now().String() },
	"toupper": strings.ToUpper,
})
template.Must(t.Parse(tmpl))
t.Execute(os.Stdout, nil) // => Now 2013-11-19 19:17:51.378063751 +0900 JST, HELLO
$$/code



## ループ

組み込みの`range` Actionをつかえばよい。

$$code(lang=go)
type T struct{ Name string }
tmpl := `
{{range .}}- {{.Name}}
{{end}}
`
t := template.New("t")
template.Must(t.Parse(tmpl))
t.Execute(os.Stdout, []T{
	{Name: "Alice"},
	{Name: "Bob"},
	{Name: "Charlie"},
	{Name: "Dave"},
})
$$/code

その他、条件分岐等のActionは [マニュアルのActionsの](http://golang.org/pkg/text/template/#hdr-Actions ) 参照



## 組み込み関数

こちらも [マニュアルのFunctionsの項](http://golang.org/pkg/text/template/#hdr-Functions ) を参照

