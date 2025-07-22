#!/bin/bash
kubectl create configmap chihaya-config --from-file=chihaya.yaml
kubectl apply -f chihaya-deployment.yaml
kubectl apply -f chihaya-service.yaml