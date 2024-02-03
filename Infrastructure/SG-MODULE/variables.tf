variable "sg_name" {

}

variable "sg_tags" {
  type    = map(any)
  default = {}
}

variable "vpc_id" {

}

variable "project_name" {

}

variable "environment" {

}

variable "common_tags" {
  default = {}
  type    = map(any)
}

variable "sg_description" {
  #default = ""
  type = string
}

variable "sg_ingress_rules" {
  type    = list(any)
  default = []
}


