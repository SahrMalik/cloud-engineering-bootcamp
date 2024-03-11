module "vpc" {
    source = "./modules/vpc"
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
    azs = var.azs
}

module "security" {
    source = "./modules/security"
    vpc_id = module.vpc.vpc_id
}

module "dynamo" {
    source = "./modules/dynamo"
    hash_key = "id"
    hash_key_type = "N"
}

module "servers" {
    source = "./modules/servers"
    aws_launch_template_id_lighting = module.launch_template.aws_launch_template_lighting
    aws_launch_template_id_heating = module.launch_template.aws_launch_template_heating
    aws_launch_template_id_auth = module.launch_template.aws_launch_template_auth
    aws_launch_template_id_status = module.launch_template.aws_launch_template_status
    instance_type = var.instance_type
    vpc_security_group_ids = module.security.security_group_ids
    subnet_id = module.vpc.public_subnets_ids[0]
    private_subnet_id = module.vpc.private_subnet_ids[0]
}

module "load_balancers" {
    source = "./modules/load-balancer"
    vpc_id = module.vpc.vpc_id
    security_groups = module.security.security_group_ids
    public_subnet_ids = module.vpc.public_subnets_ids
    private_subnet_ids = module.vpc.private_subnet_ids
    instance_lighting = module.servers.lighting_instance_id
    instance_heating = module.servers.heating_instance_id
    instance_status = module.servers.status_instance_id
    instance_auth = module.servers.auth_instance_id
    autoscaling_group_name_lighting = module.autoscaling.aws_autoscaling_group_lighting
    autoscaling_group_name_heating = module.autoscaling.aws_autoscaling_group_heating
    autoscaling_group_name_status = module.autoscaling.aws_autoscaling_group_status
    autoscaling_group_name_auth = module.autoscaling.aws_autoscaling_group_auth
}

module "autoscaling" {
  source = "./modules/auto-scaling"
  desired_capacity = var.desired_capacity
  max_size = var.max_size
  min_size = var.min_size
  public_subnets = module.vpc.public_subnets_ids
  private_subnets = module.vpc.private_subnet_ids
  launch_id_lighting = var.launch_template_aws_launch_template_lighting
  launch_id_heating = var.launch_template_aws_launch_template_heating
  launch_id_auth = var.launch_template_aws_launch_template_auth
  launch_id_status = var.launch_template_aws_launch_template_status
}