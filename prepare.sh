#!/bin/bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubeadm
chmod +x ./kubeadm
mv ./kubeadm /usr/local/bin/kubeadm
kubeadm  config images pull
