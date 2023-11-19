locals {
  container_name = join("-", [var.env, var.name, "container"])
}
