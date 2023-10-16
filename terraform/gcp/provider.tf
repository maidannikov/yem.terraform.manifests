terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.77.0"
    }
  }
}

provider "google" {
  credentials = var.GOOGLE_APPLICATION_CREDENTIALS
  project = "midyear-gift-395510" 
  region  = "europe-east1"
  zone    = "europe-east1-b"
}
