output "region" {
    value = var.region
}

output "ebs-id" {
  value = aws_ebs_volume.ebs.id
}