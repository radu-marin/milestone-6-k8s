# Milestone 6 - K8S - Terraform - aws EKS
This is my Kubernetes project for milestone 6, DevOps apprenticeship at Nagarro Romania (WIP)
***
## TASKS
Part1:  (Deploy EKS using Terraform)
- Build on the previous network module created in Terraform
- Create an EKS cluster with 2 nodes inside a node group. 
- Configure aws-auth configmap to grant access to all members of DevOps Remote Learning, including the mentors. 
- WARNING: Don't leave the clusters running. 
- Once the TF Code is validated and EKS deployment works, a single EKS cluster should be used for all of the participants. 
- Use Nagarro Jenkins to deploy the final version of EKS. (Team project)
***
## DESCRIPTION
- dual environement construction : `DEV` and `PROD` that use modules hosted in `modules` directory (please check tree diagram):
```
├── live
│   ├── DEV
│   │   ├── EKS
│   │   ├── data-storage
│   │   ├── network
│   │   └── services
│   ├── PROD
│   │   ├── data-storage
│   │   ├── network
│   │   └── services
│   └── global
│       ├── iam
│       └── s3
└── modules
    ├── EKS
    ├── data-storage
    ├── network
    └── services
```
### TERRAFORM
- ### [live/global/s3](https://github.com/radu-marin/milestone-6-k8s/tree/main/live/global/s3) 
	=> all terraform state files are contained in an s3 backend
- ### [live/global/iam](https://github.com/radu-marin/milestone-6-k8s/tree/main/live/global/iam)
	=> contains iam roles and policies for EKS cluster and Worker Nodes
- ### [modules/network](https://github.com/radu-marin/milestone-6-k8s/tree/main/modules/network)
	=> the network infrastructure consists of : 1 VPC, 2 public subnets, 2 private subnets, 1 internet gateway, 1 nat gateway, 1 public routing table, 1 private routing table; security groups: 1 sg for pub subnets, 1 sg for bastion, 1 sg for prv subnets.
- ### [modules/EKS](https://github.com/radu-marin/milestone-6-k8s/tree/main/modules/EKS)
	=> the EKS cluster module (creates cluster and worker nodes)

OBS: other modules are not constructed yet (WIP)

### JENKINS
- check [jenkinsfile](https://github.com/radu-marin/milestone-6-k8s/blob/main/Jenkinsfile (WIP) used for deployment
***


