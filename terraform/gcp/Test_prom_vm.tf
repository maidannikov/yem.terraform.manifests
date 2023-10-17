resource "google_compute_instance" "vm_instance_1" {
  name         = "prom-test"
  machine_type = "custom-2-2048"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
 network_interface {
    network = "default"
    access_config {
    }
  }

metadata = {
    ssh-keys = "emaydannikov:${var.GCPSSHKEYPUB}"}
}
