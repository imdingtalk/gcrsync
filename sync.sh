images=(`docker images | grep -v "TAG"| awk '{print $1":"$2}' | awk -F "/" '{print $2}'`)
GCR_URL=k8s.gcr.io
HUB=imdingtalk
# 打tag传到dockerhub
for imageName in ${images[@]} ; do
  docker tag  $GCR_URL/$imageName $HUB/$imageName
  docker rmi $GCR_URL/$imageName
  docker push $HUB/$imageName
done
