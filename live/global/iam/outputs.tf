output "eks_iam_role_arn" {
    description = "EKS iam role arn"
    value = aws_iam_role.eks-iam-role.arn
}

output "workernodes_iam_role_arn" {
    description = "EKS iam role arn"
    value = aws_iam_role.workernodes.arn
}