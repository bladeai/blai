
# GKE cluster
provider "google" {
  project  = "blade-ai-282114"
  region   = "europe-west3"
}

resource "google_container_cluster" "gke-cluster" {
  name               = "bladeai-gke-cluster"
  network            = "default"
  location = "europe-west3-a"
  initial_node_count = 3
  node_config {
    machine_type = "e2-standard-2"
  }
}

