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

output "vpn_public_ip" {
  value = module.vpn.public_ip

}
