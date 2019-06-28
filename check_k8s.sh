#!/usr/bin/env bash

set -ex

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/bin

until curl -s --fail http://kubernetes:10080/kubernetes-ready; do
    sleep 1;
done
echo "Kubernetes ready - run tests!"
curl http://kubernetes:10080/config > ./kube-config
export KUBECONFIG=./kube-config
kubectl config set clusters.kind.server https://kubernetes:8443
kubectl get nodes
