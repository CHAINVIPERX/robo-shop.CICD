module "mongodb" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = "${local.instance_name}-mongodb"
  ami                    = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags, {
      component = "mongodb"
    },
    {
      Name = "${local.instance_name}-mongodb"
    }
  )
}

resource "null_resource" "mongodb" {

  triggers = {
    insance_id = module.mongodb.id
  }

  connection {
    host     = module.mongodb.private_ip
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb dev"
    ]

  }
}

# module "redis" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   name                   = "${local.instance_name}-redis"
#   ami                    = data.aws_ami.centos8.id
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.redis_sg_id.value]
#   subnet_id              = local.database_subnet_id

#   tags = merge(
#     var.common_tags, {
#       component = "redis"
#     },
#     {
#       Name = "${local.instance_name}-redis"
#     }
#   )
# }

# resource "null_resource" "redis" {

#   triggers = {
#     insance_id = module.redis.id
#   }

#   connection {
#     host     = module.redis.private_ip
#     type     = "ssh"
#     user     = "centos"
#     password = "DevOps321"
#   }

#   provisioner "file" {
#     source      = "bootstrap.sh"
#     destination = "/tmp/bootstrap.sh"

#   }

#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/bootstrap.sh",
#       "sudo sh /tmp/bootstrap.sh redis dev"
#     ]

#   }
# }

# module "mysql" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   name                   = "${local.instance_name}-mysql"
#   ami                    = data.aws_ami.centos8.id
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value]
#   subnet_id              = local.database_subnet_id
#   iam_instance_profile   = "instance_creation_shell"
#   tags = merge(
#     var.common_tags, {
#       component = "mysql"
#     },
#     {
#       Name = "${local.instance_name}-mysql"
#     }
#   )
# }

# resource "null_resource" "mysql" {

#   triggers = {
#     insance_id = module.mysql.id
#   }

#   connection {
#     host     = module.mysql.private_ip
#     type     = "ssh"
#     user     = "centos"
#     password = "DevOps321"
#   }

#   provisioner "file" {
#     source      = "bootstrap.sh"
#     destination = "/tmp/bootstrap.sh"

#   }

#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/bootstrap.sh",
#       "sudo sh /tmp/bootstrap.sh mysql dev"
#     ]

#   }
# }

# module "rabbitmq" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   name                   = "${local.instance_name}-rabbitmq"
#   ami                    = data.aws_ami.centos8.id
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_sg_id.value]
#   subnet_id              = local.database_subnet_id
#   iam_instance_profile   = "instance_creation_shell"
#   tags = merge(
#     var.common_tags, {
#       component = "rabbitmq"
#     },
#     {
#       Name = "${local.instance_name}-rabbitmq"
#     }
#   )
# }

# resource "null_resource" "rabbitmq" {

#   triggers = {
#     insance_id = module.rabbitmq.id
#   }

#   connection {
#     host     = module.rabbitmq.private_ip
#     type     = "ssh"
#     user     = "centos"
#     password = "DevOps321"
#   }

#   provisioner "file" {
#     source      = "bootstrap.sh"
#     destination = "/tmp/bootstrap.sh"

#   }

#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/bootstrap.sh",
#       "sudo sh /tmp/bootstrap.sh rabbitmq dev"
#     ]

#   }
# }


module "records" {
  source    = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_name

  records = [
    {
      name = "mongodb-dev"
      type = "A"
      ttl  = 300
      records = [
        module.mongodb.private_ip
      ]
    },
    # {
    #   name = "redis-dev"
    #   type = "A"
    #   ttl  = 300
    #   records = [
    #     module.redis.private_ip
    #   ]
    # },
    # {
    #   name = "mysql-dev"
    #   type = "A"
    #   ttl  = 300
    #   records = [
    #     module.mysql.private_ip
    #   ]
    # },
    # {
    #   name = "rabbitmq-dev"
    #   type = "A"
    #   ttl  = 300
    #   records = [
    #     module.rabbitmq.private_ip
    #   ]
    # },
  ]
}







































# module "redis" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   name                   = "${local.instance_name}-redis"
#   ami                    = data.aws_ami.centos8.id
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.redis_sg_id.value]
#   subnet_id              = local.database_subnet_id

#   tags = merge(
#     var.common_tags, {
#       component = "redis"
#     },
#     {
#       Name = "${local.instance_name}-redis"
#     }
#   )
# }

# module "mysql" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   name                   = "${local.instance_name}-mysql"
#   ami                    = data.aws_ami.centos8.id
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value]
#   subnet_id              = local.database_subnet_id

#   tags = merge(
#     var.common_tags, {
#       component = "mysql"
#     },
#     {
#       Name = "${local.instance_name}-mysql"
#     }
#   )
# }

# module "rabbitmq" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   name                   = "${local.instance_name}-rabbitmq"
#   ami                    = data.aws_ami.centos8.id
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_sg_id.value]
#   subnet_id              = local.database_subnet_id

#   tags = merge(
#     var.common_tags, {
#       component = "rabbitmq"
#     },
#     {
#       Name = "${local.instance_name}-rabbitmq"
#     }
#   )
# }


# module "catalogue" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   name                   = "${local.instance_name}-catalogue"
#   ami                    = data.aws_ami.centos8.id
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.catalogue_sg_id.value]
#   subnet_id              = local.private_subnet_id

#   tags = merge(
#     var.common_tags, {
#       component = "catalogue"
#     },
#     {
#       Name = "${local.instance_name}-catalogue"
#     }
#   )
# }

# module "user" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   name                   = "${local.instance_name}-user"
#   ami                    = data.aws_ami.centos8.id
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.user_sg_id.value]
#   subnet_id              = local.private_subnet_id

#   tags = merge(
#     var.common_tags, {
#       component = "user"
#     },
#     {
#       Name = "${local.instance_name}-user"
#     }
#   )
# }

# module "cart" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   name                   = "${local.instance_name}-cart"
#   ami                    = data.aws_ami.centos8.id
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.cart_sg_id.value]
#   subnet_id              = local.private_subnet_id

#   tags = merge(
#     var.common_tags, {
#       component = "cart"
#     },
#     {
#       Name = "${local.instance_name}-cart"
#     }
#   )
# }

# module "shipping" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   name                   = "${local.instance_name}-shipping"
#   ami                    = data.aws_ami.centos8.id
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.shipping_sg_id.value]
#   subnet_id              = local.private_subnet_id

#   tags = merge(
#     var.common_tags, {
#       component = "shipping"
#     },
#     {
#       Name = "${local.instance_name}-shipping"
#     }
#   )
# }

# module "payment" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   name                   = "${local.instance_name}-payment"
#   ami                    = data.aws_ami.centos8.id
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.payment_sg_id.value]
#   subnet_id              = local.private_subnet_id

#   tags = merge(
#     var.common_tags, {
#       component = "payment"
#     },
#     {
#       Name = "${local.instance_name}-payment"
#     }
#   )
# }

# module "web" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   name                   = "${local.instance_name}-web"
#   ami                    = data.aws_ami.centos8.id
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.web_sg_id.value]
#   #subnet_id              = local.public_subnet_id  #public subnet isnt connecting to internet
#   subnet_id = local.private_subnet_id

#   tags = merge(
#     var.common_tags, {
#       component = "web"
#     },
#     {
#       Name = "${local.instance_name}-web"
#     }
#   )
# }

# module "ansible" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   name                   = "${local.instance_name}-ansible"
#   ami                    = data.aws_ami.centos8.id
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
#   subnet_id              = data.aws_subnet.default.id
#   user_data              = file("inst-provision.sh")
#   tags = merge(
#     var.common_tags, {
#       component = "ansible"
#     },
#     {
#       Name = "${local.instance_name}-ansible"
#     }
#   )
# }


# module "route53_records" {
#   source    = "terraform-aws-modules/route53/aws//modules/records"
#   zone_name = var.zone_name

#   records = [
#     {
#       name = "mongodb"
#       type = "A"
#       ttl  = 300
#       records = [
#         "${module.mongodb.private_ip}"
#       ]
#     },
#     {
#       name = "redis"
#       type = "A"
#       ttl  = 300
#       records = [
#         "${module.redis.private_ip}"
#       ]
#     },
#     {
#       name = "mysql"
#       type = "A"
#       ttl  = 300
#       records = [
#         "${module.mysql.private_ip}"
#       ]
#     },
#     {
#       name = "rabbitmq"
#       type = "A"
#       ttl  = 300
#       records = [
#         "${module.rabbitmq.private_ip}"
#       ]
#     },
#     {
#       name = "user"
#       type = "A"
#       ttl  = 300
#       records = [
#         "${module.user.private_ip}"
#       ]
#     },
#     {
#       name = "cart"
#       type = "A"
#       ttl  = 300
#       records = [
#         "${module.cart.private_ip}"
#       ]
#     },
#     {
#       name = "catalogue"
#       type = "A"
#       ttl  = 300
#       records = [
#         "${module.catalogue.private_ip}"
#       ]
#     },
#     {
#       name = "shipping"
#       type = "A"
#       ttl  = 300
#       records = [
#         "${module.shipping.private_ip}"
#       ]
#     },
#     {
#       name = "payment"
#       type = "A"
#       ttl  = 300
#       records = [
#         "${module.payment.private_ip}"
#       ]
#     },
#     {
#       name = "web"
#       type = "A"
#       ttl  = 300
#       records = [
#         "${module.web.private_ip}"
#       ]
#     },
#   ]
# }
