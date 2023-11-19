# public subnet
resource "aws_subnet" "public" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name = join("-", [var.env, var.name, "public-subnet", trimprefix(each.key, "ap-northeast-")])
  }
}

# app subnet
resource "aws_subnet" "app" {
  for_each          = var.app_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = join("-", [var.env, var.name, "app-subnet", trimprefix(each.key, "ap-northeast-")])
  }
}

# db subnet
resource "aws_subnet" "db" {
  for_each          = var.db_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = join("-", [var.env, var.name, "db-subnet", trimprefix(each.key, "ap-northeast-")])
  }
}
