variable "name" {
  type        = string
  description = "prefix of each resources"
}

variable "env" {
  type        = string
  description = "prefix of environment"
}

variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "subnet_ids" {
  type        = list(string)
  description = "for app containers and codebuild"
}

variable "allowed_ip" {
  type        = string
  description = "allow access to alb"
}
