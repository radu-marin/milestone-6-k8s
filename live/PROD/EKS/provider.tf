provider "aws" {
    # shared_credentials_files = ["path/to/credential_file"]
    # profile = "named_profile"
    region = "eu-central-1"
}

# Create S3 backend to store tfstate file
# OBS: Run the next block only after creating the s3 first 
terraform {
  backend "s3"{
    bucket = "r-milestone-6-tf-state"
    key = "PROD/EKS/terraform.tfstate"
    region = "eu-central-1" #seems var.region not allowed here !

    dynamodb_table = "r-milestone-6-tf-state-locks"
    encrypt = true
  }
}