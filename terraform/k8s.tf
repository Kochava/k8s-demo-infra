data "google_container_engine_versions" "default" {
  zone = "us-central1-c"
}

resource "google_container_cluster" "k8s-demo-cluster" {
  name   = "k8s-demo-cluster"
  region = "us-central1"
  network = "${google_compute_subnetwork.k8s-demo-net-us-central1.self_link}"
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count = 1
  min_master_version = "${data.google_container_engine_versions.default.latest_master_version}"
  network            = "${google_compute_network.k8s-demo-net.self_link}"
  subnetwork         = "${google_compute_subnetwork.k8s-demo-net-us-central1.self_link}"

  ip_allocation_policy {
    cluster_secondary_range_name  = "${local.k8s_pods}"
    services_secondary_range_name = "${local.k8s_services}"
  }
}

resource "google_container_node_pool" "k8s-demo-cluster-pool-01" {
  name       = "demo-cluster-01"
  region     = "us-central1"
  cluster    = "${google_container_cluster.k8s-demo-cluster.name}"
  node_count = 1

  autoscaling {
    min_node_count = 3
    max_node_count = 31
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/sqlservice.admin",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

# data "google_client_config" "current" {}

# provider "kubernetes" {
#   host     = "https://${google_container_cluster.k8s-demo-cluster.endpoint}"
#   cluster_ca_certificate = "${base64decode(google_container_cluster.k8s-demo-cluster.master_auth.0.cluster_ca_certificate)}"
#   token = "${data.google_client_config.current.access_token}"
# }

