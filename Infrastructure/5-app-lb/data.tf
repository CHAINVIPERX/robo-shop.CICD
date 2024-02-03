data "aws_ssm_parameter" "app_lb_sg_id" {
  name = "/${var.project_name}/${var.environment}/app_lb_sg_id"
}


data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"

}