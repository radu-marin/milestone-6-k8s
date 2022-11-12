output "endpoint" {
  value = module.EKS.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = module.EKS.kubeconfig-certificate-authority-data
}

output "ebs-id" {
  value = module.EKS.ebs-id
}