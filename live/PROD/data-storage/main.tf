module "data-storage" {
    source = "../../../modules/data-storage"
    environment = "PROD"
    owner = "radul-terraform"
    naming = "student-r-ms-6-k8s"
    region = "eu-central-1"
    ebs_az = "eu-central-1a"
    ebs_size = 10
}