#!/bin/bash
now=`date "+%Y-%m-%d %H:%M:%S"`
kubeadm_info=`kubeadm version`
echo $now > changelog/version.txt
echo $kubeadm_info >> changelog/version.txt
echo "当前版本的核心镜像如下：" >> changelog/version.txt
docker images | grep -E "kube-controller|kube-proxy|kube-apiserver|kube-scheduler|coredns|etcd|pause" | awk '{print $1":"$2}' >> changelog/version.txt
