provider "google" {
  version = "3.5.0"

  credentials = file("blade-ai-bd37d3c584bb.json")

  project = "blade-ai-280814"
  region  = "us-central1"
  zone    = "us-central1-c"
}

/// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}



resource "google_compute_firewall" "default" {
  name    = "terraform-firewall"
  network = "default"
 

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000", "22"]
  }

  source_tags = ["ssh"]
}  

resource "google_compute_instance" "vm_instance" {
  name         = "tf-blade-${random_id.instance_id.hex}"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
     image = "debian-cloud/debian-9"
    }
  }

  network_interface {
   network = "default"
    access_config {
    }
  }
  metadata_startup_script = "sudo apt-get update; sudo apt-get install; cd ~;git clone https://github.com/hashicorp/learn-terraform-provision-gke-cluster; cd learn-terraform-provision-gke-cluster"
 
 metadata = {
   ssh-keys = "bladeaico:${file("/Users/kapilsreedharan/.ssh/id_rsa_bladeaico.pub")}"
 }

}

resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}

// A variable for extracting the external IP address of the instance
output "ip" {
 value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}
