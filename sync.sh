GCR_URL=k8s.gcr.io
old_GCR_URL=gcr.io
HUB=imdingtalk
# 获取核心镜像
images=(`docker images |grep -v TAG |  grep "k8s.gcr.io" | awk -F "/" '{for (i=2 ;i<=NF;i++) printf $i "/"; printf "\n" }' | awk '{print $1":"$2}'`)
# 获取额外镜像
ext_images=(`docker images |grep -v TAG | grep -v "k8s.gcr.io" | grep -v "$HUB" | awk -F "/" '{for (i=2 ;i<=NF;i++) printf $i "/"; printf "\n" }' | awk '{print $1":"$2}'`)
# 核心镜像到tag打
for imageName in ${images[@]} ; do
  docker tag  $GCR_URL/$imageName $HUB/$imageName
  docker rmi $GCR_URL/$imageName
  docker push $HUB/$imageName
done
# 额外镜像打tag
for imageName in ${ext_images[@]} ; do
  chimage=`echo $imageName| awk -F "/" '{print $2}'`
  docker tag  $old_GCR_URL/$imageName $HUB/$chimage
  docker rmi $old_GCR_URL/$imageName
  docker push $HUB/$chimage
done
# 列出镜像
echo "当前kubeadm版本信息如下:"
kubeadm  version
echo "对应镜像版本如下："
docker images | grep -E "kube|etcd|coredns|pause"
