module "vpn" {
  source         = "../SG-MODULE"
  project_name   = var.project_name
  environment    = var.environment
  vpc_id         = data.aws_vpc.default.id
  sg_name        = "vpn"
  sg_description = "description"
  #  sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "app_lb" {
  source         = "../SG-MODULE"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for APP LB"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "app-lb"
  #sg_ingress_rules = var.mongodb_sg_ingress_rules
}


module "web_lb" {
  source         = "../SG-MODULE"
  project_name   = var.project_name
  environment    = var.environment
  sg_description = "SG for WEB LB"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "web-lb"
  #sg_ingress_rules = var.mongodb_sg_ingress_rules
}


module "mongodb" {
  source         = "../SG-MODULE"
  project_name   = var.project_name
  environment    = var.environment
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "mongodb"
  sg_description = "description"
  #  sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "catalogue" {
  source         = "../SG-MODULE"
  project_name   = var.project_name
  environment    = var.environment
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "catalogue"
  sg_description = "description"
  #sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "user" {
  source         = "../SG-MODULE"
  project_name   = var.project_name
  environment    = var.environment
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "user"
  sg_description = "description"
  #sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "redis" {
  source         = "../SG-MODULE"
  project_name   = var.project_name
  environment    = var.environment
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "redis"
  sg_description = "description"
  #sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "mysql" {
  source         = "../SG-MODULE"
  project_name   = var.project_name
  environment    = var.environment
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "mysql"
  sg_description = "description"
  #sg_ingress_rules = var.mongodb_sg_ingress_rules
}
module "rabbitmq" {
  source         = "../SG-MODULE"
  project_name   = var.project_name
  environment    = var.environment
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "rabbitmq"
  sg_description = "description"
  #sg_ingress_rules = var.mongodb_sg_ingress_rules
}
module "cart" {
  source         = "../SG-MODULE"
  project_name   = var.project_name
  environment    = var.environment
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "cart"
  sg_description = "description"
  #sg_ingress_rules = var.mongodb_sg_ingress_rules
}
module "shipping" {
  source         = "../SG-MODULE"
  project_name   = var.project_name
  environment    = var.environment
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "shipping"
  sg_description = "description"
  #sg_ingress_rules = var.mongodb_sg_ingress_rules
}
module "payment" {
  source         = "../SG-MODULE"
  project_name   = var.project_name
  environment    = var.environment
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "payment"
  sg_description = "description"
  #sg_ingress_rules = var.mongodb_sg_ingress_rules
}
module "web" {
  source         = "../SG-MODULE"
  project_name   = var.project_name
  environment    = var.environment
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_name        = "web"
  sg_description = "description"
  #sg_ingress_rules = var.mongodb_sg_ingress_rules
}

resource "aws_security_group_rule" "app_lb_vpn" {
  source_security_group_id = module.vpn.sg_id

  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.app_lb.sg_id
}

resource "aws_security_group_rule" "app_lb_user" {
  source_security_group_id = module.user.sg_id

  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.app_lb.sg_id
}

resource "aws_security_group_rule" "app_lb_catalogue" {
  source_security_group_id = module.catalogue.sg_id

  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.app_lb.sg_id
}

resource "aws_security_group_rule" "app_lb_cart" {
  source_security_group_id = module.cart.sg_id

  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.app_lb.sg_id
}


resource "aws_security_group_rule" "app_lb_shipping" {
  source_security_group_id = module.shipping.sg_id

  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.app_lb.sg_id
}

resource "aws_security_group_rule" "app_lb_payment" {
  source_security_group_id = module.payment.sg_id

  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.app_lb.sg_id
}



resource "aws_security_group_rule" "app_lb_web" {
  source_security_group_id = module.web.sg_id

  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.app_lb.sg_id
}

resource "aws_security_group_rule" "web_lb_internet" {
  cidr_blocks = ["0.0.0.0/0"]
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.web_lb.sg_id
}


resource "aws_security_group_rule" "vpn_local" {
  security_group_id = module.vpn.sg_id

  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "mongodb_vpn" {
  source_security_group_id = module.vpn.sg_id

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.mongodb.sg_id
}


resource "aws_security_group_rule" "mongodb_catalogue" {
  source_security_group_id = module.catalogue.sg_id

  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
  source_security_group_id = module.user.sg_id
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = module.mongodb.sg_id
}

resource "aws_security_group_rule" "redis_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
}


resource "aws_security_group_rule" "redis_user" {
  source_security_group_id = module.user.sg_id
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_cart" {
  source_security_group_id = module.cart.sg_id
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
}

resource "aws_security_group_rule" "mysql_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.mysql.sg_id
}

resource "aws_security_group_rule" "mysql_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = module.mysql.sg_id
}


resource "aws_security_group_rule" "rabbitmq_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "catalogue_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}


resource "aws_security_group_rule" "catalogue_vpn_http" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}


# resource "aws_security_group_rule" "catalogue_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.catalogue.sg_id
# }



resource "aws_security_group_rule" "catalogue_app_lb" {
  source_security_group_id = module.app_lb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}


# resource "aws_security_group_rule" "catalogue_cart" {
#   source_security_group_id = module.cart.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.catalogue.sg_id
# }

resource "aws_security_group_rule" "user_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}


resource "aws_security_group_rule" "user_app_lb" {
  source_security_group_id = module.app_lb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}


# resource "aws_security_group_rule" "user_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.user.sg_id
# }

# resource "aws_security_group_rule" "user_payment" {
#   source_security_group_id = module.payment.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.user.sg_id
# }

resource "aws_security_group_rule" "cart_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

# resource "aws_security_group_rule" "cart_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.cart.sg_id
# }

resource "aws_security_group_rule" "cart_app_lb" {
  source_security_group_id = module.app_lb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "shipping_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.shipping.sg_id
}

# resource "aws_security_group_rule" "shipping_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.shipping.sg_id
# }

resource "aws_security_group_rule" "shipping_app_lb" {
  source_security_group_id = module.app_lb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.shipping.sg_id
}


resource "aws_security_group_rule" "payment_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.payment.sg_id
}

# resource "aws_security_group_rule" "payment_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.payment.sg_id
# }

resource "aws_security_group_rule" "payment_app_lb" {
  source_security_group_id = module.app_lb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.payment.sg_id
}



resource "aws_security_group_rule" "web_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.web.sg_id
}

resource "aws_security_group_rule" "web_internet" {
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.web.sg_id

  #  from_port         = 0
  # to_port           = 6535
  # protocol          = "-1"
}
