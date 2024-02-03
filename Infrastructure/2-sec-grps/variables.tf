variable "common_tags" {
  default = {
    Project     = "roboshop"
    Environment = "dev"
  }
}

variable "project_name" {
  default = "roboshop"
}
variable "sg_tags" {
  default = {}

}
variable "environment" {
  default = "dev"

}

# variable "mongodb_sg_ingress_rules" {
#   default = [

#     {
#       description = "Allow-80"
#       from_port   = 80
#       to_port     = 80
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     },
#     {
#       description = "Allow-443"
#       from_port   = 443
#       to_port     = 443
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]

#     },
#     { description = "Allow-160"
#       from_port   = 160
#       to_port     = 160
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   ]

# }
