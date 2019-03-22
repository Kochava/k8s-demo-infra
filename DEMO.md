# Demo Steps

```
# kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.125.0.1   <none>        443/TCP   7m46s
```

```
# kubectl create namespace k8s-demo
namespace/k8s-demo created
```

```
# kubectl apply -f manifests/hello.v1.yml
deployment.apps/helloweb created
```

```
# kubectl -n k8s-demo -o wide get all
NAME                           READY   STATUS    RESTARTS   AGE   IP            NODE                                                 NOMINATED NODE
pod/frontend-55bc5dd4f-jxpqm   1/1     Running   0          80s   10.126.65.3   gke-k8s-demo-cluster-demo-cluster-01-db1121f6-v8zv   <none>

NAME                       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES                                SELECTOR
deployment.apps/frontend   1         1         1            1           81s   hello-app    gcr.io/google-samples/hello-app:1.0   app=frontend,tier=web

NAME                                 DESIRED   CURRENT   READY   AGE   CONTAINERS   IMAGES                                SELECTOR
replicaset.apps/frontend-55bc5dd4f   1         1         1       81s   hello-app    gcr.io/google-samples/hello-app:1.0   app=frontend,pod-template-hash=55bc5dd4f,tier=web
```

```
kubectl -n k8s-demo port-forward frontend-55bc5dd4f-jxpqm 8080:8080
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
Handling connection for 8080
Handling connection for 8080
```

```
# kubectl -n k8s-demo -o wide get service
NAME                TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE   SELECTOR
frontend-nodeport   NodePort   10.125.0.173   <none>        8080:32728/TCP   54s   app=frontend,tier=web
```

```
# kubectl -n k8s-demo -o wide get ingress
NAME          HOSTS   ADDRESS        PORTS   AGE
k8s-demo-lb   *       34.95.73.188   80      2m18s
```

