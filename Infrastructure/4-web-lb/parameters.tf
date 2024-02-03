resource "aws_ssm_parameter" "web_lb_listener_arn" {

  name  = "/${var.project_name}/${var.environment}/web_lb_listener_arn"
  value = aws_lb_listener.https.arn
  type  = "String"

}


resource "aws_ssm_parameter" "web_lb_dns_name" {

  name  = "/${var.project_name}/${var.environment}/web_lb_dns_name"
  value = aws_lb.web_lb.dns_name
  type  = "String"

}
