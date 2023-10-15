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

# Update and upgrade system packages
apt-get update
apt-get upgrade -y

# Install necessary packages
apt-get install -y git python3-pip python3

# Clone the Telegram bot repository
git clone https://github.com/Emaydannikov/reminder.python.telegrambot.git /home/py-bot/

# Change directory to the bot's directory
cd /home/py-bot/

# Create config.py file with the specified content
cat <<EOF > /home/py-bot/config.py
TOKEN = "var.TBotTOKEN"
FILE_NAME = "notification.json"
EOF

# Install Python dependencies
pip3 install -r requirements.txt

# Create a systemd service file for the bot
cat <<EOF > /etc/systemd/system/my_telegram_bot.service
[Unit]
Description=My Telegram Bot Service
After=network.target

[Service]
User=YOUR_USERNAME
WorkingDirectory=/home/py-bot/
ExecStart=/usr/bin/python3 /home/py-bot/main_bot_file.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Enable and start the bot service
systemctl enable my_telegram_bot.service
systemctl start my_telegram_bot.service

}
