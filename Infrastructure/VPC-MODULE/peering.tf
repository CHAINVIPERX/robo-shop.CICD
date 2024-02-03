resource "aws_vpc_peering_connection" "peering" {
  count       = var.peering_request ? 1 : 0
  vpc_id      = aws_vpc.robo-vpc.id
  peer_vpc_id = var.acceptor_vpc_id == "" ? data.aws_vpc.default_vpc.id : var.acceptor_vpc_id
  auto_accept = var.acceptor_vpc_id == "" ? true : false
  tags = merge(var.common_tags, var.vpc_peering_tags,
    {
      Name = "${local.name}"
    }
  )
}

resource "aws_route" "acceptor_route" {
  route_table_id         = data.aws_route_table.default_rt.id
  count                  = var.peering_request && var.acceptor_vpc_id == "" ? 1 : 0
  destination_cidr_block = var.cidr_block
  #gateway_id                = aws_internet_gateway.robo_igw.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id

}
resource "aws_route" "public_peering" {
  route_table_id         = aws_route_table.public_rt.id
  count                  = var.peering_request && var.acceptor_vpc_id == "" ? 1 : 0
  destination_cidr_block = data.aws_vpc.default_vpc.cidr_block
  #gateway_id                = aws_internet_gateway.robo_igw.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id

}
resource "aws_route" "private_peering" {
  route_table_id         = aws_route_table.private_rt.id
  count                  = var.peering_request && var.acceptor_vpc_id == "" ? 1 : 0
  destination_cidr_block = data.aws_vpc.default_vpc.cidr_block
  #gateway_id                = aws_internet_gateway.robo_igw.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id

}
resource "aws_route" "database_peering" {
  route_table_id         = aws_route_table.database_rt.id
  count                  = var.peering_request && var.acceptor_vpc_id == "" ? 1 : 0
  destination_cidr_block = data.aws_vpc.default_vpc.cidr_block
  #gateway_id                = aws_internet_gateway.robo_igw.id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id

}
