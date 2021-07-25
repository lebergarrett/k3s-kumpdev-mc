terraform {
  backend "s3" {
    bucket = "kumpdev-terraform-backend"
    key    = "mc-kumpdev"
    region = "us-east-1"
  }
}