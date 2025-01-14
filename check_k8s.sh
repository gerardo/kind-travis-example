#!/usr/bin/env bash

set +e
set -x

for (( i=0; i<90; ++i)); do
    #curl --fail http://kubernetes:10080/kubernetes-ready
    #curl http://kubernetes:10080/config
    sleep 100000;
done

exit 0
# until curl --fail http://kubernetes:10080/kubernetes-ready; do
#     curl http://kubernetes:10080/docker-ready
#     curl http://kubernetes:10080/config
#     sleep 1;
# done

echo "Kubernetes ready - run tests!"
curl http://kubernetes:10080/config > ./kube-config
export KUBECONFIG=./kube-config

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/bin

kubectl config set clusters.kind.server https://kubernetes:8443
kubectl get nodes
