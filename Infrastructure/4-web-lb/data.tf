data "aws_ssm_parameter" "web_lb_sg_id" {
  name = "/${var.project_name}/${var.environment}/web_lb_sg_id"
}


data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"

}

data "aws_ssm_parameter" "ladoo_certificate_arn" {
  name = "/${var.project_name}/${var.environment}/ladoo_certificate_arn"

}

# data "aws_ssm_parameter" "vpc_id" {
#   name = "/${var.project_name}/${var.environment}/vpc_id"

# }

# data "aws_ssm_parameter" "catalogue_sg_id" {
#   name = "/${var.project_name}/${var.environment}/catalogue_sg_id"

# }

# data "aws_ami" "centos8" {
#   owners      = ["973714476881"]
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["Centos-8-DevOps-Practice"]

#   }

#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }


# data "aws_ssm_parameter" "app_lb_listener_arn" {

#   name = "/${var.project_name}/${var.environment}/app_lb_listener_arn"

# }


