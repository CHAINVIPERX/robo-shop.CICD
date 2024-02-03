resource "aws_lb" "app_lb" {
  name               = "${local.name}-${var.tags.component}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.app_lb_sg_id.value]
  subnets            = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  tags               = merge(var.common_tags, var.tags)
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "test message from load balancer"
      status_code  = "200"

    }
  }
}

module "records" {
  source    = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_name

  records = [
    {
      name = "*.app-${var.environment}"
      type = "A"
      alias = {
        name    = aws_lb.app_lb.dns_name
        zone_id = aws_lb.app_lb.zone_id
      }
    }
  ]
}

