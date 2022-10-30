# <======================   DATA SOURCES   ======================>
# Fetch 'terraform_remote_state' data to get previous network info outputs
data "terraform_remote_state" "network" {
    backend = "s3"
    config = {
        bucket = var.network_remote_state_bucket
        key = var.network_remote_state_key
        region = var.region
    }
}

# Fetch 'terraform_remote_state' data to get iam info outputs
data "terraform_remote_state" "iam" {
    backend = "s3"
    config = {
        bucket = var.iam_remote_state_bucket
        key = var.iam_remote_state_key
        region = var.region
    }
}


# <========================   EKS   ========================>
# Create EKS cluster
resource "aws_eks_cluster" "eks-cluster" {
  name = "${var.naming}-${var.environment}-eks-cluster"
  role_arn = data.terraform_remote_state.iam.outputs.eks_iam_role_arn

  vpc_config {
    subnet_ids = data.terraform_remote_state.network.outputs.prv_subnets_id
  }
  
  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  # OBS: mai are sens asta daca este intr-un modul separat?
#   depends_on = [
#     data.terraform_remote_state.iam.aws_iam_role_policy_attachment.eks-policies,
#     # aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
#     # aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
#   ]

  tags = {
    Name = "${var.naming}-${var.environment}-eks-cluster"
    Owner = "${var.owner}"
  }
}


# <======================   WORKERS   ======================>
# Create EKS Worker Nodes
resource "aws_eks_node_group" "node-group-1" {
  cluster_name  = aws_eks_cluster.eks-cluster.name
  node_group_name = "${var.naming}-${var.environment}-node-group-1"
  node_role_arn  = data.terraform_remote_state.iam.outputs.workernodes_iam_role_arn
  #aws_iam_role.workernodes.arn
  subnet_ids   = data.terraform_remote_state.network.outputs.prv_subnets_id
  instance_types = ["t2.micro"]
 
  scaling_config {
    desired_size = 2
    max_size   = 2
    min_size   = 1
  }

  update_config {
    max_unavailable = 1
  }
  
  # Need to create the aws-auth config map before
  depends_on = [
    kubernetes_config_map.aws-auth
  ]

  tags = {
    Name = "${var.naming}-${var.environment}-eks-cluster"
    Owner = "${var.owner}"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     data.terraform_remote_state.iam.aws_iam_role_policy_attachment.worker-policies,
#     # aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
#     # aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
#     # aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
#   ]
}
