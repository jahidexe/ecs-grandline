####################################################### Locals ###################################################################
locals {
  common_tags = {
    Environment = var.environment
  }
}

/* 
######################################################## AWS VPC #################################################################


module "vpc" {
  source               = "./modules/vpc"
  cidr_block           = var.cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  project_name         = var.project_name
  common_tags          = local.common_tags
}

output "AWS_VPC_ID" {
  value = module.vpc.vpc_id
}



######################################################## AWS ECR #################################################################

 */



module "ecr" {
  source           = "./modules/ecr"
  project_name     = var.project_name
  ecr_scan_on_push = true
  common_tags      = local.common_tags

}

output "ECR_REPOSITORY_URL" {
  value = module.ecr.ecr_repository_url
}



/* 


######################################################## AWS ECS #################################################################
module "ecs" {
  source              = "./modules/ecs"
  region              = var.region
  vpc_id              = module.vpc.vpc_id
  ecs_task_subnets    = module.vpc.private_subnet_ids
  ecs_allowed_cidrs   = [module.vpc.vpc_cidr_block]
  project_name        = var.project_name
  image_uri           = module.ecr.ecr_repository_url
  container_image_tag = var.container_image_tag
  alb_tg_arn          = module.elb.target_group_arn
  common_tags         = local.common_tags
}


output "ECS_SERVICE_NAME" {
  value = module.ecs.ecs_service_name
}



######################################################## AWS ELB #################################################################
module "elb" {
  source       = "./modules/elb"
  vpc_id       = module.vpc.vpc_id
  subnets      = module.vpc.public_subnet_ids
  project_name = var.project_name
  common_tags  = local.common_tags
}

output "ALB_URL" {
  value = "http://${module.elb.alb_dns_name}"
}


  */
