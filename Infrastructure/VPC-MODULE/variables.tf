variable "cidr_block" {
  default = "10.0.0.0/24"
}
variable "dns_hostnames" {
  type    = bool
  default = true
}
variable "common_tags" {
  type    = map(any)
  default = {}
}
variable "vpc_tags" {
  type    = map(any)
  default = {}
}

variable "project_name" {
  type = string

}
variable "environment" {
  type = string
}

variable "igw_tags" {
  type    = map(any)
  default = {}
}

variable "public_subnets_cidr" {
  type = list(any)
  validation {
    condition     = length(var.public_subnets_cidr) == 2
    error_message = "Only 2 public valid subnet cidr"
  }
}

variable "private_subnets_cidr" {
  type = list(any)
  validation {
    condition     = length(var.private_subnets_cidr) == 2
    error_message = "Only 2 private valid subnet cidr"
  }
}

variable "database_subnets_cidr" {
  type = list(any)
  validation {
    condition     = length(var.database_subnets_cidr) == 2
    error_message = "Only 2 database valid subnet cidr"
  }
}

variable "public_subnets_tags" {
  default = {}
}
variable "private_subnets_tags" {
  default = {}
}
variable "database_subnets_tags" {
  default = {}
}
variable "ngw_tags" {
  default = {}
}

variable "public_rt_tags" {
  default = {}
}
variable "private_rt_tags" {
  default = {}
}
variable "database_rt_tags" {
  default = {}
}
variable "peering_request" {
  type    = bool
  default = false
}
variable "acceptor_vpc_id" {
  type    = string
  default = ""

}
variable "vpc_peering_tags" {
  default = {}

}
