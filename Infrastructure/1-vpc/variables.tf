variable "cidr_block" {
  default = "10.0.0.0/24"
}
variable "common_tags" {
  default = {
    Project     = "roboshop"
    Environment = "dev"
    Terraform   = "True"
  }
}
variable "vpc_tags" {
  default = {}

}

variable "project_name" {
  default = "roboshop"
}
variable "environment" {
  default = "dev"
}

variable "public_subnets_cidr" {
  default = ["10.0.0.0/27", "10.0.0.32/27"]

}

variable "private_subnets_cidr" {
  default = ["10.0.0.64/27", "10.0.0.128/27"]

}

variable "database_subnets_cidr" {
  default = ["10.0.0.160/27", "10.0.0.192/27"]

}

variable "peering_request" {
  default = true

}
