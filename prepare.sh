#!/bin/bash
# 获取最新的kubeadm版本，以便下载最新的镜像
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubeadm
chmod +x ./kubeadm
mv ./kubeadm /usr/local/bin/kubeadm
# 通过以下命令获取最新镜像
kubeadm  config images pull
# 额外镜像
docker pull gcr.io/kubernetes-helm/tiller:v2.12.2
docker pull gcr.io/kubernetes-helm/tiller:v2.11.0
##其他莫名奇妙的镜像
docker pull docker.elastic.co/beats/filebeat:7.1.1
docker tag docker.elastic.co/beats/filebeat:7.1.1 imdingtalk/filebeat:7.1.1
docker push imdingtalk/filebeat:7.1.1
