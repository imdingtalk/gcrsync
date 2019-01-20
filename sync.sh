images=(`docker images |grep -v TAG | awk -F "/" '{for (i=2 ;i<=NF;i++) printf $i "/"; printf "\n" }' | awk '{print $1":"$2}'`)
GCR_URL=k8s.gcr.io
old_GCR_URL=gcr.io
HUB=imdingtalk
# 打tag传到dockerhub
for imageName in ${images[@]} ; do
  docker tag  $GCR_URL/$imageName $HUB/$imageName
  if ( $? != 0 ); then
    docker tag  $old_GCR_URL/$imageName $HUB/$imageName
  fi
  docker rmi $GCR_URL/$imageName
  if ( $? != 0) ; then
    docker rmi $old_GCR_URL/$imageName
  fi
  docker push $HUB/$imageName
done

