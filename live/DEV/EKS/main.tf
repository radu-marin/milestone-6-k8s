module "EKS" {
    source = "../../../modules/EKS"
    environment = "DEV"
    owner = "radul-terraform"
    naming = "student-r-ms-6-k8s"
    region = "eu-central-1"
    network_remote_state_bucket = "r-milestone-6-tf-state"
    network_remote_state_key = "DEV/network/terraform.tfstate"
    iam_remote_state_bucket = "r-milestone-6-tf-state"
    iam_remote_state_key = "global/iam/terraform.tfstate"
    desired_size = 0
    max_size = 2
    min_size = 0
    # max_unavailable = 0
}