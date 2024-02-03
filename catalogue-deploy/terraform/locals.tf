locals {
  name = "${var.project_name}-${var.environment}"
  time = formatdate("YYYY-MM-DD-hh-mm", timestamp())

}
