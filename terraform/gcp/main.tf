resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
 network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y git
    git clone https://github.com/Emaydannikov/python.advanced.reminder.git /home
    EOF
}
