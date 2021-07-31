#!/bin/sh
ps -ef|grep stopDemo|grep -v grep|awk '{print $1}'|xargs kill -15
