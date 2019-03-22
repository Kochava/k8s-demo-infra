resource "google_compute_network" "k8s-demo-net" {
  name                    = "k8s-demo-net"
  auto_create_subnetworks = false
}

locals {
  k8s_services = "k8s-demo-net-us-central1-services"
  k8s_pods     = "k8s-demo-net-us-central1-pods"
}

resource "google_compute_subnetwork" "k8s-demo-net-us-central1" {
  name        = "k8s-demo-net-us-central1"
  description = "us-central1 subnet for kubernetes"

  network = "${google_compute_network.k8s-demo-net.self_link}"
  region  = "us-central1"

  ip_cidr_range = "10.126.4.0/23"

  secondary_ip_range {
    range_name    = "${local.k8s_pods}"
    ip_cidr_range = "10.126.64.0/19"
  }

  secondary_ip_range {
    range_name    = "${local.k8s_services}"
    ip_cidr_range = "10.125.0.0/21"
  }
}

resource "google_compute_global_address" "k8s-demo-global-address" {
  name = "k8s-demo-global-address"
  address_type = "EXTERNAL"
}