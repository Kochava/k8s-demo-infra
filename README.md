# Kubernetes Demo Infrastructure

Creates Google CLoud Platform networks and GKE clusters to demonstrate kubernetes features and interaction in presentations.  Also includes manifiests for spinning up a simple chat application that the participants can interact with while we work through deployment pipelines.

## Google Cloud Platform Resources

There are several GCP resources that are set up with terraform in the us-central1 region:

* `k8s-demo-cluster-net`: VPC network for the GKE resources.
* `k8s-demo-cluster-net-us-central1`: Subnetwork containing 2 IP subnets to isolate service and pod traffic.
* `k8s-demo-cluster`: Kubernetes cluster (GKE) with the default node pool removed.
* `k8s-demo-cluster-pool-01`: Custom node pool for the demo cluster.

## Kubernetes Resources

* `redis.yml`: Stateful set with redis on a persistant data volume. 

## Applying Terraform Plans

```sh
terraform init
terraform plan -out plan.out
terraform apply plan.out
```

When you are done you can clean everything up with:
```sh
kubectl delete -f manifests/ingress.yml
terraform destroy
```

## Kubernetes

Grab your credentials for the demo cluster

```
gcloud container clusters get-credentials k8s-demo-cluster --region us-central1
```

## Demo Instructions

