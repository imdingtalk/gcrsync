package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"
	"strconv"
	"time"
)

func main() {
	apiUrl := "http://localhost:3100/loki/api/v1/query_range"
	//params
	data := url.Values{}
	data.Set("limit", "1000")
	data.Set("query", "{app=\"workspace-be\"}")
	data.Set("start", strconv.FormatInt(time.Now().UnixNano()-50e9, 10))
	data.Set("end", strconv.FormatInt(time.Now().UnixNano(), 10))

	u, err := url.ParseRequestURI(apiUrl)
	if err != nil {
		fmt.Printf("parse url requestUrl failed,err:%v\n", err)
	}
	u.RawQuery = data.Encode() // URL encode

	fmt.Println(u.String())

	resp, err := http.Get(u.String())
	if err != nil {
		fmt.Println("post failed, err:%v\n", err)
		return
	}
	defer resp.Body.Close()

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		fmt.Println("get resp failed,err:%v\n", err)
		return
	}
	hit := string(b)
	var result map[string]interface{}
	json.Unmarshal([]byte(hit), &result)
	birds := result["data"].(map[string]interface{})
	for _, value := range birds {
		// Each value is an interface{} type, that is type asserted as a string
		fmt.Println(value)
	}
	// fmt.Println(hit)

}
