module "vpn" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = "${local.instance_name}-openvpn"
  ami                    = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnet.default.id
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  user_data              = file("openvpn.sh")


  tags = merge(
    var.common_tags, {
      component = "vpn"
    },
    {
      Name = "${local.instance_name}-vpn"
    }
  )
}
