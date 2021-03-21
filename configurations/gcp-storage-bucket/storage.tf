resource "google_storage_bucket" "bucket_test" {
  name          = "pw-bucket-test-2"
  location      = "US"
  force_destroy = true

}