// Copyright 2023 Lina <linazhokk@gmail.com>. All rights reserved.
// Use of this source code is governed by a MIT style
// license that can be found in the LICENSE file. The original repo for
// this file is https://github.com/MetaTime-JT/linablog.

package main

import (
	"github.com/linablog/internal/linablog"
	"os"

	_ "go.uber.org/automaxprocs"
)

// Go 程序的默认入口函数(主函数).
func main() {
	command := linablog.NewLinaBlogCommand()
	if err := command.Execute(); err != nil {
		os.Exit(1)
	}
}
