output "a_zone" {
  value = local.a_zone_names
}

output "vpc_id" {
  value = aws_vpc.robo-vpc.id

}
output "public_subnet_ids" {
  value = aws_subnet.public[*].id

}
output "private_subnet_ids" {
  value = aws_subnet.private[*].id

}
output "database_subnet_ids" {
  value = aws_subnet.database[*].id

}
