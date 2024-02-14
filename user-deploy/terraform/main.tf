module "user" {
  source               = "../../Infrastructure/APP-MODULE"
  vpc_id               = data.aws_ssm_parameter.vpc_id.value
  component_sg_id      = data.aws_ssm_parameter.user_sg_id.value
  app_lb_listener_arn  = data.aws_ssm_parameter.app_lb_listener_arn.value
  private_subnet_ids   = local.private_subnet_ids
  iam_instance_profile = "instance_creation_shell"
  project_name         = var.project_name
  environment          = var.environment
  common_tags          = var.common_tags
  tags                 = var.tags
  zone_name            = var.zone_name
  priority_rule        = 50
  app_version          = var.app_version
  nexus_ip             = var.nexus_ip

}
