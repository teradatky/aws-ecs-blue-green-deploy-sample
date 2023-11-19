# public route table
resource "aws_route_table" "public" {
  for_each = var.public_subnets
  vpc_id   = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = join("-", [var.env, var.name, "public-rtb", trimprefix(each.key, "ap-northeast-")])
  }
}

resource "aws_route_table_association" "public" {
  for_each       = var.public_subnets
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}

# app route table
resource "aws_route_table" "app" {
  for_each = var.app_subnets
  vpc_id   = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[each.key].id
  }

  tags = {
    Name = join("-", [var.env, var.name, "app-rtb", trimprefix(each.key, "ap-northeast-")])
  }
}

resource "aws_route_table_association" "app" {
  for_each       = var.app_subnets
  subnet_id      = aws_subnet.app[each.key].id
  route_table_id = aws_route_table.app[each.key].id
}

# db route table
resource "aws_route_table" "db" {
  for_each = var.db_subnets
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = join("-", [var.env, var.name, "db-rtb", trimprefix(each.key, "ap-northeast-")])
  }
}

resource "aws_route_table_association" "db" {
  for_each       = var.db_subnets
  subnet_id      = aws_subnet.db[each.key].id
  route_table_id = aws_route_table.db[each.key].id
}
