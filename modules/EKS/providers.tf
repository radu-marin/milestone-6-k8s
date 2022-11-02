#sets the Terraform version to at least 1.2. It also sets versions for the providers used by the configuration.
provider "aws" {
    shared_credentials_files = [var.aws_credentials]
    #shared_config_files = ["~/.aws/config"]
    profile = var.aws_named_profile
    region = var.region
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15.0"
    }

    #to check if needed
    # random = {
    #   source  = "hashicorp/random"
    #   version = "3.1.0"
    # }
  }

  #commented this after getting unsupported terraform core version error when building terraform container
  #required_version = "~> 1.2.0"
}
