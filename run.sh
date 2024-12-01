#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

printf "${GREEN}Adding ArgoCD Helm repo${NC}\n"
helm repo add argocd https://argoproj.github.io/argo-helm

printf "${GREEN}Installing ArgoCD with Helm${NC}\n"
helm install argocd argocd/argo-cd --version 7.7.6 \
  -f ./argocd-bootstrap/helm/argocd-values.yaml \
  --create-namespace \
  -n argocd

printf "${GREEN}Applying K8s manifests to finish ArgoCD bootstrap${NC}\n"
kubectl apply -f ./argocd-bootstrap/manifests/

ARGOPASS=$(argocd admin initial-password -n argocd | head -n 1)
printf "${GREEN}ArgoCD admin password${NC}: ${RED}${ARGOPASS}${NC}\n"

printf "${GREEN}To get access to ArgoCD UI run command:${NC}\n"
printf "    kubectl port-forward svc/argocd-server -n argocd 8080:443$\n"
printf "${GREEN}Open http://localhost:8080 in webbrowser${NC}\n"
