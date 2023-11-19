# eip
resource "aws_eip" "nat" {
  for_each = var.public_subnets
  domain   = "vpc"

  tags = {
    Name = join("-", [var.env, var.name, "nat-eip", trimprefix(each.key, "ap-northeast-")])
  }

  depends_on = [aws_internet_gateway.main]
}

# nat gateway
resource "aws_nat_gateway" "main" {
  for_each      = var.public_subnets
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = {
    Name = join("-", [var.env, var.name, "nat-gw", trimprefix(each.key, "ap-northeast-")])
  }

  depends_on = [aws_internet_gateway.main]
}
