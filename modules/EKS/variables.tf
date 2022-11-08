variable "aws_credentials" {
    description = "Path to file with aws credentials"
    default = "~/.aws/credentials"
}

variable "aws_named_profile" {
    description = "AWS named profile for credentials"
    default = "default"
}

variable "environment" {
    description = "Environment used (DEV/PROD)"
}

variable "owner" {
    description = "Owner of deployment (Default: radul-terraform)"
    default = "radul-terraform"
}

variable "naming" {
    description = "Naming prefix of resources"
    default = "r-ms-6-k8s"
}

variable "region" {
    description = "Region to be used (Default: eu-central-1)"
    default = "eu-central-1"
}

variable "network_remote_state_bucket" {
    description = "Id of network remote state bucket"
}

variable "network_remote_state_key" {
    description = "Key of network remote state bucket (path in remote state s3 bucket)"
}

variable "iam_remote_state_bucket" {
    description = "Id of iam remote state bucket"
}

variable "iam_remote_state_key" {
    description = "Key of iam remote state bucket (path in remote state s3 bucket)"
}

variable "desired_size" {
    description = "Desired number of worker nodes (default 2)"
    default = 2
}

variable "max_size" {
    description = "Maximum number of worker nodes (default 2)"
    default = 2
}

variable "min_size" {
    description = "Minimum number of worker nodes (default 1)"
    default = 1
}

# variable "max_unavailable" {
#     description = "Desired max number of unavailable worker nodes during node group update (default 1)"
#     default = 1
# }