# <===========================   EKS ROLE   ===========================>
# Creake EKS IAM role
resource "aws_iam_role" "eks-iam-role" {
  name = "${var.naming}-eks-iam-role"

  path = "/"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF

  tags = {
    Name = "${var.naming}-eks-iam-role"
    Owner = var.owner
  }
}

# List of policies for EKS Role
# "AmazonEKSServicePolicy" - is it needed? https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html
locals {
  eks_policies = ["AmazonEKSClusterPolicy"]
}

# Attach policies to eks role
resource "aws_iam_role_policy_attachment" "eks-policies" {
  count = length(toset(local.eks_policies))
  policy_arn = "arn:aws:iam::aws:policy/${local.eks_policies[count.index]}"
  role    = aws_iam_role.eks-iam-role.name
}


# <===========================   EKS WORKER NODES ROLE   ===========================>
# Create Worker Nodes IAM Role
resource "aws_iam_role" "workernodes" {
  name = "${var.naming}-workernodes-iam-role"
 
  assume_role_policy = jsonencode({
   Statement = [{
    Action = "sts:AssumeRole"
    Effect = "Allow"
    Principal = {
     Service = "ec2.amazonaws.com"
    }
   }]
   Version = "2012-10-17"
  })

  tags = {
    Name = "${var.naming}-workernodes-iam-role"
    Owner = var.owner
  }

 }

# List of policies for EKS worker nodes Role 
locals {
  worker_policies = ["AmazonEKSWorkerNodePolicy", "AmazonEKS_CNI_Policy", "AmazonEC2ContainerRegistryReadOnly", "service-role/AmazonEBSCSIDriverPolicy", "AmazonSSMManagedInstanceCore"]
}

# Attach policies to workernodes role
resource "aws_iam_role_policy_attachment" "worker-policies" {
  count = length(toset(local.worker_policies)) #poate e mai bine toset chiar la def. worker_policies
  policy_arn = "arn:aws:iam::aws:policy/${local.worker_policies[count.index]}"
  role    = aws_iam_role.workernodes.name
}


