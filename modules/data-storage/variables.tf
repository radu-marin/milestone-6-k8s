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

variable "ebs_size" {
    description = "Size of EBS volume to be created (default: 10Gi)"
    default = 10
}

variable "ebs_az" {
    description = "Availability Zone for deployed EBS (default: eu-central-1a"
    default = "eu-central-1a"
}