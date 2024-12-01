### Create Kubernetes Dashboard admin token

```bash
kubectl -n kubernetes-dashboard create token admin-user
```

### Use port-forward to expose Kubernetes Dashboard on `https://localhost:8443`
```bash
kubectl port-forward svc/kubernetes-dashboard-kong-proxy -n kubernetes-dashboard 8443:443
```
