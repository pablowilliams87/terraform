/*
output "bucket" {
  description = "Bucket resource (for single use)."
  value       = google_storage_bucket.bucket_test
}
*/
output "name" {
  description = "Bucket name (for single use)."
  value       = google_storage_bucket.bucket_test.name
}

output "url" {
  description = "Bucket URL (for single use)."
  value       = google_storage_bucket.bucket_test.url
}