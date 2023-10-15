resource "google_compute_instance" "vm_instance" {
  name         = "ubuntu-2004-f1"
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

# Install necessary packages
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git
sudo apt-get install -y pip
sudo apt-get install -y python3-full

# Clone the Telegram bot repository
sudo git clone https://github.com/Emaydannikov/reminder.python.telegrambot.git /home/py-bot/

# Change directory to the bot's directory
cd /home/py-bot/

# Create config.py file with the specified content
cat <<EOL > /home/py-bot/config.py
TOKEN = "${var.TBotTOKEN}" 
FILE_NAME = "notification.json"
EOL

# Install Python dependencies
sudo pip install -r requirements.txt

# Create a systemd service file for the bot
sudo tee /etc/systemd/system/my_telegram_bot.service > /dev/null <<EOL
[Unit]
Description=My Telegram Bot Service
After=network.target

[Service]
User=root
WorkingDirectory=/home/py-bot/
ExecStart=/usr/bin/python3 /home/py-bot/bot.py
Restart=always

[Install]
WantedBy=multi-user.target
EOL

# Enable and start the bot service
sudo systemctl enable my_telegram_bot.service
sudo systemctl start my_telegram_bot.service
EOF
}
