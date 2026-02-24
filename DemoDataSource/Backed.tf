terraform {
  backend "s3" {
    bucket = "tf-state-latest"
    key    = "development/terraform.tfstate"
    region = "us-east-2"
  }
}