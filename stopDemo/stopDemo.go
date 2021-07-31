package main

import (
	"fmt"
	"os"
	"os/signal"
	"syscall"
	"time"
)

func main() {
	c:=make(chan os.Signal)
	signal.Notify(c,syscall.SIGTERM,syscall.SIGINT)
	go func() {
		for s:= range c{
			switch s {
			case syscall.SIGTERM, syscall.SIGINT:
				fmt.Println("退出",s)
				ExitFunc()
			default:
				fmt.Println("oth")
			}
		}
	}()
	printTime()
	fmt.Println("进程启动")
	time.Sleep(time.Duration(200000)*time.Second)
}
func ExitFunc()  {
	printTime()
	fmt.Println("正在退出...")
	fmt.Println("执行清理...")
	fmt.Println("退出完成...")
	os.Exit(0)
}
func printTime()  {
	new := time.Now()
	fmt.Println(new.Format("2006-01-02 15:04:05"))
}

