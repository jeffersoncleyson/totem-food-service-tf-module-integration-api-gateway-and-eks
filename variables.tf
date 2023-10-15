# Input variable definitions

variable "region" {
  description = "AWS Region"
  type    = string
  default = "us-east-1"
}

variable "profile" {
  description = "AWS Profile"
  type    = string
}

variable "application_name" {
  description = "Application name"
  type        = string
}

variable "environment" {
  description = "Application environment"
  type        = string
}

variable "owner_team" {
  description = "Owener Application team"
  type        = string
}

variable "vpc_security_group_eks_ids" {
  description = "EKS Security Group for internal communication"
  type        = list(string)
}

variable "eks_private_subnet_ids" {
  description = "EKS Private Subnet IDs for internal communication"
  type        = list(string)
}

variable "eks_private_load_balancer_arn" {
  description = "EKS Private Load Balancer integrating with service"
  type        = string
}

variable "aws_apigatewayv2_api_restrict_api_id" {
  description = "API Gateway ID with restrict access"
  type        = string
}

variable "aws_apigatewayv2_authorizer_authorizer_id" {
  description = "API Gateway Authorizer ID"
  type        = string
}

variable "aws_apigatewayv2_vpc_link_eks_id" {
  description = "API Gateway VPC Link ID"
  type        = string
}








