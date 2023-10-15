resource "google_compute_instance" "vm_instance" {
  name         = "py-bots"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
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
    apt-get upgrade -y
    apt-get install -y git
    apt-get install -y pip
    apt-get install -y python3-full
    git clone https://github.com/Emaydannikov/reminder.python.telegrambot.git /home/py-bot/
    cd /home/py-bot/
    pip install -r requirements.txt
    EOF
}
