package main

import (
	"fmt"
	"time"
)

func main() {
	new := time.Now()

	fmt.Println("Hello World")
	fmt.Println(new.Format("2006-01-02 15:04:05"))
}

