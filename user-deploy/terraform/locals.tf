# locals {
#   name = "${var.project_name}-${var.environment}"
#   time = formatdate("YYYY-MM-DD-hh-mm", timestamp())
# }

locals {
  private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
}

