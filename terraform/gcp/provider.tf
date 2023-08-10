terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.77.0"
    }
  }
}

provider "google" {
  project = "midyear-gift-395510" 
  region  = "europe-central2"
  zone    = "europe-central2-a"
}
