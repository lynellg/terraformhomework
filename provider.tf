terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.30.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "terraform-gcp-424422"
  region = "us-central1"
  zone = "us-central1-a"
  credentials = "keys.json"
}

