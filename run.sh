#!/bin/bash

echo "Adding ArgoCD Helm repo"
helm repo add argocd https://argoproj.github.io/argo-helm

echo "Installing ArgoCD with Helm"
helm install argocd argocd/argo-cd --version 7.7.6 \
  -f ./bootstrap/helm/argocd-values.yaml \
  --create-namespace \
  -n argocd

echo "Applying K8s manifests to finish ArgoCD bootstrap"
kubectl apply -f ./bootstrap/manifests/

echo "Getting ArgoCD admin password"
argocd admin initial-password -n argocd

echo "To get access to ArgoCD UI run command:"
echo "    kubectl port-forward svc/argocd-server -n argocd 8080:443"
echo "Open http://localhost:8080 in webbrowser"
