module "network" {
  source   = "../../modules/network"
  name     = "ecs-bg-deploy"
  env      = "prd"
  vpc_cidr = "10.11.12.0/24"
  public_subnets = {
    ap-northeast-1a = "10.11.12.0/27"
    ap-northeast-1c = "10.11.12.32/27"
  }
  app_subnets = {
    ap-northeast-1a = "10.11.12.64/26"
    ap-northeast-1c = "10.11.12.128/26"
  }
  db_subnets = {
    ap-northeast-1a = "10.11.12.192/27"
    ap-northeast-1c = "10.11.12.224/27"
  }
}

module "ecs" {
  source     = "../../modules/ecs"
  name       = "ecs-bg-deploy"
  env        = "prd"
  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.app_subnet_ids
  allowed_ip = "0.0.0.0/0"
}
