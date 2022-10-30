
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