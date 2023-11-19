variable "name" {
  type        = string
  description = "prefix of each resources"
}

variable "env" {
  type        = string
  description = "prefix of environment"
}

variable "vpc_cidr" {
  type        = string
  description = "vpc cidr"
}

variable "public_subnets" {
  type        = map(string)
  description = "map of subnets, key = az, value = cidr"
}

variable "app_subnets" {
  type        = map(string)
  description = "map of subnets, key = az, value = cidr"
}

variable "db_subnets" {
  type        = map(string)
  description = "map of subnets, key = az, value = cidr"
}
