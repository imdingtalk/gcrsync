#!/bin/bash
# 获取最新的kubeadm版本，以便下载最新的镜像
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubeadm
chmod +x ./kubeadm
mv ./kubeadm /usr/local/bin/kubeadm
# 通过以下命令获取最新镜像
kubeadm  config images pull
