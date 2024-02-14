variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project     = "roboshop"
    Environment = "dev"
  }
}

variable "zone_name" {
  default = "ladoo.shop"

}

variable "tags" {

  default = {
    component = "user"
  }

}

variable "app_version" {

}

variable "nexus_ip" {

}