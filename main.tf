resource "google_compute_instance" "tf_vm" {
  name         = "tf-vm"
  machine_type = "n2-standard-2"
  zone         = "asia-southeast1-a"
  allow_stopping_for_update = true
  
  network_interface {
    network = "custom-vpc-tf"
    subnetwork = "sub-sg"
  }

    scheduling {
    preemptible = false
    automatic_restart = false
}

  boot_disk {
    initialize_params {
      image = "debian-10-buster-v20240515"
      size = 35
    }
    auto_delete = false
  }

  labels = {
    env = "tflearning"
  }

  service_account {
    email = "terraform-gcp@terraform-gcp-424422.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  lifecycle {
    ignore_changes = [attached_disk]
  }
}

resource "google_compute_disk" "tf_disk1" {
  name = "tf-disk1"
  size = 15
  zone = "asia-southeast1-a"
  type = "pd-ssd"
}

resource "google_compute_attached_disk" "tfdisk1_attach" {
  disk = google_compute_disk.tf_disk1.id
  instance = google_compute_instance.tf_vm.id
}

