variable "cluster-name" {
  default = "levelup-tf-eks-demo"
  type    = string
}

variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "cluster_admin_principal_arn" {
  description = "IAM user or role ARN to grant EKS cluster admin access"
  type        = string
  default     = ""
}