module "EKS" {
    source = "../../../modules/EKS"
    environment = "PROD"
    owner = "radul-terraform"
    naming = "student-r-ms-6-k8s"
    region = "eu-central-1"
    network_remote_state_bucket = "r-milestone-6-tf-state"
    network_remote_state_key = "PROD/network/terraform.tfstate"
    iam_remote_state_bucket = "r-milestone-6-tf-state"
    iam_remote_state_key = "global/iam/terraform.tfstate"
    desired_size = 2
    max_size = 2
    min_size = 1
    # max_unavailable = 1
}