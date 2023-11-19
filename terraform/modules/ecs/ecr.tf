resource "aws_ecr_repository" "main" {
  name                 = join("-", [var.env, var.name, "ecr"])
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}
