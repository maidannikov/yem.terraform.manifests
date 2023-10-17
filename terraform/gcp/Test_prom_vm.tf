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
      # This block will automatically allocate a public IP
    }
  }

  metadata = {
    ssh-keys = "emaydannikov:${var.GCPSSHKEYPUB}"
  }

  provisioner "local-exec" {
    command = <<EOT
      curl -X PUT \
           -H "Authorization: token ${var.github_token}" \
           -H "Content-Type: application/json" \
           -d '{"encrypted_value":"${self.network_interface.0.access_config.0.nat_ip}","key_id":"your_key_id"}' \
           https://api.github.com/repos/${var.github_owner}/${var.github_repo}/actions/secrets/IP_ADDRESS
    EOT
  }

  # Ensure provisioner only runs after the VM has been successfully created.
  depends_on = [google_compute_instance.vm_instance_1]
}
