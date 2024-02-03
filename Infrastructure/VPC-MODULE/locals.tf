locals {
  name         = "${var.project_name}-${var.environment}"
  a_zone_names = slice(data.aws_availability_zones.a_zone.names, 0, 2)
}
