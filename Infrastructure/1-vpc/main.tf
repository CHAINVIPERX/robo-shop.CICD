module "robo-vpc" {
  #source = "../../concepts/TERRAFORM/dev-AWS-VPC/VPC-MODULE"
  #source                = "git::github.com/CHAINVIPERX/concepts//TERRAFORM/dev-AWS-VPC/VPC-MODULE?ref=main"
  source                = "../VPC-MODULE"
  project_name          = var.project_name
  environment           = var.environment
  common_tags           = var.common_tags
  vpc_tags              = var.vpc_tags
  public_subnets_cidr   = var.public_subnets_cidr
  private_subnets_cidr  = var.private_subnets_cidr
  database_subnets_cidr = var.database_subnets_cidr
  peering_request       = var.peering_request
}
