provider "aws" {
    shared_credentials_files = [var.aws_credentials]
    profile = var.aws_named_profile
    region = var.region
}