# outputs
output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "app_subnet_ids" {
  value = [for subnet in aws_subnet.app : subnet.id]
}

output "db_subnet_ids" {
  value = [for subnet in aws_subnet.db : subnet.id]
}
