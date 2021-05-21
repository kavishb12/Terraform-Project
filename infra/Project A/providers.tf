provider "aws" {
    region = "us-west-2"
    access_key = file("../../access_key.txt")
    secret_key = file("../../secret.txt")
    
}

terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "kavishbhathija"

    # workspaces {
    #   name = "terraform-project"
    # }
  }
}