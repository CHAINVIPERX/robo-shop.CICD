resource "aws_lb" "web_lb" {
  name               = "${local.name}-${var.tags.component}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.web_lb_sg_id.value]
  subnets            = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
  tags               = merge(var.common_tags, var.tags)
}


resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = data.aws_ssm_parameter.ladoo_certificate_arn.value

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "This is from web alb "
      status_code  = "200"
    }
  }
}


module "records" {
  source    = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_name

  records = [
    {
      name = "web-${var.environment}"
      type = "A"
      alias = {
        name    = aws_lb.web_lb.dns_name
        zone_id = aws_lb.web_lb.zone_id
      }
    }
  ]
}
