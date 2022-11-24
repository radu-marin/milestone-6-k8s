# For aws-auth
data "aws_eks_cluster_auth" "eks-cluster" {
  name = aws_eks_cluster.eks-cluster.id
}


provider "kubernetes" {
  host = aws_eks_cluster.eks-cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks-cluster.certificate_authority[0].data)
  # token = data.aws_eks_cluster_auth.eks-cluster.token
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.eks-cluster.id]
    command     = "aws"
  }
} 


resource "kubernetes_config_map" "aws-auth" {

  data = {

    "mapRoles" = <<ROLES
    - groups:
      - system:bootstrappers
      - system:nodes
      rolearn: arn:aws:iam::721078768257:role/student-r-ms-6-k8s-workernodes-iam-role
      username: system:node:{{EC2PrivateDNSName}}
ROLES

    "mapUsers" = <<USERS
    - userarn: arn:aws:iam::721078768257:user/radu.marin
      username: radu.marin
      groups:
        - system:masters
    - userarn: arn:aws:iam::721078768257:user/radu.radau
      username: radu.radau
      groups:
        - system:masters
    - userarn: arn:aws:iam::721078768257:user/adelin.popa
      username: adelin.popa
      groups:
        - system:masters
    - userarn: arn:aws:iam::721078768257:user/matei.serbanescu
      username: matei.serbanescu
      groups:
        - system:masters
    - userarn: arn:aws:iam::721078768257:user/marius.ghebuta
      username: marius.ghebuta
      groups:
        - system:masters
    - userarn: arn:aws:iam::721078768257:user/bogdan.socaciu
      username: bogdan.socaciu
      groups:
        - system:masters
    - userarn: arn:aws:iam::721078768257:user/bogdan.cimpeanu
      username: bogdan.cimpeanu
      groups:
        - system:masters
USERS
  }

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
}
