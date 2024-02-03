resource "aws_vpc" "robo-vpc" {
  cidr_block = var.cidr_block
  #   instance_tenancy = "default"
  enable_dns_hostnames = var.dns_hostnames
  tags = merge(var.common_tags, var.vpc_tags,
    {
      Name = local.name
    }
  )
}

resource "aws_internet_gateway" "robo_igw" {
  vpc_id = aws_vpc.robo-vpc.id
  tags = merge(
    var.common_tags,
    var.igw_tags,
    {
      Name = local.name
    }
  )

}

# resource "aws_vpn_gateway" "vpn_gw" {
#   vpc_id = aws_vpc.robo-vpc.id

#   tags = {
#     Name = "${local.name}-vpn_gw"
#   }
# }


resource "aws_subnet" "public" {
  count             = length(var.public_subnets_cidr)
  vpc_id            = aws_vpc.robo-vpc.id
  cidr_block        = var.public_subnets_cidr[count.index]
  availability_zone = local.a_zone_names[count.index]
  tags = merge(
    var.common_tags, var.public_subnets_tags,
    {
      Name = "${local.name}-public-${local.a_zone_names[count.index]}"
    }
  )
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.robo-vpc.id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = local.a_zone_names[count.index]
  tags = merge(
    var.common_tags, var.private_subnets_tags,
    {
      Name = "${local.name}-private-${local.a_zone_names[count.index]}"
    }
  )
}

resource "aws_subnet" "database" {
  count             = length(var.database_subnets_cidr)
  vpc_id            = aws_vpc.robo-vpc.id
  cidr_block        = var.database_subnets_cidr[count.index]
  availability_zone = local.a_zone_names[count.index]
  tags = merge(var.common_tags, var.database_subnets_tags,
    {
      Name = "${local.name}-database-${local.a_zone_names[count.index]}"
    }
  )
}

resource "aws_db_subnet_group" "name" {
  name       = local.name
  subnet_ids = aws_subnet.database[*].id
  tags = {
  Name = "DB subnet Group" }

}

resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id
  tags = merge(var.common_tags, var.ngw_tags, {
    Name = "${local.name}"
    }
  )
  depends_on = [aws_internet_gateway.robo_igw]
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.robo-vpc.id

  tags = merge(var.common_tags, var.public_rt_tags,
    {
      Name = "${local.name}-public"
    }
  )

}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.robo-vpc.id

  tags = merge(var.common_tags, var.private_rt_tags,
    {
      Name = "${local.name}-private"
    }
  )

}


resource "aws_route_table" "database_rt" {
  vpc_id = aws_vpc.robo-vpc.id

  tags = merge(var.common_tags, var.database_rt_tags,
    {
      Name = "${local.name}-database"
    }
  )
}

# resource "aws_vpn_gateway_route_propagation" "vpn_private" {
#   vpn_gateway_id = aws_vpn_gateway.vpn_gw.id
#   route_table_id = aws_route_table.private_rt.id
# }

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.robo_igw.id
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
  # gateway_id = aws_vpn_gateway.vpn_gw.id

}


resource "aws_route" "database_route" {
  route_table_id         = aws_route_table.database_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
  # gateway_id = aws_vpn_gateway.vpn_gw.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "database" {
  count          = length(var.database_subnets_cidr)
  subnet_id      = element(aws_subnet.database[*].id, count.index)
  route_table_id = aws_route_table.database_rt.id
}

